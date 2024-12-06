val PLA : (unit) -> bool
function PLA() = {
	incr_cycles(2);
	reg_A = pull();
	true
}

function clause execute(PLA_IMP()) = PLA()