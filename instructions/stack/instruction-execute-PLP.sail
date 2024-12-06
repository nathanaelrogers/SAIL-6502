val PLP : (unit) -> bool
function PLP() = {
	incr_cycles(2);
	reg_SR[all] = pull();
	true
}

function clause execute(PLP_IMP()) = PLP()