val modify_flags_EOR : word -> unit
function modify_flags_EOR(result) = {
	if (signed(result) < 0)  then set_flag_n(0b1) else set_flag_n(0b0); // negative
	if (signed(result) == 0) then set_flag_z(0b1) else set_flag_z(0b0); // zero
}

val EOR : (word) -> bool
function EOR(op) = {
	let result = reg_A ^ op;
	modify_flags_EOR(result);
	reg_A = result;
	true
}

function clause execute(EOR_IMM(op))   = {
	let word = calc_from_word(mode(imm), op);
	EOR(word)
}
function clause execute(EOR_ZP(op))    = {
	let word = calc_from_word(mode(zp), op);
	EOR(read_zp(word))
}
function clause execute(EOR_ZP_X(op))  = {
	let word = calc_from_word(mode(zp_x), op);
	EOR(read_zp(word))
}
function clause execute(EOR_ABS(op))   = {
	let addr = calc_from_addr(true, mode(abs), op);
	EOR(read(addr))
}
function clause execute(EOR_ABS_X(op)) = {
	let addr = calc_from_addr(true, mode(abs_x), op);
	EOR(read(addr))
}
function clause execute(EOR_ABS_Y(op)) = {
	let addr = calc_from_addr(true, mode(abs_y), op);
	EOR(read(addr))
}
function clause execute(EOR_IND_X(op)) = {
	let addr = calc_from_word(true, mode(ind_x), op);
	EOR(read(addr))
}
function clause execute(EOR_IND_Y(op)) = {
	let addr = calc_from_word(true, mode(ind_y), op);
	EOR(read(addr))
}