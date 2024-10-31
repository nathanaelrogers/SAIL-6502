val modify_flags_AND : word -> unit
function modify_flags_AND(result) = {
	if (result == 0x00) then set_flag_z(0b1) else set_flag_z(0b0);
	if (result[7] == bitone) then set_flag_n(0b1) else set_flag_n(0b0);
}

val AND : (word) -> bool
function AND(op) = {
	let result = access(reg(A)) & op;
	modify_flags_AND(result);
	access(reg(A)) = result;
	true
}

function clause execute(AND_IMM(op))   = AND(calculate_op(mode(imm), op))
function clause execute(AND_ZP(op))    = AND(calculate_op(mode(zp), op))
function clause execute(AND_ZP_X(op))  = AND(calculate_op(mode(zp_x), op))
function clause execute(AND_ABS(op))   = AND(calculate_op(mode(abs), op))
function clause execute(AND_ABS_X(op)) = AND(calculate_op(mode(abs_x), op))
function clause execute(AND_ABS_Y(op)) = AND(calculate_op(mode(abs_y), op))
function clause execute(AND_IND_X(op)) = AND(calculate_op(mode(ind_x), op))
function clause execute(AND_IND_Y(op)) = AND(calculate_op(mode(ind_y), op))