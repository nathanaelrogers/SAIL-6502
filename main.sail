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
	write_reg(reg(A), 0b00001010);
	print_bits("the bits before are: ", read_reg(reg(A)));

	let result = execute(decode16(0x29 @ 0x08));

	print_bits("the bits after are: ", read_reg(reg(A)));
}