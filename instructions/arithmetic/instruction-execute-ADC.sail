//TODO: spend some time checking out behaviour of V flag in BCD mode for SBC and ADC!!

val modify_flags_ADC : (bits(9), int, word, word) -> unit
function modify_flags_ADC(result, decimal_result, op1, op2) = {
	if (signed(result[7..0]) < 0)
		then set_flag_n(0b1) else set_flag_n(0b0); // negative

	if (signed(result) > 127 | signed(result) < -128)
		then set_flag_v(0b1) else set_flag_v(0b0); // overflow

	if (signed(result[7..0]) == 0)
		then set_flag_z(0b1) else set_flag_z(0b0); // zero

	if (unsigned(result) >= 256 | decimal_result >= 100)
		then set_flag_c(0b1) else set_flag_c(0b0); // carry
}

val ADC : (word) -> bool
function ADC(op) = {
	let decimal_result : int = if (flag_d() == 0b0)
		then {
			0
		} else {
			decimal_add(access(reg(A)), op)
		};
	let result : bits(9) = if (flag_d() == 0b0)
		then {
			EXTZ(9, access(reg(A))) + EXTZ(9, op) + EXTZ(9, flag_c())
		} else {
			0b0 @ decimal_to_word(decimal_result)
		};
	modify_flags_ADC(result, decimal_result, access(reg(A)), op);
	access(reg(A)) = result[7..0];
	true
}

function clause execute(ADC_IMM(op))   = {
	let word = calc_from_word(mode(imm), op);
	ADC(word)
}
function clause execute(ADC_ZP(op))    = {
	let word = calc_from_word(mode(zp), op);
	ADC(read_zp(word))
}
function clause execute(ADC_ZP_X(op))  = {
	let word = calc_from_word(mode(zp_x), op);
	ADC(read_zp(word))
}
function clause execute(ADC_ABS(op))   = {
	let addr = calc_from_addr(true, mode(abs), op);
	ADC(read(addr))
}
function clause execute(ADC_ABS_X(op)) = {
	let addr = calc_from_addr(true, mode(abs_x), op);
	ADC(read(addr))
}
function clause execute(ADC_ABS_Y(op)) = {
	let addr = calc_from_addr(true, mode(abs_y), op);
	ADC(read(addr))
}
function clause execute(ADC_IND_X(op)) = {
	let addr = calc_from_word(true, mode(ind_x), op);
	ADC(read(addr))
}
function clause execute(ADC_IND_Y(op)) = {
	let addr = calc_from_word(true, mode(ind_y), op);
	ADC(read(addr))
}