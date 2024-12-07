val SEC : (unit) -> bool
function SEC() = {
	incr_cycles(1);
	set_flag_c(0b1);
	true
}

function clause execute(SEC_IMP()) = SEC()