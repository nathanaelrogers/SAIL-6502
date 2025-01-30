val JMP : (address) -> bool
function JMP(address) = {
	reg_PC = address;
	true
}

function clause execute(JMP_ABS(op)) = {
	let addr = calc_addr(mode(abs), op);
	JMP(addr)
}
function clause execute(JMP_IND(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(ind), op);
	JMP(addr)
}