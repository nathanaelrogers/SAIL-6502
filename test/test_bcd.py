import util
import re

class TestBCD:
	def test_clark_valid_only(self):
		results = util.create(source_file='test/sourcefiles/BCD/valid-only.s', view_memory=[0x08FF], enable_load_program=True, enable_print_dump=False)
		print(results)
		assert False