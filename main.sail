default Order dec
$include <prelude.sail>
$include "prelude.sail"
$include "types.sail"
$include "instructions.sail"


// function fetch_decode_execute() = {}

// function setup(): unit -> unit = {
// 	// PC is read from address provided in reset vector (16 bits at $FFFC).
// 	// All other initialization is left to the program loaded.
// }

function main(): unit -> unit = {
	write_reg(reg(A), 0xFF);

	print_bits("the bits are: ", read_reg(0b010))
}