val modify_flags_AND : word -> unit
function modify_flags_AND(result) = {
	if (signed(result) < 0)  then set_flag_n(0b1) else set_flag_n(0b0); // negative
	if (signed(result) == 0) then set_flag_z(0b1) else set_flag_z(0b0); // zero
}

val AND : (word) -> bool
function AND(op) = {
	let result = access(reg(A)) & op;
	modify_flags_AND(result);
	access(reg(A)) = result;
	true
}

function clause execute(AND_IMM(op))   = AND(get_op(mode(imm), op))
function clause execute(AND_ZP(op))    = AND(get_op(mode(zp), op))
function clause execute(AND_ZP_X(op))  = AND(get_op(mode(zp_x), op))
function clause execute(AND_ABS(op))   = AND(get_op(true, mode(abs), op))
function clause execute(AND_ABS_X(op)) = AND(get_op(true, mode(abs_x), op))
function clause execute(AND_ABS_Y(op)) = AND(get_op(true, mode(abs_y), op))
function clause execute(AND_IND_X(op)) = AND(get_op(mode(ind_x), op))
function clause execute(AND_IND_Y(op)) = AND(get_op(true, mode(ind_y), op))