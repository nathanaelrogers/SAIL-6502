val modify_flags_ORA : word -> unit
function modify_flags_ORA(result) = {
	if (signed(result) < 0)  then set_flag_n(0b1) else set_flag_n(0b0); // negative
	if (signed(result) == 0) then set_flag_z(0b1) else set_flag_z(0b0); // zero
}

val ORA : (word) -> bool
function ORA(op) = {
	let result = reg_A | op;
	modify_flags_ORA(result);
	reg_A = result;
	true
}

function clause execute(ORA_IMM(op))   = {
	let word = calc_from_word(mode(imm), op);
	ORA(word)
}
function clause execute(ORA_ZP(op))    = {
	let word = calc_from_word(mode(zp), op);
	ORA(read_zp(word))
}
function clause execute(ORA_ZP_X(op))  = {
	let word = calc_from_word(mode(zp_x), op);
	ORA(read_zp(word))
}
function clause execute(ORA_ABS(op))   = {
	let addr = calc_from_addr(true, mode(abs), op);
	ORA(read(addr))
}
function clause execute(ORA_ABS_X(op)) = {
	let addr = calc_from_addr(true, mode(abs_x), op);
	ORA(read(addr))
}
function clause execute(ORA_ABS_Y(op)) = {
	let addr = calc_from_addr(true, mode(abs_y), op);
	ORA(read(addr))
}
function clause execute(ORA_IND_X(op)) = {
	let addr = calc_from_word(true, mode(ind_x), op);
	ORA(read(addr))
}
function clause execute(ORA_IND_Y(op)) = {
	let addr = calc_from_word(true, mode(ind_y), op);
	ORA(read(addr))
}