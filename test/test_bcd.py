from util import load_test, run_model
import re

class TestBCD:
	def test_bcd_valid_only(self):
		load_test(start_binary=0x0000, source_file='test/sourcefiles/BCD/valid-only.s', view_memory=[0x08FF], compile_c_target=True)
		results = run_model()
		print(results)

		result = re.search(r'0x08ff: (0x\w\w)', results)
		assert result and int(result.group(1), 16) == 0x00

	def test_bcd_full(self):
		load_test(start_binary=0x0000, source_file='test/sourcefiles/BCD/full.s', view_memory=[0x08FF], compile_c_target=True)
		results = run_model()
		print(results)

		result = re.search(r'0x08ff: (0x\w\w)', results)
		assert result and int(result.group(1), 16) == 0x00