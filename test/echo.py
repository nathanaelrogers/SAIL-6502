from util import load_test

load_test(start_binary=0x0000, overrided_start_pc=0x0000, source_file='test/sourcefiles/echo.s', compile_c_target=True)