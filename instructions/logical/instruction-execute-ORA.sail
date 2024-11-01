val modify_flags_ORA : word -> unit
function modify_flags_ORA(result) = {
	if (signed(result) < 0)  then set_flag_n(0b1) else set_flag_n(0b0); // negative
	if (signed(result) == 0) then set_flag_z(0b1) else set_flag_z(0b0); // zero
}

val ORA : (word) -> bool
function ORA(op) = {
	let result = access(reg(A)) | op;
	modify_flags_ORA(result);
	access(reg(A)) = result;
	true
}

function clause execute(ORA_IMM(op))   = ORA(get_op(mode(imm), op))
function clause execute(ORA_ZP(op))    = ORA(get_op(mode(zp), op))
function clause execute(ORA_ZP_X(op))  = ORA(get_op(mode(zp_x), op))
function clause execute(ORA_ABS(op))   = ORA(get_op(mode(abs), op))
function clause execute(ORA_ABS_X(op)) = ORA(get_op(mode(abs_x), op))
function clause execute(ORA_ABS_Y(op)) = ORA(get_op(mode(abs_y), op))
function clause execute(ORA_IND_X(op)) = ORA(get_op(mode(ind_x), op))
function clause execute(ORA_IND_Y(op)) = ORA(get_op(mode(ind_y), op))