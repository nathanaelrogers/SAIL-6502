import subprocess
import os

# CURRENTLY ONLY WORKS ON PAGE ALIGNED START ADDRESSES
def create(start_address, filepath):
	# Create hi and lo bytes from the start address passed in
	address_hi_byte = f'{start_address[:4]}'
	address_lo_byte = f'0x{start_address[4:]}'

	# Generate list of SAIL REPL commands to store binary at start address
	commands = []

	# Store the reset vector with the given start address
	commands.append(f'write(0xFFFC, {address_lo_byte})')
	commands.append(':run')
	commands.append(f'write(0xFFFD, {address_hi_byte})')
	commands.append(':run')

	# Write from a binary file some program data at the given start address
	with open(f'{filepath}', 'rb') as file:
		data = file.read()
		i = int(address_hi_byte, 16)
		while (data):
			for j, byte in enumerate(data[:256]):
				commands.append(f'write({i:#0{4}x}{j:#0{2}}, {byte:#0{4}x})')
				commands.append(':run')
			data = data[256:]
			i += 1

	# Commands to run model main loop and exit
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


class TestADC:
	def test_adc_imm(self):
		results = create(start_address='0x0200', filepath='tests/ADC/imm.bin')
		print(results)

		expected = [
			'djgkndfkjbndjk'
		]

		# Check the results
		for item in expected:
			assert item in results