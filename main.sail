default Order dec
$include <prelude.sail>
$include "types.sail"
$include "memory.sail"
$include "instructions.sail"


// function fetch_decode_execute() = {}

// function setup(): unit -> unit = {
// 	// PC is read from address provided in reset vector (16 bits at $FFFC).
// 	// All other initialization is left to the program loaded.
// }



function main(): unit -> unit = {
	reg(name(A)) = 0x0A;
	print_bits("contents of A before instruction are: ", reg(name(A)));

	reg(name(X)) = 0x03;
	print_bits("contents of X before instruction are: ", reg(name(X)));

	memory(0x02) = 0xFF;
	print_bits("contents of address 0x0002 is: ", memory(0x02));

	let result = execute(decode16(0x35 @ 0xFF));

	// should yield 0x0A & 0xFF = 0x0A
	print_bits("contents of A after instruction are: ", reg(name(A)));
}