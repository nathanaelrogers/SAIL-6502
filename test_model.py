import subprocess
import os
import re

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

class TestKlaus:
	def test_functional(self):
		results = create(0x0000, 'tests/klaus/6502_functional_test.bin', start_pc=0x0400, generate_binary=False)
		print(results)
		assert False

class TestBranch:
	def test_bcc(self):
		results = create(0x0800, 'tests/branch/bcc.s')
		print(results)

		result = re.search(NORMAL_PATTERN + '2', results)
		assert result
		assert int(result.group(1), 16) == 0x42
		assert int(result.group(5), 2) == 0b0

		result = re.search(NORMAL_PATTERN + '3', results)
		assert result
		assert int(result.group(1), 16) == 0x41
		assert int(result.group(5), 2) == 0b1

		result = re.search(NORMAL_PATTERN + '4', results)
		assert result
		assert int(result.group(1), 16) == 0x41

class TestBCD:
	def test_bcd_full(self):
		results = create(0x0000, 'tests/clark/valid-only.s', view_memory=[0x08FF])
		print(results)

		result  = re.search(r'.*access\(main_mem, 0\), 255\)\nResult = (0x\d\d)', results)
		assert result
		assert int(result.group(1), 16) == 0x00

class TestSubroutine:
	def test_jsr_then_rts(self):
		results = create(0x0800, 'tests/subroutines/jsr-then-rts.s')
		print(results)

		assert False

class TestADC:
	def test_flags_normal(self):
		results = create(0x0800, 'tests/ADC/flags-normal.s')
		print(results)

		result = re.search(NORMAL_PATTERN + r'1', results)
		print(NORMAL_PATTERN + r'1')
		assert result
		assert int(result.group(2), 16) == 0x42 # A
		assert int(result.group(7), 2) == 0b0   # n
		assert int(result.group(8), 2) == 0b0   # v
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c

		result = re.search(NORMAL_PATTERN + r'2', results)
		assert result
		assert int(result.group(2), 16) == 0x41 # A
		assert int(result.group(7), 2)  == 0b0  # n
		assert int(result.group(8), 2)  == 0b0  # v
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b1  # c

		result = re.search(NORMAL_PATTERN + r'3', results)
		assert result
		assert int(result.group(2), 16) == 0x82 # A
		assert int(result.group(7), 2)  == 0b1  # n
		assert int(result.group(8), 2)  == 0b1  # v
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c

		result = re.search(NORMAL_PATTERN + r'4', results)
		assert result
		assert int(result.group(2), 16) == 0x00 # A
		assert int(result.group(7), 2)  == 0b0  # n
		assert int(result.group(8), 2)  == 0b0  # v
		assert int(result.group(12), 2) == 0b1  # z
		assert int(result.group(13), 2) == 0b1  # c

	def test_imm_mode(self):
		results = create(0x0800, 'tests/ADC/imm-mode.s')
		print(results)

		result = re.search(NORMAL_PATTERN + r'1', results)
		assert result
		assert int(result.group(2), 16) == 0x42 # A
		assert int(result.group(14))    == 2    # cycles

	def test_zp_mode(self):
		results = create(0x0800, 'tests/ADC/zp-mode.s', store_data={0x0042:[0x42]})
		print(results)

		result = re.search(NORMAL_PATTERN + r'1', results)
		assert result 
		assert int(result.group(2), 16) == 0x42 # A
		assert int(result.group(14))    == 3    # cycles

	def test_zp_x_mode(self):
		results = create(0x0800, 'tests/ADC/zp-x-mode.s', store_data={0x0042:[0x42]})
		print(results)

		result = re.search(NORMAL_PATTERN + r'2', results)
		assert result
		assert int(result.group(2), 16) == 0x42 # A
		assert int(result.group(14))    == 4    # cycles

	def test_abs_mode(self):
		results = create(0x0800, 'tests/ADC/abs-mode.s', store_data={0x0042:[0x42]})
		print(results)

		result = re.search(NORMAL_PATTERN + r'1', results)
		assert result
		assert int(result.group(2), 16) == 0x42 # A
		assert int(result.group(14))    == 4    # cycles

	def test_abs_x_mode(self):
		# Place a 0x42 byte at each location $0042 and $0100 for using in addition. (X contains 0x10 offset)
		results = create(0x0800, 'tests/ADC/abs-x-mode.s', store_data={0x0042:[0x42], 0x0100:[0x42]})
		print(results)

		result = re.search(NORMAL_PATTERN + r'2', results)
		assert result
		assert int(result.group(2), 16) == 0x42 # A
		assert int(result.group(14))    == 4    # cycles

		result = re.search(NORMAL_PATTERN + r'3', results)
		assert result
		assert int(result.group(2), 16) == 0x84 # A
		assert int(result.group(14))    == 5    # cycles

	def test_abs_y_mode(self):
		# Place a 0x42 byte at each location $0042 and $0100 for using in addition. (Y contains 0x10 offset)
		results = create(0x0800, 'tests/ADC/abs-y-mode.s', store_data={0x0042:[0x42], 0x0100:[0x42]})
		print(results)

		result = re.search(NORMAL_PATTERN + r'2', results)
		assert result
		assert int(result.group(2), 16) == 0x42 # A
		assert int(result.group(14))    == 4    # cycles

		result = re.search(NORMAL_PATTERN + r'3', results)
		assert result
		assert int(result.group(2), 16) == 0x84 # A
		assert int(result.group(14))    == 5    # cycles

	def test_ind_x_mode(self):
		# Place a real address of $0100 at read location $0042 (calculated by 0x32 + X). Store byte 0xFF at real address (hence the padding)
		results = create(0x0800, 'tests/ADC/ind-x-mode.s', store_data={0x0042:[0x00, 0x01], 0x0100:[0xFF]})
		print(results)

		result = re.search(NORMAL_PATTERN + r'2', results)
		assert result
		assert int(result.group(2), 16) == 0xFF # A
		assert int(result.group(14))    == 6    # cycles

	def test_ind_y_mode(self):
		# Place address of $00F0 at read location $0032. Store byte 0xFF at real addresses $00FF and $0100 (calculated by $00F0 + Y)
		results = create(0x0800, 'tests/ADC/ind-y-mode.s', store_data={0x0032:[0xF0, 0x00], 0x00FF:[0xFF, 0xFF]})
		print(results)

		result = re.search(NORMAL_PATTERN + r'2', results)
		assert result
		assert int(result.group(2), 16) == 0xFF # A
		assert int(result.group(14))    == 5    # cycles

		result = re.search(NORMAL_PATTERN + r'4', results)
		assert result
		assert int(result.group(2), 16) == 0xFE # A
		assert int(result.group(14))    == 6    # cycles