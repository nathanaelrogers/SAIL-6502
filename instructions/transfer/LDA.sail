val modify_flags_LDA : word -> unit
function modify_flags_LDA(result) = {
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
}

val LDA : (word) -> bool
function LDA(op) = {
	modify_flags_LDA(op);
	reg_A = op;
	true
}

function clause execute(LDA_IMM(op))   = {
	let word = calc_word(mode(imm), op);
	LDA(word)
}
function clause execute(LDA_ZP(op))    = {
	let word = calc_word(mode(zp), op);
	LDA(read_zp(word))
}
function clause execute(LDA_ZP_X(op))  = {
	let word = calc_word(mode(zp_x), op);
	LDA(read_zp(word))
}
function clause execute(LDA_ABS(op))   = {
	let addr = calc_addr(mode(abs), op);
	LDA(read(addr))
}
function clause execute(LDA_ABS_X(op)) = {
	let addr = calc_addr(mode(abs_x), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	LDA(read(addr))
}
function clause execute(LDA_ABS_Y(op)) = {
	let addr = calc_addr(mode(abs_y), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	LDA(read(addr))
}
function clause execute(LDA_IND_X(op)) = {
	let addr = calc_addr(mode(ind_x), op);
	LDA(read(addr))
}
function clause execute(LDA_IND_Y(op)) = {
	let addr = calc_addr(mode(ind_y), op);
	LDA(read(addr))
}