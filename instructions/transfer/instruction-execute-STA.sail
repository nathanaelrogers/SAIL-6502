// TODO : can we directly use to write in the stack??

val STA : (word) -> bool
function STA(op) = {
	write(op, access(reg(A)));
	true
}

function clause execute(STA_ZP(op))    = STA(get_op(mode(zp), op))
function clause execute(STA_ZP_X(op))  = STA(get_op(mode(zp_x), op))
function clause execute(STA_ABS(op))   = STA(get_op(false, mode(abs), op))
function clause execute(STA_ABS_X(op)) = {incr_cycles(1); STA(get_op(false, mode(abs_x), op))}
function clause execute(STA_ABS_Y(op)) = {incr_cycles(1); STA(get_op(false, mode(abs_y), op))}
function clause execute(STA_IND_X(op)) = STA(get_op(mode(ind_x), op))
function clause execute(STA_IND_Y(op)) = {incr_cycles(1); STA(get_op(false, mode(ind_y), op))}