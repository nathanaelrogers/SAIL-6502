val modify_flags_LSR : (word, word) -> unit
function modify_flags_LSR(input, result) = {
	// negative
	reg_SR[n] = 0b0;

	// zero
	if (unsigned(result) == 0) then
		reg_SR[z] = 0b1
	else
		reg_SR[z] = 0b0;

	// carry
	reg_SR[c] = [input[0]]
}

function clause execute(LSR_ACC()) = {
	let input = reg_A;

	let result = input >> 1;
	reg_A = result;
	modify_flags_LSR(input, result);

	incr_cycles(2);
	true
}
function clause execute(LSR_ZP(op)) = {
	let addr = calc_word(mode(zp), op);
	let input = read_zp(addr);

	let result = input >> 1;
	write_zp(addr, result);
	modify_flags_LSR(input, result);

	incr_cycles(3);
	true
}
function clause execute(LSR_ZP_X(op)) = {
	let addr = calc_word(mode(zp_x), op);
	let input = read_zp(addr);

	let result = input >> 1;
	write_zp(addr, result);
	modify_flags_LSR(input, result);

	incr_cycles(3);
	true
}
function clause execute(LSR_ABS(op)) = {
	let addr = calc_addr(mode(abs), op);
	let input = read(addr);

	let result = input >> 1;
	write(addr, result);
	modify_flags_LSR(input, result);

	incr_cycles(3);
	true
}
function clause execute(LSR_ABS_X(op)) = {
	let addr = calc_addr(mode(abs_x), op);
	let input = read(addr);

	let result = input >> 1;
	write(addr, result);
	modify_flags_LSR(input, result);

	incr_cycles(5);
	true
}