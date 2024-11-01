// val modify_flags_ADC : bits(9) -> unit
// function modify_flags_ADC(result) = {
// 	if ([result[7]] == 0b1)                 then set_flag_n(0b1) else set_flag_n(0b0); // negative
// 	if ([result[7]] != [access(reg(A))[7]]) then set_flag_v(0b1) else set_flag_v(0b0); // overflow
// 	if (result[7..0] == 0x00)               then set_flag_z(0b1) else set_flag_z(0b0); // zero
// 	if ([result[8]] == 0b1)                 then set_flag_c(0b1) else set_flag_c(0b0); // carry
// }

// how does sail addition behave? will it do two's complement by default??
// how to implement decimal mode addition?
// how to check for overflow correctly?
val ADC : (word) -> bool
function ADC(op) = {
	let result : int = signed(access(reg(A))) + signed(op) + signed(flag_c());
	print_endline(dec_str(result));
	// modify_flags_ADC(result);
	// access(reg(A)) = result;
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