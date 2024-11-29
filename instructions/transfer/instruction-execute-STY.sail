// TODO : can we directly use to write in the stack??
function clause execute(STY_ZP(op))    = {
	let word = calc_from_word(mode(zp), op);
	write_zp(word, reg_Y);
	true
}
function clause execute(STY_ZP_X(op))  = {
	let word = calc_from_word(mode(zp_x), op);
	write_zp(word, reg_Y);
	true
}
function clause execute(STY_ABS(op))   = {
	let addr = calc_from_addr(true, mode(abs), op);
	write(addr, reg_Y);
	true
}