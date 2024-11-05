val modify_flags_LDX : word -> unit
function modify_flags_LDX(result) = {
	if (signed(result) < 0)  then set_flag_n(0b1) else set_flag_n(0b0); // negative
	if (signed(result) == 0) then set_flag_z(0b1) else set_flag_z(0b0); // zero
}

val LDX : (word) -> bool
function LDX(op) = {
	modify_flags_LDX(op);
	access(reg(X)) = op;
	true
}

function clause execute(LDX_IMM(op))   = LDX(get_op(mode(imm), op))
function clause execute(LDX_ZP(op))    = LDX(get_op(mode(zp), op))
function clause execute(LDX_ZP_Y(op))  = LDX(get_op(mode(zp_y), op))
function clause execute(LDX_ABS(op))   = LDX(get_op(mode(abs), op))
function clause execute(LDX_ABS_Y(op)) = LDX(get_op(mode(abs_y), op))