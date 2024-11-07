val TXS : (unit) -> bool
function TXS() = {
	incr_cycles(2);
	let op = access(reg(X));

	access(reg(SP)) = op;
	true
}

function clause execute(TXS_IMP()) = TXS()