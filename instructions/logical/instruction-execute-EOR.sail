val modify_flags_EOR : word -> unit
function modify_flags_EOR(result) = {
	 // negative
	if (signed(result[7..0]) < 0) then
		set_flag_n(0b1)
	else
		set_flag_n(0b0);

	// zero
	if (unsigned(result[7..0]) == 0) then
		set_flag_z(0b1)
	else
		set_flag_z(0b0);
}

val EOR : (word) -> bool
function EOR(op) = {
	let result = reg_A ^ op;
	modify_flags_EOR(result);
	reg_A = result;
	true
}

function clause execute(EOR_IMM(op))   = {
	let word = calc_word(mode(imm), op);
	EOR(word)
}
function clause execute(EOR_ZP(op))    = {
	let word = calc_word(mode(zp), op);
	EOR(read_zp(word))
}
function clause execute(EOR_ZP_X(op))  = {
	let word = calc_word(mode(zp_x), op);
	EOR(read_zp(word))
}
function clause execute(EOR_ABS(op))   = {
	let addr = calc_addr(mode(abs), op);
	EOR(read(addr))
}
function clause execute(EOR_ABS_X(op)) = {
	let addr = calc_addr(mode(abs_x), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	EOR(read(addr))
}
function clause execute(EOR_ABS_Y(op)) = {
	let addr = calc_addr(mode(abs_y), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	EOR(read(addr))
}
function clause execute(EOR_IND_X(op)) = {
	let addr = calc_addr(mode(ind_x), op);
	EOR(read(addr))
}
function clause execute(EOR_IND_Y(op)) = {
	let addr = calc_addr(mode(ind_y), op);
	EOR(read(addr))
}