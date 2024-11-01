val modify_flags_ADC : (bits(9), word, word) -> unit
function modify_flags_ADC(result, op1, op2) = {
	if (signed(result[7..0]) < 0)
		then set_flag_n(0b1) else set_flag_n(0b0); // negative

	if ([op1[7]] == [op2[7]] & [result[7]] != [op1[7]])
		then set_flag_v(0b1) else set_flag_v(0b0); // overflow

	if (signed(result[7..0]) == 0)
		then set_flag_z(0b1) else set_flag_z(0b0); // zero

	if (unsigned(result) >= 256)
		then set_flag_c(0b1) else set_flag_c(0b0); // carry
}

// how to implement decimal mode addition?
val ADC : (word) -> bool
function ADC(op) = {
	let result : bits(9) = EXTZ(9, access(reg(A))) + EXTZ(9, op) + EXTZ(9, flag_c());
	modify_flags_ADC(result, access(reg(A)), op);
	access(reg(A)) = result[7..0];
	true
}

function clause execute(ADC_IMM(op))   = ADC(get_op(mode(imm), op))
function clause execute(ADC_ZP(op))    = ADC(get_op(mode(zp), op))
function clause execute(ADC_ZP_X(op))  = ADC(get_op(mode(zp_x), op))
function clause execute(ADC_ABS(op))   = ADC(get_op(mode(abs), op))
function clause execute(ADC_ABS_X(op)) = ADC(get_op(mode(abs_x), op))
function clause execute(ADC_ABS_Y(op)) = ADC(get_op(mode(abs_y), op))
function clause execute(ADC_IND_X(op)) = ADC(get_op(mode(ind_x), op))
function clause execute(ADC_IND_Y(op)) = ADC(get_op(mode(ind_y), op))