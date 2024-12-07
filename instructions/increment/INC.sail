val modify_flags_INC : (word) -> unit
function modify_flags_INC(result) = {
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

val INC_word : (word) -> bool
function INC_word(op) = {
	let result = read_zp(op) + 1;
	modify_flags_INC(result);
	write_zp(op, result);
	true
}

val INC_addr : (address) -> bool
function INC_addr(op) = {
	let result = read(op) + 1;
	modify_flags_INC(result);
	write(op, result);
	true
}

function clause execute(INC_ZP(op))    = {
	incr_cycles(2);
	INC_word(calc_word(mode(zp), op))
}
function clause execute(INC_ZP_X(op))  = {
	incr_cycles(2);
	INC_word(calc_word(mode(zp_x), op))
}
function clause execute(INC_ABS(op))   = {
	incr_cycles(2);
	INC_addr(calc_addr(mode(abs), op))
}
function clause execute(INC_ABS_X(op)) = {
	incr_cycles(3);
	INC_addr(calc_addr(mode(abs_x), op))
}
