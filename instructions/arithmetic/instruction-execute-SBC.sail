val modify_flags_SBC : (bits(9), int, word, word) -> unit
function modify_flags_SBC(result, decimal_result, op1, op2) = {
	if (signed(result[7..0]) < 0)
		then set_flag_n(0b1) else set_flag_n(0b0); // negative

	if (signed(result) > 127 | signed(result) < -128)
		then set_flag_v(0b1) else set_flag_v(0b0); // overflow

	if (signed(result[7..0]) == 0)
		then set_flag_z(0b1) else set_flag_z(0b0); // zero

	if (signed(result) >= 0)
		then set_flag_c(0b1) else set_flag_c(0b0); // carry
}

// TODO: the docs say overflow is out of range -127 to 127 but shouldn't
// this be -128 to 127? seems to be a typo...
val SBC : (word) -> bool
function SBC(op) = {
	let decimal_result : int = if (flag_d() == 0b0)
		then {
			0
		} else {
			decimal_sub(reg_A, op)
		};
	let result : bits(9) = if (flag_d() == 0b0)
		then {
			EXTZ(9, reg_A) + EXTZ(9, not_vec(op)) + EXTZ(9, flag_c())
		} else {
			0b0 @ decimal_to_word(decimal_result)
		};
	modify_flags_SBC(result, decimal_result,reg_A, op);
	reg_A = result[7..0];
	true
}

function clause execute(SBC_IMM(op))   = {
	let word = calc_from_word(mode(imm), op);
	SBC(word)
}
function clause execute(SBC_ZP(op))    = {
	let word = calc_from_word(mode(zp), op);
	SBC(read_zp(word))
}
function clause execute(SBC_ZP_X(op))  = {
	let word = calc_from_word(mode(zp_x), op);
	SBC(read_zp(word))
}
function clause execute(SBC_ABS(op))   = {
	let addr = calc_from_addr(true, mode(abs), op);
	SBC(read(addr))
}
function clause execute(SBC_ABS_X(op)) = {
	let addr = calc_from_addr(true, mode(abs_x), op);
	SBC(read(addr))
}
function clause execute(SBC_ABS_Y(op)) = {
	let addr = calc_from_addr(true, mode(abs_y), op);
	SBC(read(addr))
}
function clause execute(SBC_IND_X(op)) = {
	let addr = calc_from_word(true, mode(ind_x), op);
	SBC(read(addr))
}
function clause execute(SBC_IND_Y(op)) = {
	let addr = calc_from_word(true, mode(ind_y), op);
	SBC(read(addr))
}