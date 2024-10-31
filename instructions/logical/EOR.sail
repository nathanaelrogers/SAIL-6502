// TODO : modify flags correctly


// No memory access, EOR the A register with immediate value.
function clause assembly(EOR_IMM(op)) = concat_str("EOR ", concat_str("#", my_hex_str(op)))
function clause execute(EOR_IMM(op)) = {
	let result = reg(reg(A)) ^ op;
	incr_cycles();
	reg(reg(A)) = result;
	true
}
// No address calculation needed, zero-page memory access with provided word.
function clause assembly(EOR_ZP(op)) = concat_str("EOR ", my_hex_str(op))
function clause execute(EOR_ZP(op)) = {
	let result = reg(reg(A)) ^ read(op);
	incr_cycles();
	incr_cycles();
	reg(reg(A)) = result;
	true
}
// Effective address affects the low byte only (overflow wraps around inside zero-page).
function clause assembly(EOR_ZP_X(op)) = concat_str("EOR ", concat_str(my_hex_str(op), ",X"))
function clause execute(EOR_ZP_X(op)) = {
	let ea = op + reg(reg(X));
	let result = reg(reg(A)) ^ read(ea);
	incr_cycles();
	incr_cycles();
	incr_cycles();
	reg(reg(A)) = result;
	true
}
// No address calculation needed, memory access with provided address.
function clause assembly(EOR_ABS(op)) = concat_str("EOR ", my_hex_str(op))
function clause execute(EOR_ABS(op)) = {
	let result = reg(reg(A)) ^ read(op);
	incr_cycles();
	incr_cycles();
	reg(reg(A)) = result;
	true
}
// Address calculation may affect the high byte (16 bit address plus X).
function clause assembly(EOR_ABS_X(op)) = concat_str("EOR ", concat_str(my_hex_str(op), ",X"))
function clause execute(EOR_ABS_X(op)) = {
	let ea = op + EXTZ(16, reg(reg(X)));
	let result = reg(reg(A)) ^ read(ea);
	if (op[15..8] != ea[15..8]) then {incr_cycles(); print_bits("page boundary crossed, now in page: ", ea[15..8])};
	incr_cycles();
	incr_cycles();
	reg(reg(A)) = result;
	true
}
// Address calculation may affect the high byte (16 bit address plus Y).
function clause assembly(EOR_ABS_Y(op)) = concat_str("EOR ", concat_str(my_hex_str(op), ",Y"))
function clause execute(EOR_ABS_Y(op)) = {
	let ea = op + EXTZ(16, reg(reg(Y)));
	let result = reg(reg(A)) ^ read(ea);
	if (op[15..8] != ea[15..8]) then {incr_cycles(); print_bits("page boundary crossed, now in page: ", ea[15..8])};
	incr_cycles();
	incr_cycles();
	reg(reg(A)) = result;
	true
}
// Address calculation effects the low byte only. Memory at effective address holds a pointer to data (LLHH).
function clause assembly(EOR_IND_X(op)) = concat_str("EOR ", concat_str(concat_str("(", my_hex_str(op)), ",X)"))
function clause execute(EOR_IND_X(op)) = {
	let ea = op + reg(reg(X));
	let pointer = read(ea + 1) @ read(ea);
	let result = reg(reg(A)) ^ read(pointer);
	incr_cycles();
	incr_cycles();
	incr_cycles();
	incr_cycles();
	incr_cycles();
	reg(reg(A)) = result;
	true
}
// Operand gives location (in zero-page) of pointer to data (LLHH). Address calculation comes AFTER and may affect the high byte.
function clause assembly(EOR_IND_Y(op)) = concat_str("EOR ", concat_str(concat_str("(", my_hex_str(op)), "),Y"))
function clause execute(EOR_IND_Y(op)) = {
	let pointer = read(op + 1) @ read(op);
	let ea = pointer + EXTZ(16, reg(reg(Y)));
	if (pointer[15..8] != ea[15..8]) then {incr_cycles(); print_bits("page boundary crossed, now in page: ", ea[15..8])};
	let result = reg(reg(A)) ^ read(ea);
	incr_cycles();
	incr_cycles();
	incr_cycles();
	incr_cycles();
	reg(reg(A)) = result;
	true
}