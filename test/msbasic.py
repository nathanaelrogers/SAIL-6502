from util import load_test
import subprocess

load_test(start_binary=0x8000, source_file='test/msbasic/tmp/eater.bin', compile_c_target=True, generate_binary=False, enable_break_at_trap=False, enable_print_dump=False)
print('finished loading, running msbasic')
subprocess.run(['./out'])