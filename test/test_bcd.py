from util import load_test, check_acc
import re

class TestBCD:
	def test_bcd_valid_only(self):
		results = load_test(start_binary=0x0000, source_file='test/sourcefiles/BCD/valid-only.s', view_memory=[0x08FF], compile_c_target=True)
		print(results)

		result = re.search(r'0x08ff: (0x\w\w)', results)
		assert result and check_acc(result, 0x00)

	def test_bcd_full(self):
		results = load_test(start_binary=0x0000, source_file='test/sourcefiles/BCD/full.s', view_memory=[0x08FF], compile_c_target=True)
		print(results)

		result = re.search(r'0x08ff: (0x\w\w)', results)
		assert result and check_acc(result, 0x00)