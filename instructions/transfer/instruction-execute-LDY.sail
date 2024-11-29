val modify_flags_LDY : word -> unit
function modify_flags_LDY(result) = {
	if (signed(result) < 0)  then set_flag_n(0b1) else set_flag_n(0b0); // negative
	if (signed(result) == 0) then set_flag_z(0b1) else set_flag_z(0b0); // zero
}

val LDY : (word) -> bool
function LDY(op) = {
	modify_flags_LDY(op);
	reg_Y = op;
	true
}

function clause execute(LDY_IMM(op))   = {
	let word = calc_from_word(mode(imm), op);
	LDY(word)
}
function clause execute(LDY_ZP(op))    = {
	let word = calc_from_word(mode(zp), op);
	LDY(read_zp(word))
}
function clause execute(LDY_ZP_X(op))  = {
	let word = calc_from_word(mode(zp_x), op);
	LDY(read_zp(word))
}
function clause execute(LDY_ABS(op))   = {
	let addr = calc_from_addr(true, mode(abs), op);
	LDY(read(addr))
}
function clause execute(LDY_ABS_X(op)) = {
	let addr = calc_from_addr(true, mode(abs_x), op);
	LDY(read(addr))
}