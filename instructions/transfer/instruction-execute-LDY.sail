val modify_flags_LDY : word -> unit
function modify_flags_LDY(result) = {
	if (signed(result) < 0)  then set_flag_n(0b1) else set_flag_n(0b0); // negative
	if (signed(result) == 0) then set_flag_z(0b1) else set_flag_z(0b0); // zero
}

val LDY : (word) -> bool
function LDY(op) = {
	modify_flags_LDY(op);
	access(reg(Y)) = op;
	true
}

function clause execute(LDY_IMM(op))   = LDY(get_op(mode(imm), op))
function clause execute(LDY_ZP(op))    = LDY(get_op(mode(zp), op))
function clause execute(LDY_ZP_X(op))  = LDY(get_op(mode(zp_x), op))
function clause execute(LDY_ABS(op))   = LDY(get_op(mode(abs), op))
function clause execute(LDY_ABS_X(op)) = LDY(get_op(mode(abs_x), op))