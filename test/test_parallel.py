from util import *

class TestParallel:
	def test_functional_parallel_no_bcd(self):
		with open('test/functional_no_bcd_emu_results.txt') as file:
			emu_dump = file.read()

		with open('test/functional_no_bcd_spec_results.txt') as file:
			spec_dump = file.read()

		for i in range(1000, 27523000, 1000):
			emu_result = match_instr_emu(emu_dump, i)
			spec_result = match_instr_spec(spec_dump, i)

			assert get_start_pc(emu_result) == get_start_pc(spec_result)
			assert get_acc(emu_result) == get_acc(spec_result)
			assert get_x(emu_result) == get_x(spec_result)
			assert get_y(emu_result) == get_y(spec_result)
			assert get_sp(emu_result) == get_sp(spec_result)
			assert get_pc(emu_result) == get_pc(spec_result)
			assert get_n(emu_result) == get_n(spec_result)
			assert get_v(emu_result) == get_v(spec_result)

			# representation of b flag in emulator represents what would get
			# pushed to the stack, so may be "on" when that's not what's actually
			# going on inside the status register. (ignore the difference)

			assert get_d(emu_result) == get_d(spec_result)
			assert get_i(emu_result) == get_i(spec_result)
			assert get_z(emu_result) == get_z(spec_result)
			assert get_c(emu_result) == get_c(spec_result)
			assert get_cycles(emu_result) == get_cycles(spec_result)
			assert get_total_cycles(emu_result) == get_total_cycles(spec_result)