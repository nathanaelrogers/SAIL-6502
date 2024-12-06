val PHA : (unit) -> bool
function PHA() = {
	incr_cycles(2);
	push(reg_A);
	true
}

function clause execute(PHA_IMP()) = PHA()