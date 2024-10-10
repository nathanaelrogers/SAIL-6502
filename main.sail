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
	print_endline("\n==state after execution==");
	print_bits("A: ", reg(name(A)));
	print_bits("X: ", reg(name(X)));
	print_bits("Y: ", reg(name(Y)));
	print_bits("SR: ", reg(name(SR)));
	print_bits("SP: ", reg(name(SP)));
	print_bits("PC: ", reg(name(PC_H)) @ reg(name(PC_L)));
	print_endline(concat_str("Instructions completed: ", dec_str(instructions_done)));
}

function fetch_decode_execute(last_instruction) : bool -> bool = {
	let PC : address = reg(name(PC_H)) @ reg(name(PC_L));
	let instruction = read(PC);

	incr_pc();

	let decoded = decode(instruction);
	let asm = assembly(decoded);

	let loop = execute(decoded);
	instructions_done = instructions_done + 1;

	// Print out some information
	print_endline(concat_str("\nfetch done: ", asm));
	let state = print_state();

	loop
}

// PC is read from address provided in reset vector (16 bits at $FFFC).
// All other initialization is left to the program loaded.
function setup() : unit -> unit = {
	cycles = 8;
	PC_start = read(RES_vec + 1) @ read(RES_vec);
	reg(name(PC_H)) = PC_start[15..8]; reg(name(PC_L)) = PC_start[7..0]
}

function main() : unit -> unit = {
	my_program();

	let state = print_state();

	setup();

	while (fetch_decode_execute(true)) do ();
}