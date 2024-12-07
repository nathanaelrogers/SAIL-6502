val TXS : (unit) -> bool
function TXS() = {
	incr_cycles(2);
	let op = reg_X;

	reg_SP = op;
	true
}

function clause execute(TXS_IMP()) = TXS()