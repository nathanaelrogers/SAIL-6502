val modify_flags_bit : (word, word) -> unit
function modify_flags_bit(input, result) = {
	// negative
	reg_SR[n] = [input[7]];

	// zero
	if (unsigned(result) == 0) then
		reg_SR[z] = 0b1
	else
		reg_SR[z] = 0b0;

	// overflow
	reg_SR[v] = [input[6]]
}

val BIT : (word) -> bool
function BIT(input) = {
	incr_cycles(1);
	let result = reg_A & input;
	modify_flags_bit(input, result);
	true
}

function clause execute(BIT_ZP(op)) = {
	let addr = calc_word(mode(zp), op);
	let input = read_zp(addr);
	BIT(input)
}
function clause execute(BIT_ABS(op)) = {
	let addr = calc_addr(mode(abs), op);
	let input = read(addr);
	BIT(input)
}