import subprocess
import os

class TestADC:
	def test_addition_manually(self):
		commands = [
			'reg_A = 0x20',
			':run',
			'execute(ADC_IMM(0x14))',
			':run',
			'reg_A',
			':run',
			':quit'
		]

	def test_addition_auto(self):
		commands = [
			':bin 0x0200, tests/ADC/imm.bin',
			'main()',
			':run',
			':quit'
		]

		# Write SAIL interpreter commands to file
		with open('commands.txt', 'w') as file:
			file.write('\n'.join(commands))

		# Run SAIL intepreter using commands
		result = subprocess.run(['sail', '-is', 'commands.txt','main.sail'], capture_output=True)

		# Cleanup commands file
		os.remove('commands.txt')

		# Do something with the results
		output = result.stdout.decode('UTF-8')
		expected = [
		]
		for item in expected:
			assert item in output