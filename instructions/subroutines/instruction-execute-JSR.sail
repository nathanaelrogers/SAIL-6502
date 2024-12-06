val JSR : (address) -> bool
function JSR(address) = {
	true
}

function clause execute(JSR_ABS(op)) = {
	let addr = calc_addr(mode(abs), op);
	JSR(addr)
}