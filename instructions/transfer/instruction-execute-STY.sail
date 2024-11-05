// TODO : can we directly use to write in the stack??

val STY : (word) -> bool
function STY(op) = {
	write(op, access(reg(Y)));
	true
}

function clause execute(STY_ZP(op))    = STY(get_op(mode(zp), op))
function clause execute(STY_ZP_X(op))  = STY(get_op(mode(zp_x), op))
function clause execute(STY_ABS(op))   = STY(get_op(mode(abs), op))