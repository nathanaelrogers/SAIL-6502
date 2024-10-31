register cycles : int = 0
register instructions_done : int = 0

function incr_cycles() : unit -> unit = {
	cycles = cycles + 1;
}