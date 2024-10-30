// TODO : modify flags correctly


// No memory access, ORA the A register with immediate value.
function clause assembly(ORA_IMM(op)) = concat_str("AND ", concat_str("#", my_hex_str(op)))
function clause execute(ORA_IMM(op)) = {
	let result = reg(name(A)) | op;
	incr_cycles();
	reg(name(A)) = result;
	true
}
// No address calculation needed, zero-page memory access with provided word.
function clause assembly(ORA_ZP(op)) = concat_str("AND ", my_hex_str(op))
function clause execute(ORA_ZP(op)) = {
	let result = reg(name(A)) | read(op);
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Effective address affects the low byte only (overflow wraps around inside zero-page).
function clause assembly(ORA_ZP_X(op)) = concat_str("AND ", concat_str(my_hex_str(op), ",X"))
function clause execute(ORA_ZP_X(op)) = {
	let ea = op + reg(name(X));
	let result = reg(name(A)) | read(ea);
	incr_cycles();
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// No address calculation needed, memory access with provided address.
function clause assembly(ORA_ABS(op)) = concat_str("AND ", my_hex_str(op))
function clause execute(ORA_ABS(op)) = {
	let result = reg(name(A)) | read(op);
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Address calculation may affect the high byte (16 bit address plus X).
function clause assembly(ORA_ABS_X(op)) = concat_str("AND ", concat_str(my_hex_str(op), ",X"))
function clause execute(ORA_ABS_X(op)) = {
	let ea = op + EXTZ(16, reg(name(X)));
	let result = reg(name(A)) | read(ea);
	if (op[15..8] != ea[15..8]) then {incr_cycles(); print_bits("page boundary crossed, now in page: ", ea[15..8])};
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Address calculation may affect the high byte (16 bit address plus Y).
function clause assembly(ORA_ABS_Y(op)) = concat_str("AND ", concat_str(my_hex_str(op), ",Y"))
function clause execute(ORA_ABS_Y(op)) = {
	let ea = op + EXTZ(16, reg(name(Y)));
	let result = reg(name(A)) | read(ea);
	if (op[15..8] != ea[15..8]) then {incr_cycles(); print_bits("page boundary crossed, now in page: ", ea[15..8])};
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Address calculation effects the low byte only. Memory at effective address holds a pointer to data (LLHH).
function clause assembly(ORA_IND_X(op)) = concat_str("AND ", concat_str(concat_str("(", my_hex_str(op)), ",X)"))
function clause execute(ORA_IND_X(op)) = {
	let ea = op + reg(name(X));
	let pointer = read(ea + 1) @ read(ea);
	let result = reg(name(A)) | read(pointer);
	incr_cycles();
	incr_cycles();
	incr_cycles();
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Operand gives location (in zero-page) of pointer to data (LLHH). Address calculation comes AFTER and may affect the high byte.
function clause assembly(ORA_IND_Y(op)) = concat_str("AND ", concat_str(concat_str("(", my_hex_str(op)), "),Y"))
function clause execute(ORA_IND_Y(op)) = {
	let pointer = read(op + 1) @ read(op);
	let ea = pointer + EXTZ(16, reg(name(Y)));
	if (pointer[15..8] != ea[15..8]) then {incr_cycles(); print_bits("page boundary crossed, now in page: ", ea[15..8])};
	let result = reg(name(A)) | read(ea);
	incr_cycles();
	incr_cycles();
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}