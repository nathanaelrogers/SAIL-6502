val modify_flags_EOR : word -> unit
function modify_flags_EOR(result) = {
	if (result == 0x00) then set_flag_z(0b1) else set_flag_z(0b0);
	if (result[7] == bitone) then set_flag_n(0b1) else set_flag_n(0b0);
}

val EOR : (word) -> bool
function EOR(op) = {
	let result = access(reg(A)) ^ op;
	modify_flags_EOR(result);
	access(reg(A)) = result;
	true
}

function clause execute(EOR_IMM(op))   = EOR(calculate_op(mode(imm), op))
function clause execute(EOR_ZP(op))    = EOR(calculate_op(mode(zp), op))
function clause execute(EOR_ZP_X(op))  = EOR(calculate_op(mode(zp_x), op))
function clause execute(EOR_ABS(op))   = EOR(calculate_op(mode(abs), op))
function clause execute(EOR_ABS_X(op)) = EOR(calculate_op(mode(abs_x), op))
function clause execute(EOR_ABS_Y(op)) = EOR(calculate_op(mode(abs_y), op))
function clause execute(EOR_IND_X(op)) = EOR(calculate_op(mode(ind_x), op))
function clause execute(EOR_IND_Y(op)) = EOR(calculate_op(mode(ind_y), op))