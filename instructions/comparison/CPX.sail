val modify_flags_CPX : (bits(9)) -> unit
function modify_flags_CPX(result) = {
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

	// carry
	if (signed(result) >= 0) then
		reg_SR[c] = 0b1
	else
		reg_SR[c] = 0b0
}

// THERE IS A BUG HERE...
val CPX : (word) -> bool
function CPX(op) = {
	let result : bits(9) = EXTZ(9, reg_X) - EXTZ(9, op);
	modify_flags_CPX(result);
	true
}

function clause execute(CPX_IMM(op))   = {
	let word = calc_word(mode(imm), op);
	CPX(word)
}
function clause execute(CPX_ZP(op))    = {
	let word = calc_word(mode(zp), op);
	CPX(read_zp(word))
}
function clause execute(CPX_ABS(op))   = {
	let addr = calc_addr(mode(abs), op);
	CPX(read(addr))
}