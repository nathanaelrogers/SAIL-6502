default Order dec
$include <prelude.sail>
$include "prelude.sail"
$include "timing.sail"
$include "types.sail"
$include "registers.sail"
$include "memory.sail"
$include "instructions.sail"


function fetch_decode_execute(last_instruction) : bool -> bool = {
	let PC : address = reg(name(PC_H)) @ reg(name(PC_L));
	let instruction = read(PC);

	incr_pc();

	let decoded = decode(instruction);
	let asm = assembly(decoded);
	
	let loop = execute(decoded);

	loop
}

// function setup(): unit -> unit = {
// 	// PC is read from address provided in reset vector (16 bits at $FFFC).
// 	// All other initialization is left to the program loaded.
// }

function main(): unit -> unit = {
	// setup A
	reg(name(A)) = 0x0A;
}