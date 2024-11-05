default Order dec
$include <prelude.sail>
$include "prelude.sail"
$include "types.sail"
$include "registers.sail"
$include "memory.sail"
$include "timing.sail"
$include "instructions.sail"
$include "decode.sail"
$include "assembly-print.sail"
$include "interrupts.sail"
$include "programs.sail"

function print_state() : unit -> unit = {
	print_endline("==state after execution==");
	print_bits("A: ", access(reg(A)));
	print_bits("X: ", access(reg(X)));
	print_bits("Y: ", access(reg(Y)));
	print_bits("SP: ", access(reg(SP)));
	print_bits("PC: ", access(reg(PC_H)) @ access(reg(PC_L)));
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
	let PC : address = access(reg(PC_H)) @ access(reg(PC_L));
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
	// arbitrary start address for testing purposes
	write(RES_vec, 0x00);
	write(RES_vec + 1, 0x02);

	cycles = 7;
	// Initialise the PC
	access(reg(PC_H)) = read(RES_vec + 1);
	access(reg(PC_L)) = read(RES_vec);

	// it seems like everything should be undefined to begin with...
	access(reg(A))  = undefined;
	access(reg(X))  = undefined;
	access(reg(Y))  = undefined;
	access(reg(SR)) = undefined;
	access(reg(SP)) = undefined;
}

function main() : unit -> unit = {
	setup();

	setup_program_adc_test();

	let state = print_state();

	fetch_decode_execute(false);
}