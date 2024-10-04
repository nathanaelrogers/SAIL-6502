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

	// data we WANT to use
	memory(0xBEEF) = 0xFF;

	// pointer to data held at effective address
	memory(0xAE) = 0xBE;
	memory(0xAD) = 0xEF;

	// effective address should be 0xAA + 0x03 = 0xAD
	reg(name(X)) = 0x03;
	let result = execute(decode16(0x21 @ 0xAA));

	// should yield 0x0A & 0xFF = 0x0A
	print_bits("contents of A after instruction are: ", reg(name(A)));

	print(assembly(decode16(0x31 @ 0xFF)));
	print("\n");
}