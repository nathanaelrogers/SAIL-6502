import subprocess
import os
import re

def create(start_address, source_file, store_data={}, generate_binary=True, view_memory=[]):
	# Create hi and lo bytes from the start address passed in
	address_hi_byte = start_address >> 8
	address_lo_byte = start_address & 0xFF

	# Generate list of SAIL REPL commands to store sary at start address
	commands = []

	# Store the reset vector with the given start address
	commands.append(f'write(0xFFFC, {address_lo_byte:#0{4}x})')
	commands.append(':run')
	commands.append(f'write(0xFFFD, {address_hi_byte:#0{4}x})')
	commands.append(':run')

	# Generate a binary file from the source code
	if generate_binary:
		subprocess.run(['acme', '-o', 'code.bin', '-f', 'plain', '--cpu', '6502', '--setpc', f'{start_address:#0{6}x}', source_file])

	# Write from the binary file the program data at the given start address
	with open(f'{"code.bin" if generate_binary else source_file}', 'rb') as file:
		data = file.read()
		i = start_address
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

class TestBranch:
	def test_bcc(self):
		results = create(0x0800, 'tests/branch/bcc.s')
		print(results)

		expected_results = []
		expected_results.append(r'(.*ADC #\$42\n)(A: 0x42)')
		expected_results.append(r'(.*ADC #\$FF\n)(A: 0x41\n)(.*\n){4}(n: 0b0\n)(v: 0b0\n)(.*\n){3}(z: 0b0\n)(c: 0b1\n)')

		banned_results = []
		banned_results.append(r'(.*SBC #\$41\n)(A: 0x00)')

		for expected in expected_results:
			assert re.search(expected, results)

		for banned in banned_results:
			assert not re.search(banned, results)

class TestBCD:
	def test_bcd_full(self):
		results = create(0x0000, 'tests/BCD/all.s', view_memory=[0x0FFF])
		print(results)

		expected = r'.*access\(main_mem, 0\), 255\)\nResult = 0x00'

		assert re.search(expected, results)

	# def test_bcd_full_against_mwerk(self):
	# 	results = create(0x0000, 'tests/BCD/all.s', view_memory=[0x0FFF])
	# 	# print(results)
		
	# 	# groups: 1=PC, 2=mnemonic, 3=A, 4=X, 5=Y, 6=SP, 7..12=nvdizc, 13=cycles for instruction
	# 	result_extract_pattern = r'0x(\w{4}) ([\w\s$#]*)\nA: 0x(\w{2})\nX: 0x(\w{2})\nY: 0x(\w{2})\nSP: 0x(\w{2})\n.*\nn: 0b(\d)\nv: 0b(\d)\n.*\nd: 0b(\d)\ni: 0b(\d)\nz: 0b(\d)\nc: 0b(\d)\ncycles: (\d).*'
	# 	result_values = []
	# 	for result in results.split('\n\n'):
	# 		result_values.append(re.match(result_extract_pattern, result))

	# 	with open('tests/BCD/all-mwerk-results.txt') as file:
	# 		samples = file.readlines()

	# 	# groups: 1=PC, 2=mnemonic, 3=A, 4=X, 5=Y, 6=SP, 7..12=nvdizc, 13=cycles for instruction
	# 	sample_extract_pattern = r'(\w{4})\s(?:\w{2}\s\w{2})\s*(\w*\s[\w#$]*)\s*\|(\w{2})\s(\w{2})\s(\w{2})\s(\w{2})\|(\d)(\d)(\d)(\d)(\d)(\d)\|(\d{1})'
	# 	sample_values = []
	# 	for sample in samples:
	# 		sample_values.append(re.match(sample_extract_pattern, sample))

	# 	assert False

class TestSubroutine:
	def test_jsr_then_rts(self):
		results = create(0x0800, 'tests/subroutines/jsr-then-rts.s')
		print(results)

		assert False

# ADD A BCD MODE TEST OF SOME KIND
class TestADC:
	def test_flags_normal(self):
		results = create(0x0800, 'tests/ADC/flags-normal.s')
		print(results)

		expected_results = []
		expected_results.append(r'(.*ADC #\$42\n)(A: 0x42)')
		expected_results.append(r'(.*ADC #\$FF\n)(A: 0x41\n)(.*\n){4}(n: 0b0\n)(v: 0b0\n)(.*\n){3}(z: 0b0\n)(c: 0b1\n)')
		expected_results.append(r'(.*ADC #\$40\n)(A: 0x82\n)(.*\n){4}(n: 0b1\n)(v: 0b1\n)(.*\n){3}(z: 0b0\n)(c: 0b0\n)')
		expected_results.append(r'(.*ADC #\$7E\n)(A: 0x00\n)(.*\n){4}(n: 0b0\n)(v: 0b0\n)(.*\n){3}(z: 0b1\n)(c: 0b1\n)')

		for expected in expected_results:
			assert re.search(expected, results)

	def test_imm_mode(self):
		results = create(0x0800, 'tests/ADC/imm-mode.s')
		print(results)

		expected = r'(.*ADC #\$42\n)(A: 0x42\n)(.*\n){4}(.*\n){7}(cycles: 2)'

		assert re.search(expected, results)

	def test_zp_mode(self):
		results = create(0x0800, 'tests/ADC/zp-mode.s', store_data={0x0042:[0x42]})
		print(results)

		expected = r'(.*ADC \$42\n)(A: 0x42\n)(.*\n){4}(.*\n){7}(cycles: 3)'

		assert re.search(expected, results)

	def test_zp_x_mode(self):
		results = create(0x0800, 'tests/ADC/zp-x-mode.s', store_data={0x0042:[0x42]})
		print(results)

		expected = r'(.*ADC \$32,X\n)(A: 0x42\n)(.*\n){4}(.*\n){7}(cycles: 4)'

		assert re.search(expected, results)

	def test_abs_mode(self):
		results = create(0x0800, 'tests/ADC/abs-mode.s', store_data={0x0042:[0x42]})
		print(results)

		expected = r'(.*ADC \$0042\n)(A: 0x42\n)(.*\n){4}(.*\n){7}(cycles: 4)'

		assert re.search(expected, results)

	def test_abs_x_mode(self):
		# Place a 0x42 byte at each location $0042 and $0100 for using in addition. (X contains 0x10 offset)
		results = create(0x0800, 'tests/ADC/abs-x-mode.s', store_data={0x0042:[0x42], 0x0100:[0x42]})
		print(results)

		expected_results = []
		expected_results.append(r'(.*ADC \$0032,X\n)(A: 0x42\n)(.*\n){4}(.*\n){7}(cycles: 4)')
		expected_results.append(r'(.*ADC \$00F0,X\n)(A: 0x84\n)(.*\n){4}(.*\n){7}(cycles: 5)')

		for expected in expected_results:
			assert re.search(expected, results)

	def test_abs_y_mode(self):
		# Place a 0x42 byte at each location $0042 and $0100 for using in addition. (Y contains 0x10 offset)
		results = create(0x0800, 'tests/ADC/abs-y-mode.s', store_data={0x0042:[0x42], 0x0100:[0x42]})
		print(results)

		expected_results = []
		expected_results.append(r'(.*ADC \$0032,Y\n)(A: 0x42\n)(.*\n){4}(.*\n){7}(cycles: 4)')
		expected_results.append(r'(.*ADC \$00F0,Y\n)(A: 0x84\n)(.*\n){4}(.*\n){7}(cycles: 5)')

		for expected in expected_results:
			assert re.search(expected, results)

	def test_ind_x_mode(self):
		# Place a real address of $0100 at read location $0042 (calculated by 0x32 + X). Store byte 0xFF at real address (hence the padding)
		results = create(0x0800, 'tests/ADC/ind-x-mode.s', store_data={0x0042:[0x00, 0x01], 0x0100:[0xFF]})
		print(results)

		expected = r'(.*ADC \(\$32,X\)\n)(A: 0xFF\n)(.*\n){4}(.*\n){7}(cycles: 6)'

		assert re.search(expected, results)

	def test_ind_y_mode(self):
		# Place address of $00F0 at read location $0032. Store byte 0xFF at real addresses $00FF and $0100 (calculated by $00F0 + Y)
		results = create(0x0800, 'tests/ADC/ind-y-mode.s', store_data={0x0032:[0xF0, 0x00], 0x00FF:[0xFF, 0xFF]})
		print(results)

		expected_results = []
		expected_results.append(r'(.*ADC \(\$32\),Y\n)(A: 0xFF\n)(.*\n){4}(.*\n){7}(cycles: 5)')
		expected_results.append(r'(.*ADC \(\$32\),Y\n)(A: 0xFE\n)(.*\n){4}(.*\n){7}(cycles: 6)')

		for expected in expected_results:
			assert re.search(expected, results)