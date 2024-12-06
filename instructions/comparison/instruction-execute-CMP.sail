val modify_flags_CMP : (bits(9)) -> unit
function modify_flags_CMP(result) = {
	// negative
	if (signed(result[7..0]) < 0) then
		set_flag_n(0b1)
	else
		set_flag_n(0b0);

	// zero
	if (unsigned(result[7..0]) == 0) then
		set_flag_z(0b1)
	else
		set_flag_z(0b0);

	// carry
	if (signed(result) >= 0) then
		set_flag_c(0b1)
	else
		set_flag_c(0b0)
}

val CMP : (word) -> bool
function CMP(op) = {
	let result : bits(9) = EXTZ(9, reg_A) + (EXTZ(9, not_vec(op)) + EXTZ(9, 0b1));
	modify_flags_CMP(result);
	true
}

function clause execute(CMP_IMM(op))   = {
	let word = calc_word(mode(imm), op);
	CMP(word)
}
function clause execute(CMP_ZP(op))    = {
	let word = calc_word(mode(zp), op);
	CMP(read_zp(word))
}
function clause execute(CMP_ZP_X(op))  = {
	let word = calc_word(mode(zp_x), op);
	CMP(read_zp(word))
}
function clause execute(CMP_ABS(op))   = {
	let addr = calc_addr(mode(abs), op);
	CMP(read(addr))
}
function clause execute(CMP_ABS_X(op)) = {
	let addr = calc_addr(mode(abs_x), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	CMP(read(addr))
}
function clause execute(CMP_ABS_Y(op)) = {
	let addr = calc_addr(mode(abs_y), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	CMP(read(addr))
}
function clause execute(CMP_IND_X(op)) = {
	let addr = calc_addr(mode(ind_x), op);
	CMP(read(addr))
}
function clause execute(CMP_IND_Y(op)) = {
	let addr = calc_addr(mode(ind_y), op);
	CMP(read(addr))
}