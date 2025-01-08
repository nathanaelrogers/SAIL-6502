val modify_flags_LDY : word -> unit
function modify_flags_LDY(result) = {
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

val LDY : (word) -> bool
function LDY(op) = {
	modify_flags_LDY(op);
	reg_Y = op;
	true
}

function clause execute(LDY_IMM(op))   = {
	let word = calc_word(mode(imm), op);
	LDY(word)
}
function clause execute(LDY_ZP(op))    = {
	let word = calc_word(mode(zp), op);
	LDY(read_zp(word))
}
function clause execute(LDY_ZP_X(op))  = {
	let word = calc_word(mode(zp_x), op);
	LDY(read_zp(word))
}
function clause execute(LDY_ABS(op))   = {
	let addr = calc_addr(mode(abs), op);
	LDY(read(addr))
}
function clause execute(LDY_ABS_X(op)) = {
	let addr = calc_addr(mode(abs_x), op);
	LDY(read(addr))
}