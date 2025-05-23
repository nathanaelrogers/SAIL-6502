val modify_flags_increment : (word) -> unit
function modify_flags_increment(result) = {
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

// =======================================

val increment_word : (word, int) -> bool
function increment_word(op, n) = {
	let result = read_zp(op) + n;

	modify_flags_increment(result);
	write_zp(op, result);

	true
}

val increment_addr : (address, int) -> bool
function increment_addr(op, n) = {
	let result = read(op) + n;

	modify_flags_increment(result);
	write(op, result);

	true
}

val increment_reg_X : (int) -> bool
function increment_reg_X(n) = {
	let result = reg_X + n;
	reg_X = result;
	modify_flags_increment(result);
	true
}

val increment_reg_Y : (int) -> bool
function increment_reg_Y(n) = {
	let result = reg_Y + n;
	reg_Y = result;
	modify_flags_increment(result);
	true
}

// =======================================

function clause execute(DEC_ZP(op))    = {
	incr_cycles(5);
	increment_word(calc_word(mode(zp), op), -1)
}
function clause execute(DEC_ZP_X(op))  = {
	incr_cycles(6);
	increment_word(calc_word(mode(zp_x), op), -1)
}
function clause execute(DEC_ABS(op))   = {
	incr_cycles(6);
	increment_addr(calc_addr(mode(abs), op), -1)
}
function clause execute(DEC_ABS_X(op)) = {
	incr_cycles(7);
	increment_addr(calc_addr(mode(abs_x), op), -1)
}
function clause execute(DEX()) = {
	incr_cycles(2);
	increment_reg_X(-1)
}
function clause execute(DEY()) = {
	incr_cycles(2);
	increment_reg_Y(-1)
}

// =======================================

function clause execute(INC_ZP(op))    = {
	incr_cycles(5);
	increment_word(calc_word(mode(zp), op), 1)
}
function clause execute(INC_ZP_X(op))  = {
	incr_cycles(6);
	increment_word(calc_word(mode(zp_x), op), 1)
}
function clause execute(INC_ABS(op))   = {
	incr_cycles(6);
	increment_addr(calc_addr(mode(abs), op), 1)
}
function clause execute(INC_ABS_X(op)) = {
	incr_cycles(7);
	increment_addr(calc_addr(mode(abs_x), op), 1)
}
function clause execute(INX()) = {
	incr_cycles(2);
	increment_reg_X(1)
}
function clause execute(INY()) = {
	incr_cycles(2);
	increment_reg_Y(1)
}