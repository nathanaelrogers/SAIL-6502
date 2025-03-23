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

	let next : word = try_read_char();
	if (next != 0x00) then {
		control_reg  = control_reg | 0x08;
		input_buffer = next;
	};

	print_bits("input now: ", next);
	print_bits("buffered input: ", input_buffer);
	print_bits("control reg: ", control_reg);
	print_endline("");

	return execute_success;
}

// PC is read from address provided in reset vector (16 bits at $FFFC).
// All other initialization is left to the program loaded.
function model_init() : unit -> unit = {
	let PCH : word = read(RST_vec + 1);
	let PCL : word = read(RST_vec);

	reg_PC[15..8] = PCH;
	reg_PC[7..0]  = PCL;

	reg_A  = undefined;
	reg_X  = undefined;
	reg_Y  = undefined;
	reg_SP = undefined;
	reg_SR[all] = undefined;

	main_mem = vector_init(256, vector_init(256, undefined));

	cycles = 0;
	instructions_done = 0;
}

function main() : unit -> unit = {
	setup_terminal();
	model_init();
	load_config();

	while (fetch_decode_execute()) do {()};

	if enable_print_mem then
		print_memory();

	print_endline(concat_str("total cycle count: ", dec_str(cycles)));
	print_endline(concat_str("total instructions: ", dec_str(instructions_done)));
}