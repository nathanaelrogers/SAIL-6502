default Order dec
$include <prelude.sail>
$include "prelude.sail"
$include "types.sail"
$include "registers.sail"
$include "memory.sail"
$include "instructions.sail"


// function fetch_decode_execute() = {}

// function setup(): unit -> unit = {
// 	// PC is read from address provided in reset vector (16 bits at $FFFC).
// 	// All other initialization is left to the program loaded.
// }



function main(): unit -> unit = {
	// setup A
	reg(name(A)) = 0x0A;
}