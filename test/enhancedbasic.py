from util import load_test
import subprocess

load_test(start_binary=0xC000, source_file='test/enhancedbasic/basic.bin', compile_c_target=True, generate_binary=False, enable_break_at_trap=False)
print('finished loading, running model:')
subprocess.run(['./out'])