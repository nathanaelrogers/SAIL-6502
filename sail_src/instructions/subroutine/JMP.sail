val JMP : (address) -> bool
function JMP(address) = {
	reg_PC = address;
	true
}

function clause execute(JMP_ABS(op)) = {
	incr_cycles(3);
	let addr = calc_addr(mode(abs), op);
	JMP(addr)
}
function clause execute(JMP_IND(op)) = {
	incr_cycles(5);
	let addr = calc_addr(mode(ind), op);
	JMP(addr)
}