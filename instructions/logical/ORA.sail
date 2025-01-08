val modify_flags_ORA : word -> unit
function modify_flags_ORA(result) = {
	 // negative
	if (signed(result[7..0]) < 0) then
		reg_SR[n] = 0b1
	else
		reg_SR[n] = 0b0;

	// zero
	if (unsigned(result[7..0]) == 0) then
		reg_SR[z] = 0b1
	else
		reg_SR[z] = 0b0;
}

val ORA : (word) -> bool
function ORA(op) = {
	let result = reg_A | op;
	modify_flags_ORA(result);
	reg_A = result;
	true
}

function clause execute(ORA_IMM(op))   = {
	let word = calc_word(mode(imm), op);
	ORA(word)
}
function clause execute(ORA_ZP(op))    = {
	let word = calc_word(mode(zp), op);
	ORA(read_zp(word))
}
function clause execute(ORA_ZP_X(op))  = {
	let word = calc_word(mode(zp_x), op);
	ORA(read_zp(word))
}
function clause execute(ORA_ABS(op))   = {
	let addr = calc_addr(mode(abs), op);
	ORA(read(addr))
}
function clause execute(ORA_ABS_X(op)) = {
	let addr = calc_addr(mode(abs_x), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	ORA(read(addr))
}
function clause execute(ORA_ABS_Y(op)) = {
	let addr = calc_addr(mode(abs_y), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	ORA(read(addr))
}
function clause execute(ORA_IND_X(op)) = {
	let addr = calc_addr(mode(ind_x), op);
	ORA(read(addr))
}
function clause execute(ORA_IND_Y(op)) = {
	let addr = calc_addr(mode(ind_y), op);
	ORA(read(addr))
}