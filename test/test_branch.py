import util
import re

class TestBranch:
	def test_bcc(self):
		results = util.create(0x0800, 'test/sourcefiles/branch/bcc.s')
		print(results)

		result = re.search(util.NORMAL_PATTERN + '2', results)
		assert result
		assert int(result.group(1), 16) == 0x42
		assert int(result.group(5), 2)  == 0b0

		result = re.search(util.NORMAL_PATTERN + '3', results)
		assert result
		assert int(result.group(1), 16) == 0x41
		assert int(result.group(5), 2)  == 0b1

		result = re.search(util.NORMAL_PATTERN + '4', results)
		assert result
		assert int(result.group(1), 16) == 0x41