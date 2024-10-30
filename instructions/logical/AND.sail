// No memory access, AND the A register with immediate value.
function clause assembly(AND_IMM(op)) = concat_str("AND ", concat_str("#", my_hex_str(op)))
function clause execute(AND_IMM(op)) = {
	let result = reg(name(A)) & op;
	if (result == 0x00) then set_flag_z(0b1) else set_flag_z(0b0);
	if (result[7] == bitone) then set_flag_n(0b1) else set_flag_n(0b0);
	incr_cycles();
	reg(name(A)) = result;
	true
}
// No address calculation needed, zero-page memory access with provided word.
function clause assembly(AND_ZP(op)) = concat_str("AND ", my_hex_str(op))
function clause execute(AND_ZP(op)) = {
	let result = reg(name(A)) & read(op);
	if (result == 0x00) then set_flag_z(0b1) else set_flag_z(0b0);
	if (result[7] == bitone) then set_flag_n(0b1) else set_flag_n(0b0);
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Effective address affects the low byte only (overflow wraps around inside zero-page).
function clause assembly(AND_ZP_X(op)) = concat_str("AND ", concat_str(my_hex_str(op), ",X"))
function clause execute(AND_ZP_X(op)) = {
	let ea = op + reg(name(X));
	let result = reg(name(A)) & read(ea);
	if (result == 0x00) then set_flag_z(0b1) else set_flag_z(0b0);
	if (result[7] == bitone) then set_flag_n(0b1) else set_flag_n(0b0);
	incr_cycles();
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// No address calculation needed, memory access with provided address.
function clause assembly(AND_ABS(op)) = concat_str("AND ", my_hex_str(op))
function clause execute(AND_ABS(op)) = {
	let result = reg(name(A)) & read(op);
	if (result == 0x00) then set_flag_z(0b1) else set_flag_z(0b0);
	if (result[7] == bitone) then set_flag_n(0b1) else set_flag_n(0b0);
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Address calculation may affect the high byte (16 bit address plus X).
function clause assembly(AND_ABS_X(op)) = concat_str("AND ", concat_str(my_hex_str(op), ",X"))
function clause execute(AND_ABS_X(op)) = {
	let ea = op + EXTZ(16, reg(name(X)));
	let result = reg(name(A)) & read(ea);
	if (result == 0x00) then set_flag_z(0b1) else set_flag_z(0b0);
	if (result[7] == bitone) then set_flag_n(0b1) else set_flag_n(0b0);
	if (op[15..8] != ea[15..8]) then {incr_cycles(); print_bits("page boundary crossed, now in page: ", ea[15..8])};
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Address calculation may affect the high byte (16 bit address plus Y).
function clause assembly(AND_ABS_Y(op)) = concat_str("AND ", concat_str(my_hex_str(op), ",Y"))
function clause execute(AND_ABS_Y(op)) = {
	let ea = op + EXTZ(16, reg(name(Y)));
	let result = reg(name(A)) & read(ea);
	if (result == 0x00) then set_flag_z(0b1) else set_flag_z(0b0);
	if (result[7] == bitone) then set_flag_n(0b1) else set_flag_n(0b0);
	if (op[15..8] != ea[15..8]) then {incr_cycles(); print_bits("page boundary crossed, now in page: ", ea[15..8])};
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Address calculation effects the low byte only. Memory at effective address holds a pointer to data (LLHH).
function clause assembly(AND_IND_X(op)) = concat_str("AND ", concat_str(concat_str("(", my_hex_str(op)), ",X)"))
function clause execute(AND_IND_X(op)) = {
	let ea = op + reg(name(X));
	let pointer = read(ea + 1) @ read(ea);
	let result = reg(name(A)) & read(pointer);
	if (result == 0x00) then set_flag_z(0b1) else set_flag_z(0b0);
	if (result[7] == bitone) then set_flag_n(0b1) else set_flag_n(0b0);
	incr_cycles();
	incr_cycles();
	incr_cycles();
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Operand gives location (in zero-page) of pointer to data (LLHH). Address calculation comes AFTER and may affect the high byte.
function clause assembly(AND_IND_Y(op)) = concat_str("AND ", concat_str(concat_str("(", my_hex_str(op)), "),Y"))
function clause execute(AND_IND_Y(op)) = {
	let pointer = read(op + 1) @ read(op);
	let ea = pointer + EXTZ(16, reg(name(Y)));
	if (pointer[15..8] != ea[15..8]) then {incr_cycles(); print_bits("page boundary crossed, now in page: ", ea[15..8])};
	let result = reg(name(A)) & read(ea);
	if (result == 0x00) then set_flag_z(0b1) else set_flag_z(0b0);
	if (result[7] == bitone) then set_flag_n(0b1) else set_flag_n(0b0);
	incr_cycles();
	incr_cycles();
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}