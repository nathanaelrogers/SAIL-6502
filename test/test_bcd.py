import util
import re

class TestBCD:
	def test_clark_valid_only(self):
		results = util.create_inside_model(0x0000, 'test/sourcefiles/BCD/valid-only.s', view_memory=[0x08FF])
		assert False