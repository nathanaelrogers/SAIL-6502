default Order dec
$include <prelude.sail>
$include "prelude.sail"
$include "types.sail"
$include "registers.sail"
$include "memory.sail"
$include "timing.sail"
$include "instructions.sail"
$include "interrupts.sail"
$include "programs.sail"

register instructions_done : int = 0

function print_state() : unit -> unit = {
	print_endline("==state after execution==");
	print_bits("A: ", reg(name(A)));
	print_bits("X: ", reg(name(X)));
	print_bits("Y: ", reg(name(Y)));
	print_bits("SR: ", reg(name(SR)));
	print_bits("SP: ", reg(name(SP)));
	print_bits("PC: ", reg(name(PC_H)) @ reg(name(PC_L)));
	print_endline(concat_str("Cycles passed: ", dec_str(cycles)));
	print_endline(concat_str("Instructions completed: ", dec_str(instructions_done)));
}

function fetch_decode_execute(last_execute) : bool -> unit = {
	let PC : address = reg(name(PC_H)) @ reg(name(PC_L));
	let instruction = read(PC);

	incr_pc();

	let decoded = decode(instruction, last_execute);
	let asm = assembly(decoded);

	let last_execute = execute(decoded);
	if (last_execute) then instructions_done = instructions_done + 1;

	// Print out some information
	print_endline(concat_str("\nfetch done: ", asm));
	let state = print_state();

	if (last_execute) then fetch_decode_execute(true);
}

// PC is read from address provided in reset vector (16 bits at $FFFC).
// All other initialization is left to the program loaded.
function setup() : unit -> unit = {
	cycles = 7;
	reg(name(PC_H)) = read(RES_vec + 1); reg(name(PC_L)) = read(RES_vec);
}

function main() : unit -> unit = {
	setup_program1();

	setup();

	let state = print_state();

	fetch_decode_execute(false);
}