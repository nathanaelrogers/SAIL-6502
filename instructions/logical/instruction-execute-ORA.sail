val modify_flags_ORA : word -> unit
function modify_flags_ORA(result) = {
	if (result == 0x00) then set_flag_z(0b1) else set_flag_z(0b0);
	if (result[7] == bitone) then set_flag_n(0b1) else set_flag_n(0b0);
}

val ORA : (word) -> bool
function ORA(op) = {
	let result = access(reg(A)) | op;
	modify_flags_ORA(result);
	access(reg(A)) = result;
	true
}

function clause execute(ORA_IMM(op))   = ORA(calculate_op(mode(imm), op))
function clause execute(ORA_ZP(op))    = ORA(calculate_op(mode(zp), op))
function clause execute(ORA_ZP_X(op))  = ORA(calculate_op(mode(zp_x), op))
function clause execute(ORA_ABS(op))   = ORA(calculate_op(mode(abs), op))
function clause execute(ORA_ABS_X(op)) = ORA(calculate_op(mode(abs_x), op))
function clause execute(ORA_ABS_Y(op)) = ORA(calculate_op(mode(abs_y), op))
function clause execute(ORA_IND_X(op)) = ORA(calculate_op(mode(ind_x), op))
function clause execute(ORA_IND_Y(op)) = ORA(calculate_op(mode(ind_y), op))