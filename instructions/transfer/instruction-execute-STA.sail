// TODO : can we directly use to write in the stack??
function clause execute(STA_ZP(op))    = {
	let word = calc_from_word(mode(zp), op);
	write_zp(word, access(reg(A)));
	true
}
function clause execute(STA_ZP_X(op))  = {
	let word = calc_from_word(mode(zp_x), op);
	write_zp(word, access(reg(A)));
	true
}
function clause execute(STA_ABS(op))   = {
	let addr = calc_from_addr(true, mode(abs), op);
	write(addr, access(reg(A)));
	true
}
function clause execute(STA_ABS_X(op)) = {
	let addr = calc_from_addr(false, mode(abs_x), op);
	write(addr, access(reg(A)));
	true
}
function clause execute(STA_ABS_Y(op)) = {
	let addr = calc_from_addr(false, mode(abs_y), op);
	write(addr, access(reg(A)));
	true
}
function clause execute(STA_IND_X(op)) = {
	let addr = calc_from_word(true, mode(ind_x), op);
	write(addr, access(reg(A)));
	true
}
function clause execute(STA_IND_Y(op)) = {
	let addr = calc_from_word(false, mode(ind_y), op);
	write(addr, access(reg(A)));
	true
}