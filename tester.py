import subprocess
import os

class TestADC:
	def test_standard_addition(self):
		# Write SAIL interpreter commands to file
		with open('commands.txt', 'w') as file:
			file.write('access(reg(A)) = 0x20\n')
			file.write(':run\n')
			file.write('execute(ADC_IMM(0x14))\n')
			file.write(':run\n')
			file.write('access(reg(A))\n')
			file.write(':run\n')
			file.write(':quit')

		# Run SAIL intepreter using commands
		result = subprocess.run(['sail', '-is', 'commands.txt','main.sail'], capture_output=True)

		# Cleanup commands file
		os.remove('commands.txt')

		# Do something with the results
		output = result.stdout.decode('UTF-8')
		assert 'Result = 0x34' in output