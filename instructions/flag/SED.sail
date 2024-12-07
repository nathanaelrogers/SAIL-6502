val SED : (unit) -> bool
function SED() = {
	incr_cycles(1);
	set_flag_d(0b1);
	true
}

function clause execute(SED_IMP()) = SED()