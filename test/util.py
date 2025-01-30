import subprocess
import os
import time

# GROUPS: 1=PC (THIS), 2=A, 3=X, 4=Y, 5=SP, 6=PC (NEXT), 7=n, 8=v, 9=b, 10=d, 11=i, 12=z, 13=c, 14=cycles, 15=NMI, 16=RST, 17=IRQ, 18=total cycles
DUMP_PATTERN = r'(0x\w{4}).*\nA: (0x\w\w)\nX: (0x\w\w)\nY: (0x\w\w)\nSP: (0x\w\w)\nPC: (0x\w{4})\nn: (0b\d)\nv: (0b\d)\nb: (0b\d)\nd: (0b\d)\ni: (0b\d)\nz: (0b\d)\nc: (0b\d)\ncycles: (\d+)\nNMI: (0b\d)\nRST: (0b\d)\nIRQ: (0b\d)\n.*cycles: (\d+)\n.*instructions: '

def create(start_binary=0x0000, source_file=None, start_pc=None, store_data={}, generate_binary=True, view_memory=[], enable_print_dump=False, enable_load_program=False) -> str:
	# Create hi and lo bytes from the start pc passed in (default start of binary)
	if start_pc:
		pc_hi_byte = start_pc >> 8
		pc_lo_byte = start_pc & 0xFF
	else:
		pc_hi_byte = start_binary >> 8
		pc_lo_byte = start_binary & 0xFF

	# Generate list of SAIL REPL commands to store sary at start address
	commands = []
	read_commands = []

	# Create commands to store the reset vector with the given start address
	if enable_load_program:
		commands.append(f'write(0xFFFC, {pc_lo_byte:#0{4}x});')
		commands.append(f'write(0xFFFD, {pc_hi_byte:#0{4}x});')
	else:
		commands.append(f'write(0xFFFC, {pc_lo_byte:#0{4}x})')
		commands.append(':run')
		commands.append(f'write(0xFFFD, {pc_hi_byte:#0{4}x})')
		commands.append(':run')

	# Generate a binary file from the source code
	if generate_binary:
		subprocess.run(['acme', '-o', 'code.bin', '-f', 'plain', '--cpu', '6502', '--setpc', f'{start_binary:#0{6}x}', source_file])

	# Create commands to write from the binary file the program data at the given start address
	with open(f'{"code.bin" if generate_binary else source_file}', 'rb') as file:
		data = file.read()
		i = start_binary
		for byte in data:
			if enable_load_program:
				commands.append(f'write({i:#0{6}x}, {byte:#0{4}x});')
			else:
				commands.append(f'write({i:#0{6}x}, {byte:#0{4}x})')
				commands.append(':run')
			i += 1

	# Create commands to put any extra data needed for test into memory
	for location in store_data:
		for i, byte in enumerate(store_data[location]):
			if enable_load_program:
				commands.append(f'write({location+i:#0{6}x}, {byte:#0{4}x});')
			else:
				commands.append(f'write({location+i:#0{6}x}, {byte:#0{4}x})')
				commands.append(':run')

	# Commands to run model main loop in repl
	if not enable_load_program:
		commands.append('main()')
		commands.append(':run')

	# Commands to look at contents of memory after we're done
	for location in view_memory:
		hi_byte = location >> 8
		lo_byte = location & 0xFF
		if enable_load_program:
			read_commands.append(f'print_bits(\"{location:#0{6}x}: \", main_mem[{hi_byte}][{lo_byte}]);')
		else:
			commands.append(f'main_mem[{hi_byte}][{lo_byte}]')
			commands.append(':run')

	# Command to quit the interpreter at the end
	if not enable_load_program:
		commands.append(':quit')

	# Write SAIL interpreter commands to file
	with open('commands.txt', 'w') as file:
		file.write('\n'.join(commands))

	# Make a Sail function to load the program when the compiled model is launched
	with open('program.sail', 'w') as file:
		if enable_print_dump:
			file.write('register enable_print_dump   : bool = true\n')
		else:
			file.write('register enable_print_dump   : bool = false\n')
		if view_memory:
			file.write('register enable_print_mem    : bool = true\n')
		else:
			file.write('register enable_print_mem    : bool = false\n')
		if enable_load_program:
			file.write('register enable_load_program : bool = true\n')
			file.write('val print_memory : (unit) -> unit\n')
			file.write('function print_memory() = {\n')
			if read_commands:
				file.write('\n'.join(read_commands))
			else:
				file.write('print_endline("");')
			file.write('\n}')
			file.write('\n\n')
			file.write('val load_program : (unit) -> unit\n')
			file.write('function load_program() = {\n')
			file.write('\n'.join(commands))
			file.write('\n}')
		else:
			# Replace Sail function to load the program with a dummy
			file.write('register enable_load_program : bool = false\n')
			file.write('val print_memory : (unit) -> unit\n')
			file.write('function print_memory() = {\n')
			file.write('print_endline("");')
			file.write('\n}')
			file.write('\n\n')
			file.write('val load_program : (unit) -> unit\n')
			file.write('function load_program() = {\n')
			file.write('print_endline("");')
			file.write('\n}')


	# Get the results
	if enable_load_program:
		# Compile and run the model
		subprocess.run(['make', 'clean'])
		subprocess.run([
			'sail', '-c', 'main.sail', '-o', 'out',
			'--variable', f'enable_print_dump={"true" if enable_print_dump else "false"}',
			'--variable', f'enable_print_mem={"true" if view_memory else "false"}',
			'--variable', f'enable_load_program={"true" if enable_load_program else "false"}',])
		subprocess.run(['make', 'compile-only'])
		start = time.time()
		result = subprocess.run(['./out'], capture_output=True)
		end= time.time()
		print('execution time of C program', end - start)
	else:
		# Run the model using the REPL
		result = subprocess.run([
			'sail', '-is', 'commands.txt','main.sail',
			'--variable', f'enable_print_dump={"true" if enable_print_dump else "false"}',
			'--variable', f'enable_print_mem={"true" if view_memory else "false"}',
			'--variable', f'enable_load_program={"true" if enable_load_program else "false"}',
			], capture_output=True)

	# Get the results
	return result.stdout.decode('UTF-8')