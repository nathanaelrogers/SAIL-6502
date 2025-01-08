val modify_flags_SBC : (bits(9), int) -> unit
function modify_flags_SBC(result, decimal_result) = {
	// negative + BCD negative
	if (signed(result[7..0]) < 0) then
		reg_SR[n] = 0b1
	else
		reg_SR[n] = 0b0;

	// overflow + BCD overflow
	if (signed(result) > 127 | signed(result) < -128) then
		reg_SR[v] = 0b1
	else
		reg_SR[v] = 0b0;

	// zero + BCD zero
	if (unsigned(result[7..0]) == 0) then
		reg_SR[z] = 0b1
	else
		reg_SR[z] = 0b0;

	// carry
	if (reg_SR[d] == 0b0) then {
		if (signed(result) >= 0) then
			reg_SR[c] = 0b1
		else
			reg_SR[c] = 0b0
	}
	// BCD carry
	else {
		if (decimal_result >= 0) then
			reg_SR[c] = 0b1
		else
			reg_SR[c] = 0b0
	};
}

val SBC : (word) -> bool
function SBC(op) = {
	let decimal_result : int = if (reg_SR[d] == 0b0)
		then {
			-1 // should not set carry by default!
		} else {
			let carry : int = if (reg_SR[c] == 0b1) then 1 else 0;
			decimal_sub(reg_A, op) + (carry - 1)
		};
	let result : bits(9) = if (reg_SR[d] == 0b0)
		then {
			EXTZ(9, reg_A) + EXTZ(9, not_vec(op)) + EXTZ(9, reg_SR[c])
		} else {
			EXTZ(9, decimal_to_word(decimal_result))
		};
	modify_flags_SBC(result, decimal_result);
	reg_A = result[7..0];
	true
}

function clause execute(SBC_IMM(op))   = {
	let word = calc_word(mode(imm), op);
	SBC(word)
}
function clause execute(SBC_ZP(op))    = {
	let word = calc_word(mode(zp), op);
	SBC(read_zp(word))
}
function clause execute(SBC_ZP_X(op))  = {
	let word = calc_word(mode(zp_x), op);
	SBC(read_zp(word))
}
function clause execute(SBC_ABS(op))   = {
	let addr = calc_addr(mode(abs), op);
	SBC(read(addr))
}
function clause execute(SBC_ABS_X(op)) = {
	let addr = calc_addr(mode(abs_x), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	SBC(read(addr))
}
function clause execute(SBC_ABS_Y(op)) = {
	let addr = calc_addr(mode(abs_y), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	SBC(read(addr))
}
function clause execute(SBC_IND_X(op)) = {
	let addr = calc_addr(mode(ind_x), op);
	SBC(read(addr))
}
function clause execute(SBC_IND_Y(op)) = {
	let addr = calc_addr(mode(ind_y), op);
	SBC(read(addr))
}