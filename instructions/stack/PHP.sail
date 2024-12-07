val PHP : (unit) -> bool
function PHP() = {
	incr_cycles(2);
	push(reg_SR[all]);
	true
}

function clause execute(PHP_IMP()) = PHP()