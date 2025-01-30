import re
import util

class TestCMP:
	def test_flags_normal(self):
		results = util.create(source_file='test/sourcefiles/compare/cmp-flags-normal.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result
		assert int(result.group(2), 16) == 0xFF # A
		assert int(result.group(7), 2)  == 0b1  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 2    # cycles

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result
		assert int(result.group(2), 16) == 0xFF # A
		assert int(result.group(7), 2)  == 0b1  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 3    # cycles

		result = re.search(util.DUMP_PATTERN + r'3', results)
		assert result
		assert int(result.group(2), 16) == 0xFF # A
		assert int(result.group(7), 2)  == 0b0  # n
		assert int(result.group(12), 2) == 0b1  # z
		assert int(result.group(13), 2) == 0b1  # c
		assert int(result.group(14))    == 3    # cycles

		result = re.search(util.DUMP_PATTERN + r'4', results)
		assert result
		assert int(result.group(2), 16) == 0x7F # A
		assert int(result.group(7), 2)  == 0b0  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b1  # c
		assert int(result.group(14))    == 2    # cycles

		result = re.search(util.DUMP_PATTERN + r'5', results)
		assert result
		assert int(result.group(2), 16) == 0x7F # A
		assert int(result.group(7), 2)  == 0b1  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 3    # cycles

	def test_imm_mode_cycle_count(self):
		results = util.create(source_file='test/sourcefiles/compare/cmp-imm-mode.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result
		assert int(result.group(2), 16) == 0x00 # A unaffected
		assert int(result.group(7), 2)  == 0b1  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 2    # cycles

	def test_zp_mode_cycle_count(self):
		results = util.create(source_file='test/sourcefiles/compare/cmp-zp-mode.s', store_data={0x0042:[0x42]}, enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result
		assert int(result.group(2), 16) == 0x00 # A unaffected
		assert int(result.group(7), 2)  == 0b1  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 3    # cycles

	def test_zp_x_mode_cycle_count(self):
		results = util.create(source_file='test/sourcefiles/compare/cmp-zp-x-mode.s', store_data={0x0042:[0x42]}, enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result
		assert int(result.group(2), 16) == 0x00 # A unaffected
		assert int(result.group(7), 2)  == 0b1  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 4    # cycles

	def test_abs_mode_cycle_count(self):
		results = util.create(source_file='test/sourcefiles/compare/cmp-abs-mode.s', store_data={0x0042:[0x42]}, enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result
		assert int(result.group(2), 16) == 0x00 # A unaffected
		assert int(result.group(7), 2)  == 0b1  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 4    # cycles

	def test_abs_x_mode_cycle_count(self):
		# Place a 0x42 byte at each location $0042 and $0100 for using in comparison. (X contains 0x10 offset)
		results = util.create(source_file='test/sourcefiles/compare/cmp-abs-x-mode.s', store_data={0x0042:[0x42], 0x0100:[0x42]}, enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result
		assert int(result.group(2), 16) == 0x00 # A unaffected
		assert int(result.group(7), 2)  == 0b1  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 4    # cycles

		result = re.search(util.DUMP_PATTERN + r'3', results)
		assert result
		assert int(result.group(2), 16) == 0x00 # A unaffected
		assert int(result.group(7), 2)  == 0b1  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 5    # cycles

	def test_abs_y_mode_cycle_count(self):
		# Place a 0x42 byte at each location $0042 and $0100 for using in comparison. (Y contains 0x10 offset)
		results = util.create(source_file='test/sourcefiles/compare/cmp-abs-y-mode.s', store_data={0x0042:[0x42], 0x0100:[0x42]}, enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result
		assert int(result.group(2), 16) == 0x00 # A unaffected
		assert int(result.group(7), 2)  == 0b1  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 4    # cycles

		result = re.search(util.DUMP_PATTERN + r'3', results)
		assert result
		assert int(result.group(2), 16) == 0x00 # A unaffected
		assert int(result.group(7), 2)  == 0b1  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 5    # cycles

	def test_ind_x_mode_cycle_count(self):
		# Place a real address of $0100 at read location $0042 (calculated by 0x32 + X). Store byte 0xFF at real address (hence the padding)
		results = util.create(source_file='test/sourcefiles/compare/cmp-ind-x-mode.s', store_data={0x0042:[0x00, 0x01], 0x0100:[0xFF]}, enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result
		assert int(result.group(2), 16) == 0x00 # A unaffected
		assert int(result.group(7), 2)  == 0b0  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 6    # cycles

	def test_ind_y_mode_cycle_count(self):
		# Place address of $00F0 at read location $0032. Store byte 0xFF at real addresses $00FF and $0100 (calculated by $00F0 + Y)
		results = util.create(source_file='test/sourcefiles/compare/cmp-ind-y-mode.s', store_data={0x0032:[0xF0, 0x00], 0x00FF:[0xFF, 0xFF]}, enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result
		assert int(result.group(2), 16) == 0x00 # A unaffected
		assert int(result.group(7), 2)  == 0b0  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 5    # cycles

		result = re.search(util.DUMP_PATTERN + r'4', results)
		assert result
		assert int(result.group(2), 16) == 0x00 # A unaffected
		assert int(result.group(7), 2)  == 0b0  # n
		assert int(result.group(12), 2) == 0b0  # z
		assert int(result.group(13), 2) == 0b0  # c
		assert int(result.group(14))    == 6    # cycles
