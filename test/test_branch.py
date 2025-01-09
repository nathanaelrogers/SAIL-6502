import util
import re

class TestBranch:
	def test_bcc(self):
		results = util.create(0x0800, 'test/sourcefiles/branch/bcc.s')
		print(results)

		result = re.search(util.NORMAL_PATTERN + '1', results)
		assert result
		assert int(result.group(2), 16)  == 0x00 # A
		assert int(result.group(13), 2)  == 0b0  # c

		result = re.search(util.NORMAL_PATTERN + '2', results)
		assert result
		assert int(result.group(2), 16)  == 0x42 # A
		assert int(result.group(13), 2)  == 0b0  # c

		result = re.search(util.NORMAL_PATTERN + '3', results)
		assert result
		assert int(result.group(2), 16)  == 0x41 # A
		assert int(result.group(13), 2)  == 0b1  # c