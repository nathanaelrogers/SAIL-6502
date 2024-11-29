val modify_flags_AND : word -> unit
function modify_flags_AND(result) = {
	if (signed(result) < 0)  then set_flag_n(0b1) else set_flag_n(0b0); // negative
	if (signed(result) == 0) then set_flag_z(0b1) else set_flag_z(0b0); // zero
}

val AND : (word) -> bool
function AND(op) = {
	let result = reg_A & op;
	modify_flags_AND(result);
	reg_A = result;
	true
}

function clause execute(AND_IMM(op))   = {
	let word = calc_from_word(mode(imm), op);
	AND(word)
}
function clause execute(AND_ZP(op))    = {
	let word = calc_from_word(mode(zp), op);
	AND(read_zp(word))
}
function clause execute(AND_ZP_X(op))  = {
	let word = calc_from_word(mode(zp_x), op);
	AND(read_zp(word))
}
function clause execute(AND_ABS(op))   = {
	let addr = calc_from_addr(true, mode(abs), op);
	AND(read(addr))
}
function clause execute(AND_ABS_X(op)) = {
	let addr = calc_from_addr(true, mode(abs_x), op);
	AND(read(addr))
}
function clause execute(AND_ABS_Y(op)) = {
	let addr = calc_from_addr(true, mode(abs_y), op);
	AND(read(addr))
}
function clause execute(AND_IND_X(op)) = {
	let addr = calc_from_word(true, mode(ind_x), op);
	AND(read(addr))
}
function clause execute(AND_IND_Y(op)) = {
	let addr = calc_from_word(true, mode(ind_y), op);
	AND(read(addr))
}