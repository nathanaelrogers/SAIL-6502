// TODO : can we directly use to write in the stack??

val STX : (word) -> bool
function STX(op) = {
	write(op, access(reg(X)));
	true
}

function clause execute(STX_ZP(op))    = STX(get_op(mode(zp), op))
function clause execute(STX_ZP_Y(op))  = STX(get_op(mode(zp_y), op))
function clause execute(STX_ABS(op))   = STX(get_op(mode(abs), op))