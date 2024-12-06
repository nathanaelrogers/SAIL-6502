val modify_flags_CPY : (bits(9)) -> unit
function modify_flags_CPY(result) = {
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

	// carry
	if (signed(result) >= 0) then
		set_flag_c(0b1)
	else
		set_flag_c(0b0)
}

val CPY : (word) -> bool
function CPY(op) = {
	let result : bits(9) = EXTZ(9, reg_Y) + (EXTZ(9, not_vec(op)) + EXTZ(9, 0b1));
	modify_flags_CPY(result);
	reg_A = result[7..0];
	true
}

function clause execute(CPY_IMM(op))   = {
	let word = calc_word(mode(imm), op);
	CPY(word)
}
function clause execute(CPY_ZP(op))    = {
	let word = calc_word(mode(zp), op);
	CPY(read_zp(word))
}
function clause execute(CPY_ABS(op))   = {
	let addr = calc_addr(mode(abs), op);
	CPY(read(addr))
}