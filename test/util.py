import subprocess
import os

# GROUPS: 1=PC (THIS), 2=A, 3=X, 4=Y, 5=SP, 6=PC (NEXT), 7=n, 8=v, 9=b, 10=d, 11=i, 12=z, 13=c, 14=cycles, 15=NMI, 16=RST, 17=IRQ, 18=total cycles, 19=total instructions
NORMAL_PATTERN = r'(0x\w{4}).*\nA: (0x\w\w)\nX: (0x\w\w)\nY: (0x\w\w)\nSP: (0x\w\w)\nPC: (0x\w{4})\nn: (0b\d)\nv: (0b\d)\nb: (0b\d)\nd: (0b\d)\ni: (0b\d)\nz: (0b\d)\nc: (0b\d)\ncycles: (\d+)\nNMI: (0b\d)\nRST: (0b\d)\nIRQ: (0b\d)\n.*cycles: (\d+)\n.*instructions.*'

def create(start_binary, source_file, start_pc=None, store_data={}, generate_binary=True, view_memory=[]):
	# Create hi and lo bytes from the start pc passed in (default start of binary)
	if start_pc:
		pc_hi_byte = start_pc >> 8
		pc_lo_byte = start_pc & 0xFF
	else:
		pc_hi_byte = start_binary >> 8
		pc_lo_byte = start_binary & 0xFF

	# Generate list of SAIL REPL commands to store sary at start address
	commands = []

	# Store the reset vector with the given start address
	commands.append(f'write(0xFFFC, {pc_lo_byte:#0{4}x})')
	commands.append(':run')
	commands.append(f'write(0xFFFD, {pc_hi_byte:#0{4}x})')
	commands.append(':run')

	# Generate a binary file from the source code
	if generate_binary:
		subprocess.run(['acme', '-o', 'code.bin', '-f', 'plain', '--cpu', '6502', '--setpc', f'{start_binary:#0{6}x}', source_file])

	# Write from the binary file the program data at the given start address
	with open(f'{"code.bin" if generate_binary else source_file}', 'rb') as file:
		data = file.read()
		i = start_binary
		for byte in data:
			commands.append(f'write({i:#0{6}x}, {byte:#0{4}x})')
			commands.append(':run')
			i += 1

	# Put any extra data needed for test into memory
	for location in store_data:
		for i, byte in enumerate(store_data[location]):
			commands.append(f'write({location+i:#0{6}x}, {byte:#0{4}x})')
			commands.append(':run')

	# Commands to run model main loop
	commands.append('main()')
	commands.append(':run')

	# Look at contents of memory after we're done
	for location in view_memory:
		hi_byte = location >> 8
		lo_byte = location & 0xFF
		commands.append(f'main_mem[{hi_byte}][{lo_byte}]')
		commands.append(':run')

	# Quit the interpreter at the end
	commands.append(':quit')

	# Write SAIL interpreter commands to file
	with open('commands.txt', 'w') as file:
		file.write('\n'.join(commands))

	# Run SAIL intepreter using the generated commands
	result = subprocess.run(['sail', '-is', 'commands.txt','main.sail'], capture_output=True)

	# Cleanup commands file
	os.remove('commands.txt')
	if generate_binary:
		os.remove('code.bin')

	# Get the results
	return result.stdout.decode('UTF-8')