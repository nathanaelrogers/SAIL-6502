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
			decimal_sub(access(reg(A)), op)
		};
	let result : bits(9) = if (flag_d() == 0b0)
		then {
			EXTZ(9, access(reg(A))) + EXTZ(9, not_vec(op)) + EXTZ(9, flag_c())
		} else {
			0b0 @ decimal_to_word(decimal_result)
		};
	modify_flags_SBC(result, decimal_result, access(reg(A)), op);
	access(reg(A)) = result[7..0];
	true
}

function clause execute(SBC_IMM(op))   = SBC(get_op(mode(imm), op))
function clause execute(SBC_ZP(op))    = SBC(get_op(mode(zp), op))
function clause execute(SBC_ZP_X(op))  = SBC(get_op(mode(zp_x), op))
function clause execute(SBC_ABS(op))   = SBC(get_op(true, mode(abs), op))
function clause execute(SBC_ABS_X(op)) = SBC(get_op(true, mode(abs_x), op))
function clause execute(SBC_ABS_Y(op)) = SBC(get_op(true, mode(abs_y), op))
function clause execute(SBC_IND_X(op)) = SBC(get_op(mode(ind_x), op))
function clause execute(SBC_IND_Y(op)) = SBC(get_op(true, mode(ind_y), op))