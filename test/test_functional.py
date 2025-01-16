import util
import re

class TestFunctional:
	def test_klaus_functional(self):
		results = util.create_inside_model(0x0000, 'test/sourcefiles/functional/6502_functional_test.bin', start_pc=0x0400, generate_binary=False)
		print(results)
		assert False
