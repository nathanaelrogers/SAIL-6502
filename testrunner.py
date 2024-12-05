import subprocess
import os
import re

def create(start_address, filepath, store_data_loc=0x0000, store_data=[]):
	# Create hi and lo bytes from the start address passed in
	address_hi_byte = start_address >> 8
	address_lo_byte = start_address & 0xFF

	# Generate list of SAIL REPL commands to store binary at start address
	commands = []

	# Store the reset vector with the given start address
	commands.append(f'write(0xFFFC, {address_lo_byte:#0{4}x})')
	commands.append(':run')
	commands.append(f'write(0xFFFD, {address_hi_byte:#0{4}x})')
	commands.append(':run')

	# Write from a binary file some program data at the given start address
	with open(f'{filepath}', 'rb') as file:
		data = file.read()
		i = start_address
		for byte in data:
			commands.append(f'write({i:#0{6}x}, {byte:#0{4}x})')
			commands.append(':run')
			i += 1

	# Put any extra data needed for test into memory
	i = store_data_loc
	for byte in store_data:
		commands.append(f'write({i:#0{6}x}, {byte:#0{4}x})')
		commands.append(':run')
		i += 1

	# Commands to run model main loop
	commands.append('main()')
	commands.append(':run')
	commands.append(':quit')

	# Write SAIL interpreter commands to file
	with open('commands.txt', 'w') as file:
		file.write('\n'.join(commands))

	# Run SAIL intepreter using the generated commands
	result = subprocess.run(['sail', '-is', 'commands.txt','main.sail'], capture_output=True)

	# Cleanup commands file
	os.remove('commands.txt')

	# Get the results
	return result.stdout.decode('UTF-8')

# ADD A BCD MODE TEST OF SOME KIND
class TestADC:
	def test_flags_normal(self):
		results = create(0x0800, 'tests/ADC/flags-normal.bin')
		expected_results = []
		expected_results.append(r'(.*ADC #\$42\n)(A: 0x42)')
		expected_results.append(r'(.*ADC #\$FF\n)(A: 0x41\n)(.*\n){4}(n: 0b0\n)(v: 0b0\n)(.*\n){3}(z: 0b0\n)(c: 0b1\n)')
		expected_results.append(r'(.*ADC #\$40\n)(A: 0x82\n)(.*\n){4}(n: 0b1\n)(v: 0b1\n)(.*\n){3}(z: 0b0\n)(c: 0b0\n)')
		expected_results.append(r'(.*ADC #\$7E\n)(A: 0x00\n)(.*\n){4}(n: 0b0\n)(v: 0b0\n)(.*\n){3}(z: 0b1\n)(c: 0b1\n)')

		for expected in expected_results:
			assert re.search(expected, results)

	def test_imm_mode(self):
		results = create(0x0800, 'tests/ADC/imm-mode.bin')
		print(results)
		expected = r'(.*ADC #\$42\n)(A: 0x42\n)(.*\n){4}(.*\n){7}(cycles: 2)'

		assert re.search(expected, results)

	def test_zp_mode(self):
		results = create(0x0800, 'tests/ADC/zp-mode.bin', store_data_loc=0x0042, store_data=[0x42])

		expected = r'(.*ADC \$42\n)(A: 0x42\n)(.*\n){4}(.*\n){7}(cycles: 3)'

		assert re.search(expected, results)

	def test_zp_x_mode(self):
		results = create(0x0800, 'tests/ADC/zp-x-mode.bin', store_data_loc=0x0042, store_data=[0x42])

		expected = r'(.*ADC \$32,X\n)(A: 0x42\n)(.*\n){4}(.*\n){7}(cycles: 4)'

		assert re.search(expected, results)

	def test_abs_mode(self):
		results = create(0x0800, 'tests/ADC/abs-mode.bin', store_data_loc=0x0042, store_data=[0x42])

		expected = r'(.*ADC \$0042\n)(A: 0x42\n)(.*\n){4}(.*\n){7}(cycles: 4)'

		assert re.search(expected, results)

	def test_abs_x_mode(self):
		# Place a 0x42 byte at each location $0042 and $0100 for using in addition. (X contains 0x10 offset)
		results = create(0x0800, 'tests/ADC/abs-x-mode.bin', store_data_loc=0x0042, store_data=([0x42] + 189 * [0xEA] + [0x42]))

		expected_results = []
		expected_results.append(r'(.*ADC \$0032,X\n)(A: 0x42\n)(.*\n){4}(.*\n){7}(cycles: 4)')
		expected_results.append(r'(.*ADC \$00F0,X\n)(A: 0x84\n)(.*\n){4}(.*\n){7}(cycles: 5)')

		for expected in expected_results:
			assert re.search(expected, results)

	def test_abs_y_mode(self):
		# Place a 0x42 byte at each location $0042 and $0100 for using in addition. (Y contains 0x10 offset)
		results = create(0x0800, 'tests/ADC/abs-y-mode.bin', store_data_loc=0x0042, store_data=([0x42] + 189 * [0xEA] + [0x42]))

		expected_results = []
		expected_results.append(r'(.*ADC \$0032,Y\n)(A: 0x42\n)(.*\n){4}(.*\n){7}(cycles: 4)')
		expected_results.append(r'(.*ADC \$00F0,Y\n)(A: 0x84\n)(.*\n){4}(.*\n){7}(cycles: 5)')

		for expected in expected_results:
			assert re.search(expected, results)

	def test_ind_x_mode(self):
		# Place a real address of $00F0 at read location $0042 (calculated by 0x32 + X). Store byte 0xFF at real address (hence the padding)
		results = create(0x0800, 'tests/ADC/ind-x-mode.bin', store_data_loc=0x0042, store_data=([0x00, 0x01] + 188 * [0xEA] + [0xFF]))

		expected = r'(.*ADC \(\$32,X\)\n)(A: 0xFF\n)(.*\n){4}(.*\n){7}(cycles: 6)'

		assert re.search(expected, results)

	def test_ind_y_mode(self):
		# Place address of $00F0 at read location $0032. Store byte 0xFF at real address $0100 (calculated by $00F0 + Y)
		results = create(0x0800, 'tests/ADC/ind-y-mode.bin', store_data_loc=0x0032, store_data=([0xF0, 0x00] + 204 * [0xEA] + [0xFF]))
		print(results)
		expected = r'(.*ADC \(\$32\),Y\n)(A: 0xFF\n)(.*\n){4}(.*\n){7}(cycles: 5)'

		assert re.search(expected, results)