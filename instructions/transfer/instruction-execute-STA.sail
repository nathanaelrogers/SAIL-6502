// TODO : can we directly use to write in the stack??
function clause execute(STA_ZP(op))    = {
	let word = calc_word(mode(zp), op);
	write_zp(word, reg_A);
	true
}
function clause execute(STA_ZP_X(op))  = {
	let word = calc_word(mode(zp_x), op);
	write_zp(word, reg_A);
	true
}
function clause execute(STA_ABS(op))   = {
	let addr = calc_addr(mode(abs), op);
	write(addr, reg_A);
	true
}
function clause execute(STA_ABS_X(op)) = {
	let addr = calc_addr(mode(abs_x), op);
	write(addr, reg_A);
	true
}
function clause execute(STA_ABS_Y(op)) = {
	let addr = calc_addr(mode(abs_y), op);
	write(addr, reg_A);
	true
}
function clause execute(STA_IND_X(op)) = {
	let addr = calc_addr(mode(ind_x), op);
	write(addr, reg_A);
	true
}
/*
	This instructions always takes 6 cycles so we must increment
	the cycles manually whenever the addressing doesn't cross a
	page boundary.
*/
function clause execute(STA_IND_Y(op)) = {
	let addr = calc_addr(mode(ind_y), op);
	let ptr = read_zp(op + 1) @ read_zp(op);
	if (ptr[15..8] == addr[15..8]) then
		incr_cycles(1);
	write(addr, reg_A);
	true
}