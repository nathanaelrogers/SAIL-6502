val modify_flags_LDX : word -> unit
function modify_flags_LDX(result) = {
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

val LDX : (word) -> bool
function LDX(op) = {
	modify_flags_LDX(op);
	reg_X = op;
	true
}

function clause execute(LDX_IMM(op))   = {
	let word = calc_from_word(mode(imm), op);
	LDX(word)
}
function clause execute(LDX_ZP(op))    = {
	let word = calc_from_word(mode(zp), op);
	LDX(read_zp(word))
}
function clause execute(LDX_ZP_Y(op))  = {
	let word = calc_from_word(mode(zp_y), op);
	LDX(read_zp(word))
}
function clause execute(LDX_ABS(op))   = {
	let addr = calc_from_addr(true, mode(abs), op);
	LDX(read(addr))
}
function clause execute(LDX_ABS_Y(op)) = {
	let addr = calc_from_addr(true, mode(abs_y), op);
	LDX(read(addr))
}