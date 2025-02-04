val modify_flags_ADC : (bits(9), int, word, word) -> unit
function modify_flags_ADC(result, decimal_result, op1, op2) = {
	// negative + BCD negative
	reg_SR[n] = [result[7]];

	// zero + BCD zero
	if (result[7..0] == 0x00) then
		reg_SR[z] = 0b1
	else
		reg_SR[z] = 0b0;

	// overflow
	if (reg_SR[d] == 0b0) then {
		if (([op1[7]] == [op2[7]]) & ([op1[7]] != [result[7]])) then
			reg_SR[v] = 0b1
		else
			reg_SR[v] = 0b0;
	}
	// BCD overflow (this is UNDOCUMENTED behaviour? see appendix A of 6502.org BCD tutorial)
	else {
		if (decimal_result > 127 | decimal_result < -128) then
			reg_SR[v] = 0b1
		else
			reg_SR[v] = 0b0
	};

	// carry
	if (reg_SR[d] == 0b0) then {
		if (unsigned(result) >= 256) then
			reg_SR[c] = 0b1
		else
			reg_SR[c] = 0b0
	}
	// BCD carry
	else {
		if (decimal_result >= 100) then
			reg_SR[c] = 0b1
		else
			reg_SR[c] = 0b0
	};
}

val ADC : (word) -> bool
function ADC(op) = {
	let decimal_result : int = if (reg_SR[d] == 0b0)
		then {
			0
		} else {
			let carry : int = if (reg_SR[c] == 0b1) then 1 else 0;
			decimal_add(reg_A, op) + carry
		};
	let result : bits(9) = if (reg_SR[d] == 0b0)
		then {
			EXTZ(9, reg_A) + EXTZ(9, op) + EXTZ(9, reg_SR[c])
		} else {
			EXTZ(9, decimal_to_word(decimal_result))
		};
	modify_flags_ADC(result, decimal_result, reg_A, op);
	reg_A = result[7..0];
	true
}

function clause execute(ADC_IMM(op))   = {
	incr_cycles(1);
	let word = calc_word(mode(imm), op);
	ADC(word)
}
function clause execute(ADC_ZP(op))    = {
	incr_cycles(1);
	let word = calc_word(mode(zp), op);
	ADC(read_zp(word))
}
function clause execute(ADC_ZP_X(op))  = {
	incr_cycles(1);
	let word = calc_word(mode(zp_x), op);
	ADC(read_zp(word))
}
function clause execute(ADC_ABS(op))   = {
	incr_cycles(1);
	let addr = calc_addr(mode(abs), op);
	ADC(read(addr))
}
function clause execute(ADC_ABS_X(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(abs_x), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	ADC(read(addr))
}
function clause execute(ADC_ABS_Y(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(abs_y), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	ADC(read(addr))
}
function clause execute(ADC_IND_X(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(ind_x), op);
	ADC(read(addr))
}
function clause execute(ADC_IND_Y(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(ind_y), op);
	ADC(read(addr))
}