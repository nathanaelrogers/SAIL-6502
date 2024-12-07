val CLC : (unit) -> bool
function CLC() = {
	incr_cycles(1);
	set_flag_c(0b0);
	true
}

function clause execute(CLC_IMP()) = CLC()