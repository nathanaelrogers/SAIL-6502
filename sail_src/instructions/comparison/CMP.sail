val modify_flags_CMP : (bits(9)) -> unit
function modify_flags_CMP(result) = {
	// negative
	if (signed(result[7..0]) < 0) then
		reg_SR[n] = 0b1
	else
		reg_SR[n] = 0b0;

	// zero
	if (unsigned(result[7..0]) == 0) then
		reg_SR[z] = 0b1
	else
		reg_SR[z] = 0b0;

	// carry
	if (signed(result) >= 0) then
		reg_SR[c] = 0b1
	else
		reg_SR[c] = 0b0
}

val CMP : (word) -> bool
function CMP(op) = {
	let result : bits(9) = EXTZ(9, reg_A) - EXTZ(9, op);
	modify_flags_CMP(result);
	true
}

function clause execute(CMP_IMM(op))   = {
	incr_cycles(2);
	let word = calc_word(mode(imm), op);
	CMP(word)
}
function clause execute(CMP_ZP(op))    = {
	incr_cycles(3);
	let word = calc_word(mode(zp), op);
	CMP(read_zp(word))
}
function clause execute(CMP_ZP_X(op))  = {
	incr_cycles(4);
	let word = calc_word(mode(zp_x), op);
	CMP(read_zp(word))
}
function clause execute(CMP_ABS(op))   = {
	incr_cycles(4);
	let addr = calc_addr(mode(abs), op);
	CMP(read(addr))
}
function clause execute(CMP_ABS_X(op)) = {
	incr_cycles(4);
	let addr = calc_addr(mode(abs_x), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	CMP(read(addr))
}
function clause execute(CMP_ABS_Y(op)) = {
	incr_cycles(4);
	let addr = calc_addr(mode(abs_y), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	CMP(read(addr))
}
function clause execute(CMP_IND_X(op)) = {
	incr_cycles(6);
	let addr = calc_addr(mode(ind_x), op);
	CMP(read(addr))
}
function clause execute(CMP_IND_Y(op)) = {
	incr_cycles(5);
	let addr = calc_addr(mode(ind_y), op);
	if (addr[15..8] != (read_zp(op + 1) @ read_zp(op))[15..8]) then
		incr_cycles(1);
	CMP(read(addr))
}