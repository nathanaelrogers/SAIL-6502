val modify_flags_ASL : (word, word) -> unit
function modify_flags_ASL(input, result) = {
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

function clause execute(ASL()) = {
	incr_cycles(2);
	let input = reg_A;

	let result = input << 1;
	reg_A = result;
	modify_flags_ASL(input, result);

	true
}
function clause execute(ASL_ZP(op)) = {
	incr_cycles(5);
	let addr = calc_word(mode(zp), op);
	let input = read_zp(addr);

	let result = input << 1;
	write_zp(addr, result);
	modify_flags_ASL(input, result);

	true
}
function clause execute(ASL_ZP_X(op)) = {
	incr_cycles(6);
	let addr = calc_word(mode(zp_x), op);
	let input = read_zp(addr);

	let result = input << 1;
	write_zp(addr, result);
	modify_flags_ASL(input, result);

	true
}
function clause execute(ASL_ABS(op)) = {
	incr_cycles(6);
	let addr = calc_addr(mode(abs), op);
	let input = read(addr);

	let result = input << 1;
	write(addr, result);
	modify_flags_ASL(input, result);

	true
}
function clause execute(ASL_ABS_X(op)) = {
	incr_cycles(7);
	let addr = calc_addr(mode(abs_x), op);
	let input = read(addr);

	let result = input << 1;
	write(addr, result);
	modify_flags_ASL(input, result);

	true
}