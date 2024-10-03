default Order dec
$include <prelude.sail>
$include "prelude.sail"
$include "types.sail"
$include "instructions.sail"
$include "memory.sail"


// function fetch_decode_execute() = {}

// function setup(): unit -> unit = {
// 	// PC is read from address provided in reset vector (16 bits at $FFFC).
// 	// All other initialization is left to the program loaded.
// }



function main(): unit -> unit = {
	reg(name(A)) = 0b00001010;
	print_bits("the bits before are: ", reg(name(A)));

	let result = execute(decode16(0x29 @ 0x08));

	print_bits("the bits after are: ", reg(name(A)));

	memory(0x00FF) = 0xEA;
	print_bits("contents of address 0x00FF is: ", memory(0x00FF));
	memory(0xFF) = 0x12;
	print_bits("contents of address 0x00FF is: ", memory(0xFF));
}