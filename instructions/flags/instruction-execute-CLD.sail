val CLD : (unit) -> bool
function CLD() = {
	incr_cycles(1);
	set_flag_d(0b0);
	true
}

function clause execute(CLD_IMP()) = CLD()