val modify_flags_AND : word -> unit
function modify_flags_AND(result) = {
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

val AND : (word) -> bool
function AND(op) = {
	let result = reg_A & op;
	modify_flags_AND(result);
	reg_A = result;
	true
}

function clause execute(AND_IMM(op))   = {
	let word = calc_word(mode(imm), op);
	AND(word)
}
function clause execute(AND_ZP(op))    = {
	let word = calc_word(mode(zp), op);
	AND(read_zp(word))
}
function clause execute(AND_ZP_X(op))  = {
	let word = calc_word(mode(zp_x), op);
	AND(read_zp(word))
}
function clause execute(AND_ABS(op))   = {
	let addr = calc_addr(mode(abs), op);
	AND(read(addr))
}
function clause execute(AND_ABS_X(op)) = {
	let addr = calc_addr(mode(abs_x), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	AND(read(addr))
}
function clause execute(AND_ABS_Y(op)) = {
	let addr = calc_addr(mode(abs_y), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	AND(read(addr))
}
function clause execute(AND_IND_X(op)) = {
	let addr = calc_addr(mode(ind_x), op);
	AND(read(addr))
}
function clause execute(AND_IND_Y(op)) = {
	let addr = calc_addr(mode(ind_y), op);
	AND(read(addr))
}