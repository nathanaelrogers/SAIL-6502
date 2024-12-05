default Order dec
$include <prelude.sail>
$include "prelude.sail"
$include "types.sail"
$include "registers.sail"
$include "memory.sail"
$include "timing.sail"
$include "addressing.sail"
$include "decimal-mode.sail"
$include "instructions.sail"
$include "decode.sail"
$include "assembly-print.sail"
$include "interrupts.sail"

val print_state : (int) -> unit
function print_state(cycles_taken) = {
	print_bits("A: ", reg_A);
	print_bits("X: ", reg_X);
	print_bits("Y: ", reg_Y);
	print_bits("SP: ", reg_SP);
	print_bits("PC: ", reg_PC[15..8] @ reg_PC[7..0]);
	print_bits("n: ", reg_SR[n]);
	print_bits("v: ", reg_SR[v]);
	print_bits("b: ", reg_SR[b]);
	print_bits("d: ", reg_SR[d]);
	print_bits("i: ", reg_SR[i]);
	print_bits("z: ", reg_SR[z]);
	print_bits("c: ", reg_SR[c]);
	print_endline(concat_str("cycles: ", dec_str(cycles_taken)));
	print_bits("NMI: ", NMI);
	print_bits("RST: ", RST);
	print_bits("IRQ: ", IRQ);
	print_endline(concat_str("total cycles: ", dec_str(cycles)));
	print_endline(concat_str("total instructions: ", dec_str(instructions_done)));
}

function fetch_decode_execute(last_execute) : bool -> unit = {
	let cycles_before : int = cycles;

	let PC : address = reg_PC[15..8] @ reg_PC[7..0];
	let instruction = read(PC);

	incr_pc();

	let decoded = decode(instruction);
	let asm = assembly(decoded);

	let last_execute = execute(decoded);
	if (last_execute) then instructions_done = instructions_done + 1;

	print_endline(concat_str("\nfetch done: ", asm));
	let state = print_state(cycles - cycles_before);

	if (last_execute) then fetch_decode_execute(true);
}

// PC is read from address provided in reset vector (16 bits at $FFFC).
// All other initialization is left to the program loaded.
function setup() : unit -> unit = {
	cycles = 7;
	// Initialise the PC
	reg_PC[15..8] = read(RST_vec + 1);
	reg_PC[7..0]  = read(RST_vec);

	// it seems like everything should be undefined to begin with...
	reg_A  = undefined;
	reg_X  = undefined;
	reg_Y  = undefined;
	reg_SR = undefined;
	reg_SP = undefined;
}

function main() : unit -> unit = {
	setup();
	let state = print_state(cycles);
	fetch_decode_execute(false);
}