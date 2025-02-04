import util
import re

class TestFunctional:
	def test_functional(self):
		results = util.create(start_binary=0x000a, overrided_start_pc=0x0400, source_file='test/sourcefiles/functional/6502_functional_test.bin', generate_binary=False, compile_c_target=True, enable_break_at_trap=True)
		print(results)

		result = re.search(r'trapped PC: (0x\w{4})', results)
		assert result
		assert int(result.group(1), 16) == 0x34D8