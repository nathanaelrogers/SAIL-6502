from util import load_test

load_test(start_binary=0xC000, source_file='test/basic/basic.bin', compile_c_target=True, generate_binary=False, enable_break_at_trap=False)