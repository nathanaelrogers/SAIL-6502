default Order dec
$include <prelude.sail>
$include "sail_src/types.sail"
$include "sail_src/prelude.sail"
$include "sail_src/decimal-mode.sail"
$include "sail_src/registers.sail"
$include "sail_src/interrupts.sail"
$include "sail_src/addressing.sail"
$include "sail_src/instruction-ast.sail"
$include "sail_src/decode.sail"
$include "sail_src/config.sail"
$include "sail_src/assembly-print.sail"

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
	print_endline(concat_str("total cycles: ", dec_str(cycles)));
	print_endline(concat_str("total instructions: ", dec_str(instructions_done)));
}

function fetch_decode_execute() : unit -> bool = {
	consume_input();

	check_for_interrupt();

	let start_PC : address = reg_PC;

	let cycles_before : int = cycles;

	let instruction = read(start_PC);

	incr_pc(1);

	let decoded = decode(instruction);

	let execute_success = execute(decoded);

	if (execute_success) then
		instructions_done = instructions_done + 1;

	let asm = assembly(start_PC, decoded);

	if (enable_print_dump) then {
		print_endline(concat_str("\n", concat_str(bits_str(start_PC), concat_str(" ", asm))));

		if (execute_success) then
			print_state(cycles - cycles_before);
	};

	if enable_print_at_interval then
		if (instructions_done % 1000 == 0) then {
			print_endline(concat_str("\n", concat_str(bits_str(start_PC), concat_str(" ", asm))));

			if (execute_success) then
				print_state(cycles - cycles_before);
		};

	if enable_break_at_trap then
		if (start_PC == reg_PC) then {
			print_bits("trapped PC: ", start_PC);
			return false;
		};

	return execute_success;
}

function main() : unit -> unit = {
	terminal_init(); // defined in io.c
	memory_init();   // defined in io.c
	load_config();   // defined in config.sail

	while (fetch_decode_execute()) do {()};

	if enable_print_mem then
		print_memory();

	print_endline(concat_str("total cycle count: ", dec_str(cycles)));
	print_endline(concat_str("total instructions: ", dec_str(instructions_done)));
}