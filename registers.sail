register reg_PC : address
register reg_A  : word
register reg_X  : word
register reg_Y  : word
register reg_SR : flags
register reg_SP : word

// Helper function to increment the PC.
val incr_pc : int -> unit
function incr_pc(n) = {
	reg_PC = reg_PC + n
}

val incr_sp : int -> unit
function incr_sp(n) = {
	reg_SP = reg_SP + n
}