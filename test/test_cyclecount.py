from util import check_cycles, match_instr, load_test

class TestCycles:
	def test_adc_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/adc.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 7)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 8)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 10)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 11)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 17)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 23)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 25)
		assert result
		assert check_cycles(result, 6)

	def test_sbc_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/sbc.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 7)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 8)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 10)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 11)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 17)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 23)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 25)
		assert result
		assert check_cycles(result, 6)

	def test_and_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/and.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 7)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 8)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 10)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 11)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 17)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 23)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 25)
		assert result
		assert check_cycles(result, 6)

	def test_ora_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/ora.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 7)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 8)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 10)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 11)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 17)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 23)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 25)
		assert result
		assert check_cycles(result, 6)

	def test_eor_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/eor.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 7)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 8)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 10)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 11)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 17)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 23)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 25)
		assert result
		assert check_cycles(result, 6)

	def test_cmp_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/cmp.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 7)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 8)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 10)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 11)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 17)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 23)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 25)
		assert result
		assert check_cycles(result, 6)

	def test_cpx_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/cpx.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 3)
		assert result
		assert check_cycles(result, 4)

	def test_cpy_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/cpy.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 3)
		assert result
		assert check_cycles(result, 4)

	def test_lda_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/lda.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 7)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 8)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 10)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 11)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 17)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 23)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 25)
		assert result
		assert check_cycles(result, 6)

	def test_ldx_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/ldx.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 7)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 8)
		assert result
		assert check_cycles(result, 5)

	def test_ldy_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/ldy.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 7)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 8)
		assert result
		assert check_cycles(result, 5)

	def test_sta_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/sta.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 3)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 6)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 7)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 9)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 10)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 16)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 22)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 24)
		assert result
		assert check_cycles(result, 6)

	def test_stx_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/stx.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 3)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 4)

	def test_sty_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/sty.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 3)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 4)

	def test_transfers_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/transfers.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 3)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 6)
		assert result
		assert check_cycles(result, 2)

	def test_stack_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/stack.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 3)

		result = match_instr(results, 2)
		assert result
		assert check_cycles(result, 3)

		result = match_instr(results, 3)
		assert result
		assert check_cycles(result, 4)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 4)

	def test_increments_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/increments.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 2)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 3)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 7)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 6)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 7)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 8)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 9)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 10)
		assert result
		assert check_cycles(result, 7)

		result = match_instr(results, 11)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 12)
		assert result
		assert check_cycles(result, 2)

	def test_asl_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/asl.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 3)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 7)

	def test_lsr_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/lsr.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 3)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 7)

	def test_rol_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/rol.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 3)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 7)

	def test_ror_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/ror.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result
		assert check_cycles(result, 5)

		result = match_instr(results, 3)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 6)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 7)

	def test_flag_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/flag.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 2)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 3)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 4)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 5)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 6)
		assert result
		assert check_cycles(result, 2)

	def test_branch_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/branch.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 247)
		assert result
		assert check_cycles(result, 2)

		result = match_instr(results, 249)
		assert result
		assert check_cycles(result, 3)

		result = match_instr(results, 250)
		assert result
		assert check_cycles(result, 4)


	def test_jmp_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/jmp.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 5)
		assert result 
		assert check_cycles(result, 3)

		result = match_instr(results, 6)
		assert result 
		assert check_cycles(result, 5)

	def test_jsr_rts_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/jsr-rts.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 2)
		assert result 
		assert check_cycles(result, 6)

		result = match_instr(results, 4)
		assert result 
		assert check_cycles(result, 6)

	def test_brk_rti_cycle_count(self):
		results = load_test(start_binary=0x0000, overrided_start_pc=0x0000, source_file='test/sourcefiles/cyclecount/brk-rti.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 5)
		assert result 
		assert check_cycles(result, 7)

		result = match_instr(results, 6)
		assert result 
		assert check_cycles(result, 6)

		result = match_instr(results, 7)
		assert result 
		assert int(result.group(2), 16) == 0xFF

	def test_bit_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/bit.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 3)

		result = match_instr(results, 2)
		assert result
		assert check_cycles(result, 4)

	def test_nop_cycle_count(self):
		results = load_test(overrided_start_pc=0x0200, source_file='test/sourcefiles/cyclecount/nop.s', enable_print_dump=True)
		print(results)

		result = match_instr(results, 1)
		assert result
		assert check_cycles(result, 2)