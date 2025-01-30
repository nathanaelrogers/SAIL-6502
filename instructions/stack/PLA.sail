val PLA : (unit) -> bool
function PLA() = {
	incr_cycles(3);
	reg_A = pull();
	true
}

function clause execute(PLA_IMP()) = PLA()