import util
import re

class TestCycles:
	def test_adc_cycle_count(self):
		results = util.create(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/adc.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result
		assert int(result.group(14)) == 2

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result 
		assert int(result.group(14)) == 3

		result = re.search(util.DUMP_PATTERN + r'4', results)
		assert result
		assert int(result.group(14)) == 4

		result = re.search(util.DUMP_PATTERN + r'5', results)
		assert result
		assert int(result.group(14)) == 4

		result = re.search(util.DUMP_PATTERN + r'7', results)
		assert result
		assert int(result.group(14)) == 4

		result = re.search(util.DUMP_PATTERN + r'8', results)
		assert result
		assert int(result.group(14)) == 5

		result = re.search(util.DUMP_PATTERN + r'10', results)
		assert result
		assert int(result.group(14)) == 4

		result = re.search(util.DUMP_PATTERN + r'11', results)
		assert result
		assert int(result.group(14)) == 5

		result = re.search(util.DUMP_PATTERN + r'17', results)
		assert result
		assert int(result.group(14)) == 6

		result = re.search(util.DUMP_PATTERN + r'23', results)
		assert result
		assert int(result.group(14)) == 5

		result = re.search(util.DUMP_PATTERN + r'25', results)
		assert result
		assert int(result.group(14)) == 6

	def test_sbc_cycle_count(self):
		results = util.create(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/sbc.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result
		assert int(result.group(14))    == 2

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result 
		assert int(result.group(14))    == 3

		result = re.search(util.DUMP_PATTERN + r'4', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'5', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'7', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'8', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'10', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'11', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'17', results)
		assert result
		assert int(result.group(14))    == 6

		result = re.search(util.DUMP_PATTERN + r'23', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'25', results)
		assert result
		assert int(result.group(14))    == 6

	def test_and_cycle_count(self):
		results = util.create(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/and.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result
		assert int(result.group(14))    == 2

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result 
		assert int(result.group(14))    == 3

		result = re.search(util.DUMP_PATTERN + r'4', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'5', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'7', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'8', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'10', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'11', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'17', results)
		assert result
		assert int(result.group(14))    == 6

		result = re.search(util.DUMP_PATTERN + r'23', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'25', results)
		assert result
		assert int(result.group(14))    == 6

	def test_ora_cycle_count(self):
		results = util.create(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/ora.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result
		assert int(result.group(14))    == 2

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result 
		assert int(result.group(14))    == 3

		result = re.search(util.DUMP_PATTERN + r'4', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'5', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'7', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'8', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'10', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'11', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'17', results)
		assert result
		assert int(result.group(14))    == 6

		result = re.search(util.DUMP_PATTERN + r'23', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'25', results)
		assert result
		assert int(result.group(14))    == 6

	def test_eor_cycle_count(self):
		results = util.create(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/eor.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result
		assert int(result.group(14))    == 2

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result 
		assert int(result.group(14))    == 3

		result = re.search(util.DUMP_PATTERN + r'4', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'5', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'7', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'8', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'10', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'11', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'17', results)
		assert result
		assert int(result.group(14))    == 6

		result = re.search(util.DUMP_PATTERN + r'23', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'25', results)
		assert result
		assert int(result.group(14))    == 6

	def test_cmp_cycle_count(self):
		results = util.create(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/cmp.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result
		assert int(result.group(14))    == 2

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result 
		assert int(result.group(14))    == 3

		result = re.search(util.DUMP_PATTERN + r'4', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'5', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'7', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'8', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'10', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'11', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'17', results)
		assert result
		assert int(result.group(14))    == 6

		result = re.search(util.DUMP_PATTERN + r'23', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'25', results)
		assert result
		assert int(result.group(14))    == 6

	def test_cpx_cycle_count(self):
		results = util.create(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/cpx.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result
		assert int(result.group(14))    == 2

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result 
		assert int(result.group(14))    == 3

		result = re.search(util.DUMP_PATTERN + r'3', results)
		assert result
		assert int(result.group(14))    == 4

	def test_cpy_cycle_count(self):
		results = util.create(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/cpy.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result
		assert int(result.group(14))    == 2

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result 
		assert int(result.group(14))    == 3

		result = re.search(util.DUMP_PATTERN + r'3', results)
		assert result
		assert int(result.group(14))    == 4

	def test_lda_cycle_count(self):
		results = util.create(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/lda.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result
		assert int(result.group(14))    == 2

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result 
		assert int(result.group(14))    == 3

		result = re.search(util.DUMP_PATTERN + r'4', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'5', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'7', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'8', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'10', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'11', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'17', results)
		assert result
		assert int(result.group(14))    == 6

		result = re.search(util.DUMP_PATTERN + r'23', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'25', results)
		assert result
		assert int(result.group(14))    == 6

	def test_sta_cycle_count(self):
		results = util.create(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/sta.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'1', results)
		assert result 
		assert int(result.group(14))    == 3

		result = re.search(util.DUMP_PATTERN + r'3', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'4', results)
		assert result
		assert int(result.group(14))    == 4

		result = re.search(util.DUMP_PATTERN + r'6', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'7', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'9', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'10', results)
		assert result
		assert int(result.group(14))    == 5

		result = re.search(util.DUMP_PATTERN + r'16', results)
		assert result
		assert int(result.group(14))    == 6

		result = re.search(util.DUMP_PATTERN + r'22', results)
		assert result
		assert int(result.group(14))    == 6

		result = re.search(util.DUMP_PATTERN + r'24', results)
		assert result
		assert int(result.group(14))    == 6


	def test_jmp_cycle_count(self):
		results = util.create(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/jmp.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'5', results)
		assert result 
		assert int(result.group(14))    == 3

		result = re.search(util.DUMP_PATTERN + r'6', results)
		assert result 
		assert int(result.group(14))    == 5

	def test_jsr_rts_cycle_count(self):
		results = util.create(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/jsr-rts.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'2', results)
		assert result 
		assert int(result.group(14))    == 6

		result = re.search(util.DUMP_PATTERN + r'4', results)
		assert result 
		assert int(result.group(14))    == 6

	def test_brk_rti_cycle_count(self):
		results = util.create(start_binary=-0x0000, overrided_start_pc=0x0000, source_file='test/sourcefiles/cyclecount/brk-rti.s', enable_print_dump=True)
		print(results)

		result = re.search(util.DUMP_PATTERN + r'5', results)
		assert result 
		assert int(result.group(14))    == 7

		result = re.search(util.DUMP_PATTERN + r'6', results)
		assert result 
		assert int(result.group(14))    == 6

		result = re.search(util.DUMP_PATTERN + r'7', results)
		assert result 
		assert int(result.group(2), 16) == 0xFF