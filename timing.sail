register cycles : int = 0
register excess_time : int = 0

val incr_cycles : (unit) -> unit
function incr_cycles(unit) = {
	cycles = cycles + 1;
}