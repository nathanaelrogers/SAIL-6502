val modify_flags_logical : word -> unit
function modify_flags_logical(result) = {
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

val perform_logical_instr : (word) -> bool
function perform_logical_instr(result) = {
	modify_flags_logical(result);
	reg_A = result;
	true
}

// =======================================

function clause execute(AND_IMM(op))   = {
	incr_cycles(1);
	let input = calc_word(mode(imm), op);
	let result = input & reg_A;
	perform_logical_instr(result)
}
function clause execute(AND_ZP(op))    = {
	incr_cycles(1);
	let word = calc_word(mode(zp), op);
	let input = read_zp(word);
	let result = input & reg_A;
	perform_logical_instr(result)
}
function clause execute(AND_ZP_X(op))  = {
	incr_cycles(1);
	let word = calc_word(mode(zp_x), op);
	let input = read_zp(word);
	let result = input & reg_A;
	perform_logical_instr(result)
}
function clause execute(AND_ABS(op))   = {
	incr_cycles(1);
	let addr = calc_addr(mode(abs), op);
	let input = read(addr);
	let result = input & reg_A;
	perform_logical_instr(result)
}
function clause execute(AND_ABS_X(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(abs_x), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	let input = read(addr);
	let result = input & reg_A;
	perform_logical_instr(result)
}
function clause execute(AND_ABS_Y(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(abs_y), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	let input = read(addr);
	let result = input & reg_A;
	perform_logical_instr(result)
}
function clause execute(AND_IND_X(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(ind_x), op);
	let input = read(addr);
	let result = input & reg_A;
	perform_logical_instr(result)
}
function clause execute(AND_IND_Y(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(ind_y), op);
	let input = read(addr);
	let result = input & reg_A;
	perform_logical_instr(result)
}

// =======================================

function clause execute(EOR_IMM(op))   = {
	incr_cycles(1);
	let input = calc_word(mode(imm), op);
	let result = input ^ reg_A;
	perform_logical_instr(result)
}
function clause execute(EOR_ZP(op))    = {
	incr_cycles(1);
	let word = calc_word(mode(zp), op);
	let input = read_zp(word);
	let result = input ^ reg_A;
	perform_logical_instr(result)
}
function clause execute(EOR_ZP_X(op))  = {
	incr_cycles(1);
	let word = calc_word(mode(zp_x), op);
	let input = read_zp(word);
	let result = input ^ reg_A;
	perform_logical_instr(result)
}
function clause execute(EOR_ABS(op))   = {
	incr_cycles(1);
	let addr = calc_addr(mode(abs), op);
	let input = read(addr);
	let result = input ^ reg_A;
	perform_logical_instr(result)
}
function clause execute(EOR_ABS_X(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(abs_x), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	let input = read(addr);
	let result = input ^ reg_A;
	perform_logical_instr(result)
}
function clause execute(EOR_ABS_Y(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(abs_y), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	let input = read(addr);
	let result = input ^ reg_A;
	perform_logical_instr(result)
}
function clause execute(EOR_IND_X(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(ind_x), op);
	let input = read(addr);
	let result = input ^ reg_A;
	perform_logical_instr(result)
}
function clause execute(EOR_IND_Y(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(ind_y), op);
	let input = read(addr);
	let result = input ^ reg_A;
	perform_logical_instr(result)
}

// =======================================

function clause execute(ORA_IMM(op))   = {
	incr_cycles(1);
	let input = calc_word(mode(imm), op);
	let result = input | reg_A;
	perform_logical_instr(result)
}
function clause execute(ORA_ZP(op))    = {
	incr_cycles(1);
	let word = calc_word(mode(zp), op);
	let input = read_zp(word);
	let result = input | reg_A;
	perform_logical_instr(result)
}
function clause execute(ORA_ZP_X(op))  = {
	incr_cycles(1);
	let word = calc_word(mode(zp_x), op);
	let input = read_zp(word);
	let result = input | reg_A;
	perform_logical_instr(result)
}
function clause execute(ORA_ABS(op))   = {
	incr_cycles(1);
	let addr = calc_addr(mode(abs), op);
	let input = read(addr);
	let result = input | reg_A;
	perform_logical_instr(result)
}
function clause execute(ORA_ABS_X(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(abs_x), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	let input = read(addr);
	let result = input | reg_A;
	perform_logical_instr(result)
}
function clause execute(ORA_ABS_Y(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(abs_y), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	let input = read(addr);
	let result = input | reg_A;
	perform_logical_instr(result)
}
function clause execute(ORA_IND_X(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(ind_x), op);
	let input = read(addr);
	let result = input | reg_A;
	perform_logical_instr(result)
}
function clause execute(ORA_IND_Y(op)) = {
	incr_cycles(1);
	let addr = calc_addr(mode(ind_y), op);
	let input = read(addr);
	let result = input | reg_A;
	perform_logical_instr(result)
}