default Order dec
$include <prelude.sail>
$include "prelude.sail"
$include "timing.sail"
$include "types.sail"
$include "interrupts.sail"
$include "registers.sail"
$include "memory.sail"
$include "addressing.sail"
$include "decimal-mode.sail"
$include "instructions.sail"
$include "decode.sail"
$include "config.sail"
$include "assembly-print.sail"

val print_state : (int) -> unit
function print_state(cycles_taken) = {
	print_bits("A: ", reg_A);
	print_bits("X: ", reg_X);
	print_bits("Y: ", reg_Y);
	print_bits("SP: ", reg_SP);
	print_bits("PC: ", reg_PC);
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

function fetch_decode_execute() : unit -> bool = {
	let cycles_before : int = cycles;

	let PC : address = reg_PC;

	let instruction = read(PC);

	incr_pc(1);

	let decoded = decode(instruction);

	let execute_success = execute(decoded);

	if (execute_success) then
		instructions_done = instructions_done + 1;

	if enable_print_dump then {
		let asm = assembly(PC, decoded);
		print_endline(concat_str("\n", concat_str(bits_str(PC), concat_str(" ", asm))));

		if (execute_success) then
			print_state(cycles - cycles_before);
	};

	if enable_print_at_interval then
		if (instructions_done % 1000000 == 0) then {
			print_endline(concat_str("instructions completed so far: ", dec_str(instructions_done)));
			print_bits("current PC: ", reg_PC);
			print_endline("");
		};

	return execute_success;
}

// PC is read from address provided in reset vector (16 bits at $FFFC).
// All other initialization is left to the program loaded.
function model_init() : unit -> unit = {
	cycles = 0;

	// it seems like everything should be undefined to begin with...
	reg_A  = undefined;
	reg_X  = undefined;
	reg_Y  = undefined;
	reg_PC = undefined;
	reg_SP = undefined;
	reg_SR[all] = undefined;
}

function main() : unit -> unit = {
	model_init();

	load_config();

	if enable_print_dump then
		print_state(cycles);

	while (fetch_decode_execute()) do {()};

	if enable_print_mem then
		print_memory();

	print_endline(concat_str("total cycle count:  ", dec_str(cycles)));
	print_endline(concat_str("total instructions: ", dec_str(instructions_done)));
}