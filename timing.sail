register cycles : int = 0
register instructions_done : int = 0

val incr_cycles : int -> unit
function incr_cycles(n) = {
	cycles = cycles + n;
}