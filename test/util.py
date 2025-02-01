import subprocess
import time
import re

# GROUPS: 1=PC (THIS), 2=A, 3=X, 4=Y, 5=SP, 6=PC (NEXT), 7=n, 8=v, 9=b, 10=d, 11=i, 12=z, 13=c, 14=cycles, 15=NMI, 16=RST, 17=IRQ, 18=total cycles
DUMP_PATTERN = r'''
(0x\w{4}).*
A: (0x\w\w)
X: (0x\w\w)
Y: (0x\w\w)
SP: (0x\w\w)
PC: (0x\w{4})
n: (0b\d)
v: (0b\d)
b: (0b\d)
d: (0b\d)
i: (0b\d)
z: (0b\d)
c: (0b\d)
cycles: (\d+)
NMI: (0b\d)
RST: (0b\d)
IRQ: (0b\d)
.*cycles: (\d+)
.*instructions: '''

def create(start_binary=0x0200, source_file=None, overrided_start_pc=None, start_sp=0xFF, start_sr=0x06, store_data={}, view_memory=[], generate_binary=True, enable_print_dump=False, enable_print_at_interval=False, compile_c_target=False) -> str:
	# Generate list of SAIL REPL commands to store sary at start address
	commands = []
	read_commands = []

	# Create commands to put any extra data needed for test into memory
	for location in store_data:
		for i, byte in enumerate(store_data[location]):
			commands.append(f'write({location+i:#0{6}x}, {byte:#0{4}x});')

	# Commands to look at contents of memory after we're done
	for location in view_memory:
		hi_byte = location >> 8
		lo_byte = location & 0xFF
		read_commands.append(f'print_bits(\"{location:#0{6}x}: \", main_mem[{hi_byte}][{lo_byte}]);')

	# Commands to initialise registers
	commands.append(f'reg_SR[all] = {start_sr:#0{4}x};')
	commands.append(f'reg_SP = {start_sp:#0{4}x};')

	# Generate a binary file from the source code
	if generate_binary:
		subprocess.run(['acme', '-o', 'code.bin', '-f', 'plain', '--cpu', '6502', '--setpc', f'{start_binary:#0{6}x}', source_file])

	# Create commands to write from the binary file the program data at the given start address
	with open(f'{"code.bin" if generate_binary else source_file}', 'rb') as file:
		data = file.read()
		i = start_binary
		for byte in data:
			commands.append(f'write({i:#0{6}x}, {byte:#0{4}x});')
			i += 1

	# Commands to directly overwrite the PC or rely on the program-stored one
	if overrided_start_pc:
		commands.append(f'reg_PC = {overrided_start_pc:#0{6}x};')
	else:
		commands.append(f'reg_PC[15..8] = read(RST_vec + 1);')
		commands.append(f'reg_PC[7..0]  = read(RST_vec);')

	# Make a Sail function to load the program when the compiled model is launched
	with open('config.sail', 'w') as file:
		if enable_print_at_interval:
			file.write('register enable_print_at_interval : bool = true\n')
		else:
			file.write('register enable_print_at_interval : bool = false\n')
		if enable_print_dump:
			file.write('register enable_print_dump   : bool = true\n')
		else:
			file.write('register enable_print_dump   : bool = false\n')
		if view_memory:
			file.write('register enable_print_mem    : bool = true\n')
		else:
			file.write('register enable_print_mem    : bool = false\n')

		file.write('val print_memory : (unit) -> unit\n')
		file.write('function print_memory() = {\n')
		if read_commands:
			file.write('\n'.join(read_commands))
		else:
			file.write('print_endline("");')
		file.write('\n}')
		file.write('\n\n')
		file.write('val load_config : (unit) -> unit\n')
		file.write('function load_config() = {\n')
		file.write('\n'.join(commands))
		file.write('\n}')


	# Get the results
	if compile_c_target:
		# Compile and run the model
		subprocess.run(['make', 'clean'])
		subprocess.run(['make'])
		start = time.time()
		result = subprocess.run(['./out'], capture_output=True)
		end= time.time()
		print('execution time of C program', end - start)
	else:
		with open('commands.txt', 'w') as file:
			file.write('main()\n')
			file.write(':run\n')

		# Run the model using the REPL
		start = time.time()
		result = subprocess.run(['sail', '-is', 'commands.txt','main.sail'], capture_output=True)
		end = time.time()
		print('execution time of REPL', end - start)

	# Get the results
	return result.stdout.decode('UTF-8')