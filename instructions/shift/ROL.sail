val modify_flags_ROL : (word, word) -> unit
function modify_flags_ROL(input, result) = {
	// negative
	if (signed(result) < 0) then
		reg_SR[n] = 0b1
	else
		reg_SR[n] = 0b0;

	// zero
	if (unsigned(result) == 0) then
		reg_SR[z] = 0b1
	else
		reg_SR[z] = 0b0;

	// carry
	reg_SR[c] = [input[7]]
}

function clause execute(ROL()) = {
	let input = reg_A;

	let result = input[6..0] @ reg_SR[c];
	reg_A = result;
	modify_flags_ROL(input, result);

	incr_cycles(2);
	true
}
function clause execute(ROL_ZP(op)) = {
	let addr = calc_word(mode(zp), op);
	let input = read_zp(addr);

	let result = input[6..0] @ reg_SR[c];
	write_zp(addr, result);
	modify_flags_ROL(input, result);

	incr_cycles(3);
	true
}
function clause execute(ROL_ZP_X(op)) = {
	let addr = calc_word(mode(zp_x), op);
	let input = read_zp(addr);

	let result = input[6..0] @ reg_SR[c];
	write_zp(addr, result);
	modify_flags_ROL(input, result);

	incr_cycles(3);
	true
}
function clause execute(ROL_ABS(op)) = {
	let addr = calc_addr(mode(abs), op);
	let input = read(addr);

	let result = input[6..0] @ reg_SR[c];
	write(addr, result);
	modify_flags_ROL(input, result);

	incr_cycles(3);
	true
}
function clause execute(ROL_ABS_X(op)) = {
	let addr = calc_addr(mode(abs_x), op);
	let input = read(addr);

	let result = input[6..0] @ reg_SR[c];
	write(addr, result);
	modify_flags_ROL(input, result);

	incr_cycles(5);
	true
}