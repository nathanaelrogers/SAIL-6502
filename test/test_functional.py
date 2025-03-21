from util import load_test, run_model
import re

class TestFunctional:
	def test_functional_with_bcd(self):
		load_test(start_binary=0x000a, overrided_start_pc=0x0400, source_file='test/sourcefiles/functional/6502_functional_test.bin', generate_binary=False, compile_c_target=True)
		results = run_model()
		print(results)

		result = re.search(r'trapped PC: (0x\w{4})', results)
		assert result
		assert int(result.group(1), 16) == 0x34D8

	def test_functional_no_bcd(self):
		load_test(start_binary=0x000a, overrided_start_pc=0x0400, source_file='test/sourcefiles/functional/6502_functional_test_no_bcd.bin', generate_binary=False, compile_c_target=True)
		results = run_model()
		print(results)

		result = re.search(r'trapped PC: (0x\w{4})', results)
		assert result
		assert int(result.group(1), 16) == 0x33DC