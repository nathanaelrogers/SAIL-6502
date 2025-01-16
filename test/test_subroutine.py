import util

class TestSubroutine:
	def test_jsr_then_rts(self):
		results = util.create_script(0x0800, 'test/sourcefiles/subroutine/jsr-then-rts.s')
		print(results)

		assert False