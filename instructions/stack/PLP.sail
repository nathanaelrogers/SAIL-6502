val PLP : (unit) -> bool
function PLP() = {
	incr_cycles(2);

	let stored_sr = pull();
	reg_SR[all] = stored_sr;
	reg_SR[b] = 0b0;

	true
}

function clause execute(PLP_IMP()) = PLP()