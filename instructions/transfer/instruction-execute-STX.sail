// TODO : can we directly use to write in the stack??
function clause execute(STX_ZP(op))    = {
	let word = calc_from_word(mode(zp), op);
	write_zp(word, reg_X);
	true
}
function clause execute(STX_ZP_Y(op))  = {
	let word = calc_from_word(mode(zp_y), op);
	write_zp(word, reg_X);
	true
}
function clause execute(STX_ABS(op))   = {
	let addr = calc_from_addr(true, mode(abs), op);
	write(addr, reg_X);
	true
}