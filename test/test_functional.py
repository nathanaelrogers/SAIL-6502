import util
import re

class TestFunctional:
	def test_functional(self):
		results = util.create(start_binary=0x0000, overrided_start_pc=0x0400, source_file='test/sourcefiles/functional/6502_functional_test.bin', generate_binary=False, compile_c_target=True, enable_print_dump=True)
		print(results)
		assert False