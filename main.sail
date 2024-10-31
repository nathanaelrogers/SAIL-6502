default Order dec
$include <prelude.sail>
$include "prelude.sail"
$include "types.sail"
$include "registers.sail"
$include "memory.sail"
$include "timing.sail"
$include "addressing.sail"
$include "instruction-decode.sail"
$include "assembly-print.sail"
$include "interrupts.sail"
$include "programs.sail"

function print_state() : unit -> unit = {
	print_endline("==state after execution==");
	print_bits("A: ", access(name(A)));
	print_bits("X: ", access(name(X)));
	print_bits("Y: ", access(name(Y)));
	print_bits("SP: ", access(name(SP)));
	print_bits("PC: ", access(name(PC_H)) @ access(name(PC_L)));
	print_bits("n: ", flag_n());
	print_bits("v: ", flag_v());
	print_bits("b: ", flag_b());
	print_bits("d: ", flag_d());
	print_bits("i: ", flag_i());
	print_bits("z: ", flag_z());
	print_bits("c: ", flag_c());
	print_endline(concat_str("Cycles passed: ", dec_str(cycles)));
	print_endline(concat_str("Instructions completed: ", dec_str(instructions_done)));
}

function fetch_decode_execute(last_execute) : bool -> unit = {
	let PC : address = access(name(PC_H)) @ access(name(PC_L));
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
	// Initialise the PC
	access(name(PC_H)) = read(RES_vec + 1);
	access(name(PC_L)) = read(RES_vec);

	access(name(A)) = undefined;
	// init some flags, leave EVERYTHING  else undefined...
}

function main() : unit -> unit = {
	setup_program1();

	setup();

	let state = print_state();

	fetch_decode_execute(false);
}