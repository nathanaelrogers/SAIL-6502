import util
import re

class TestBCD:
	def test_clark_valid_only(self):
		results = util.create(start_binary=0x0000, source_file='test/sourcefiles/BCD/valid-only.s', view_memory=[0x08FF], compile_c_target=True)
		print(results)
		assert False

	# def test_clark_full(self):
	# 	results = util.create(start_binary=0x0000, source_file='test/sourcefiles/BCD/full.s', view_memory=[0x08FF], compile_c_target=True)
	# 	print(results)
	# 	assert False