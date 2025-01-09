import util
import re

class TestBCD:
	def test_clark_valid_only(self):
		results = util.create(0x0000, 'test/sourcefiles/BCD/valid-only.s', view_memory=[0x08FF])
		print(results)

		result  = re.search(r'.*access\(main_mem, 0\), 255\)\nResult = (0x\d\d)', results)
		assert result
		assert int(result.group(1), 16) == 0x00