val modify_flags_LDA : word -> unit
function modify_flags_LDA(result) = {
	if (signed(result) < 0)  then set_flag_n(0b1) else set_flag_n(0b0); // negative
	if (signed(result) == 0) then set_flag_z(0b1) else set_flag_z(0b0); // zero
}

val LDA : (word) -> bool
function LDA(op) = {
	modify_flags_LDA(op);
	access(reg(A)) = op;
	true
}

function clause execute(LDA_IMM(op))   = LDA(get_op(mode(imm), op))
function clause execute(LDA_ZP(op))    = LDA(get_op(mode(zp), op))
function clause execute(LDA_ZP_X(op))  = LDA(get_op(mode(zp_x), op))
function clause execute(LDA_ABS(op))   = LDA(get_op(mode(abs), op))
function clause execute(LDA_ABS_X(op)) = LDA(get_op(mode(abs_x), op))
function clause execute(LDA_ABS_Y(op)) = LDA(get_op(mode(abs_y), op))
function clause execute(LDA_IND_X(op)) = LDA(get_op(mode(ind_x), op))
function clause execute(LDA_IND_Y(op)) = LDA(get_op(mode(ind_y), op))