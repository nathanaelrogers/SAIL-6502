import subprocess
import time
import re
from re import Match

# GROUPS: 1=PC (THIS), 2=A, 3=X, 4=Y, 5=SP, 6=PC (NEXT), 7=n, 8=v, 9=b, 10=d, 11=i, 12=z, 13=c, 14=cycles, 15=total cycles
SPEC_PATTERN = r'''
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
.*cycles: (\d+)
.*instructions: '''

EMU_PATTERN = r'''
(0x\w+)
A: (\w+)
X: (\w+)
Y: (\w+)
SP: (\w+)
PC: (\w+)
n: (\d)
v: (\d)
b: (\d)
d: (\d)
i: (\d)
z: (\d)
c: (\d)
cycles: (\d+)
.*cycles: (\d+)
.*instructions: '''

def match_instr_spec(dump: str, i: int) -> Match:
	return re.search(SPEC_PATTERN + f'{i}', dump)

def match_instr_emu(dump: str, i: int) -> Match:
	return re.search(EMU_PATTERN + f'{i}', dump)

def check_start_pc(m: Match, x: int) -> bool:
	return int(m.group(1), 16) == x

def get_start_pc(m: Match):
	return int(m.group(1), 16)

def check_acc(m: Match, x: int) -> bool:
	return int(m.group(2), 16) == x

def get_acc(m: Match):
	return int(m.group(2), 16)

def check_x(m: Match, x: int) -> bool:
	return int(m.group(3), 16) == x

def get_x(m: Match):
	return int(m.group(3), 16)

def check_y(m: Match, x: int) -> bool:
	return int(m.group(4), 16) == x

def get_y(m: Match):
	return int(m.group(4), 16)

def check_sp(m: Match, x: int) -> bool:
	return int(m.group(5), 16) == x

def get_sp(m: Match):
	return int(m.group(5), 16)

def check_pc(m: Match, x: int) -> bool:
	return int(m.group(6), 16) == x

def get_pc(m: Match):
	return int(m.group(6), 16)

def check_n(m: Match, x: int) -> bool:
	return int(m.group(7), 2) == x

def get_n(m: Match):
	return int(m.group(7), 2)

def check_v(m: Match, x: int) -> bool:
	return int(m.group(8), 2) == x

def get_v(m: Match):
	return int(m.group(8), 2)

def check_b(m: Match, x: int) -> bool:
	return int(m.group(9), 2) == x

def get_b(m: Match):
	return int(m.group(9), 2)

def check_d(m: Match, x: int) -> bool:
	return int(m.group(10), 2) == x

def get_d(m: Match):
	return int(m.group(10), 2)

def check_i(m: Match, x: int) -> bool:
	return int(m.group(11), 2) == x

def get_i(m: Match):
	return int(m.group(11), 2)

def check_z(m: Match, x: int) -> bool:
	return int(m.group(12), 2) == x

def get_z(m: Match):
	return int(m.group(12), 2)

def check_c(m: Match, x: int) -> bool:
	return int(m.group(13), 2) == x

def get_c(m: Match):
	return int(m.group(13), 2)

def check_cycles(m: Match, x: int) -> bool:
	return int(m.group(14)) == x

def get_cycles(m: Match):
	return int(m.group(14))

def check_total_cycles(m: Match, x: int) -> bool:
	return int(m.group(15)) == x

def get_total_cycles(m: Match):
	return int(m.group(15))

def load_test(start_binary=0x0200, source_file=None, overrided_start_pc=None, store_data={}, view_memory=[], generate_binary=True, enable_print_dump=False, enable_print_at_interval=False, enable_break_at_trap=True, compile_c_target=False) -> str:
	# Generate list of SAIL REPL commands to store sary at start address
	commands = []
	read_commands = []

	# Create commands to put any extra data needed for test into memory
	for location in store_data:
		for i, byte in enumerate(store_data[location]):
			commands.append(f'write({location+i:#0{6}x}, {byte:#0{4}x});')

	# Commands to look at contents of memory after we're done
	for location in view_memory:
		read_commands.append(f'print_bits(\"{location:#0{6}x}: \", read({location:#0{6}x}));')

	# Generate a binary file from the source code
	if generate_binary:
		subprocess.run(['acme', '-o', 'code.bin', '-f', 'plain', '--cpu', '6502', '--setpc', f'{start_binary:#0{6}x}', source_file])

	# Create commands to write from the binary file the program data at the given start address
	commands.append(f'load_binary(\"{"code.bin" if generate_binary else source_file}\", unsigned({start_binary:#0{6}x}));')

	# Commands to directly overwrite the PC or rely on the program-stored one
	if overrided_start_pc:
		commands.append(f'reg_PC = {overrided_start_pc:#0{6}x};')

	# Make a Sail function to load the program when the compiled model is launched
	with open('sail_src/config.sail', 'w') as file:
		if enable_print_at_interval:
			file.write('register enable_print_at_interval : bool = true\n')
		else:
			file.write('register enable_print_at_interval : bool = false\n')
		if enable_print_dump:
			file.write('register enable_print_dump        : bool = true\n')
		else:
			file.write('register enable_print_dump        : bool = false\n')
		if enable_break_at_trap:
			file.write('register enable_break_at_trap     : bool = true\n')
		else:
			file.write('register enable_break_at_trap     : bool = false\n')
		if view_memory:
			file.write('register enable_print_mem         : bool = true\n')
		else:
			file.write('register enable_print_mem         : bool = false\n')

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


	# Compile the model / write the commands to file
	if compile_c_target:
		subprocess.run(['make', 'clean'])
		subprocess.run(['make'])
	else:
		with open('commands.txt', 'w') as file:
			file.write('main()\n')
			file.write(':run\n')
			file.write(':quit')

	# Done
	return

def run_model(use_repl=False):
	if use_repl:
		start = time.time()
		result = subprocess.run(['sail', '-is', 'commands.txt','main.sail'], capture_output=True)
		end = time.time()
		print('execution time of REPL', end - start)
		return result.stdout.decode('UTF-8')
	else:
		start = time.time()
		result = subprocess.run(['./out'], capture_output=True)
		end= time.time()
		print('execution time of C program', end - start)
		return result.stdout.decode('UTF-8')