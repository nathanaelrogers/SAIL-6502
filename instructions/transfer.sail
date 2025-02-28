val modify_flags_transfer : (word) -> unit
function modify_flags_transfer(result) = {
	 // negative
	if (signed(result) < 0) then
		reg_SR[n] = 0b1
	else
		reg_SR[n] = 0b0;

	// zero
	if (unsigned(result) == 0) then
		reg_SR[z] = 0b1
	else
		reg_SR[z] = 0b0;
}

// =======================================

val complete_transfer_instruction : (word) -> bool
function complete_transfer_instruction(input) = {
	modify_flags_transfer(input);
	true
}

// =======================================

function clause execute(LDA_IMM(op))   = {
	incr_cycles(2);
	let input = calc_word(mode(imm), op);
	reg_A = input;
	complete_transfer_instruction(input)
}
function clause execute(LDA_ZP(op))    = {
	incr_cycles(3);
	let addr = calc_word(mode(zp), op);
	let input = read_zp(addr);
	reg_A = input;
	complete_transfer_instruction(input)
}
function clause execute(LDA_ZP_X(op))  = {
	incr_cycles(4);
	let addr = calc_word(mode(zp_x), op);
	let input = read_zp(addr);
	reg_A = input;
	complete_transfer_instruction(input)
}
function clause execute(LDA_ABS(op))   = {
	incr_cycles(4);
	let addr = calc_addr(mode(abs), op);
	let input = read(addr);
	reg_A = input;
	complete_transfer_instruction(input)
}
function clause execute(LDA_ABS_X(op)) = {
	incr_cycles(4);
	let addr = calc_addr(mode(abs_x), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	let input = read(addr);
	reg_A = input;
	complete_transfer_instruction(input)
}
function clause execute(LDA_ABS_Y(op)) = {
	incr_cycles(4);
	let addr = calc_addr(mode(abs_y), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	let input = read(addr);
	reg_A = input;
	complete_transfer_instruction(input)
}
function clause execute(LDA_IND_X(op)) = {
	incr_cycles(6);
	let addr = calc_addr(mode(ind_x), op);
	let input = read(addr);
	reg_A = input;
	complete_transfer_instruction(input)
}
function clause execute(LDA_IND_Y(op)) = {
	incr_cycles(5);
	let addr = calc_addr(mode(ind_y), op);
	if (addr[15..8] != (read_zp(op + 1) @ read_zp(op))[15..8]) then
		incr_cycles(1);
	let input = read(addr);
	reg_A = input;
	complete_transfer_instruction(input)
}

// =======================================

function clause execute(LDX_IMM(op))   = {
	incr_cycles(2);
	let input = calc_word(mode(imm), op);
	reg_X = input;
	complete_transfer_instruction(input)
}
function clause execute(LDX_ZP(op))    = {
	incr_cycles(3);
	let addr = calc_word(mode(zp), op);
	let input = read_zp(addr);
	reg_X = input;
	complete_transfer_instruction(input)
}
function clause execute(LDX_ZP_Y(op))  = {
	incr_cycles(4);
	let addr = calc_word(mode(zp_y), op);
	let input = read_zp(addr);
	reg_X = input;
	complete_transfer_instruction(input)
}
function clause execute(LDX_ABS(op))   = {
	incr_cycles(4);
	let addr = calc_addr(mode(abs), op);
	let input = read(addr);
	reg_X = input;
	complete_transfer_instruction(input)
}
function clause execute(LDX_ABS_Y(op)) = {
	incr_cycles(4);
	let addr = calc_addr(mode(abs_y), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	let input = read(addr);
	reg_X = input;
	complete_transfer_instruction(input)
}

// =======================================

function clause execute(LDY_IMM(op))   = {
	incr_cycles(2);
	let input = calc_word(mode(imm), op);
	reg_Y = input;
	complete_transfer_instruction(input)
}
function clause execute(LDY_ZP(op))    = {
	incr_cycles(3);
	let addr = calc_word(mode(zp), op);
	let input = read_zp(addr);
	reg_Y = input;
	complete_transfer_instruction(input)
}
function clause execute(LDY_ZP_X(op))  = {
	incr_cycles(4);
	let addr = calc_word(mode(zp_x), op);
	let input = read_zp(addr);
	reg_Y = input;
	complete_transfer_instruction(input)
}
function clause execute(LDY_ABS(op))   = {
	incr_cycles(4);
	let addr = calc_addr(mode(abs), op);
	let input = read(addr);
	reg_Y = input;
	complete_transfer_instruction(input)
}
function clause execute(LDY_ABS_X(op)) = {
	incr_cycles(4);
	let addr = calc_addr(mode(abs_x), op);
	if (op[15..8] != addr[15..8]) then incr_cycles(1);
	let input = read(addr);
	reg_Y = input;
	complete_transfer_instruction(input)
}

// =======================================

// TODO : can we directly use to write in the stack??
function clause execute(STA_ZP(op))    = {
	incr_cycles(3);
	let addr = calc_word(mode(zp), op);
	write_zp(addr, reg_A);
	true
}
function clause execute(STA_ZP_X(op))  = {
	incr_cycles(4);
	let addr = calc_word(mode(zp_x), op);
	write_zp(addr, reg_A);
	true
}
function clause execute(STA_ABS(op))   = {
	incr_cycles(4);
	let addr = calc_addr(mode(abs), op);
	write(addr, reg_A);
	true
}
/*
	Always takes 5 cycles
*/
function clause execute(STA_ABS_X(op)) = {
	incr_cycles(5);
	let addr = calc_addr(mode(abs_x), op);
	write(addr, reg_A);
	true
}
/*
	Always takes 5 cycles
*/
function clause execute(STA_ABS_Y(op)) = {
	incr_cycles(5);
	let addr = calc_addr(mode(abs_y), op);
	write(addr, reg_A);
	true
}
function clause execute(STA_IND_X(op)) = {
	incr_cycles(6);
	let addr = calc_addr(mode(ind_x), op);
	write(addr, reg_A);
	true
}
/*
	Always takes 6 cycles
*/
function clause execute(STA_IND_Y(op)) = {
	incr_cycles(6);
	let addr = calc_addr(mode(ind_y), op);
	let ptr = read_zp(op + 1) @ read_zp(op);
	write(addr, reg_A);
	true
}

// =======================================

function clause execute(STX_ZP(op))    = {
	incr_cycles(3);
	let addr = calc_word(mode(zp), op);
	write_zp(addr, reg_X);
	true
}
function clause execute(STX_ZP_Y(op))  = {
	incr_cycles(4);
	let addr = calc_word(mode(zp_y), op);
	write_zp(addr, reg_X);
	true
}
function clause execute(STX_ABS(op))   = {
	incr_cycles(4);
	let addr = calc_addr(mode(abs), op);
	write(addr, reg_X);
	true
}

// =======================================

function clause execute(STY_ZP(op))    = {
	incr_cycles(3);
	let addr = calc_word(mode(zp), op);
	write_zp(addr, reg_Y);
	true
}
function clause execute(STY_ZP_X(op))  = {
	incr_cycles(4);
	let addr = calc_word(mode(zp_x), op);
	write_zp(addr, reg_Y);
	true
}
function clause execute(STY_ABS(op))   = {
	incr_cycles(4);
	let addr = calc_addr(mode(abs), op);
	write(addr, reg_Y);
	true
}

// =======================================

function clause execute(TAX()) = {
	incr_cycles(2);

	let input = reg_A;
	reg_X = input;
	complete_transfer_instruction(input)
}

// =======================================

function clause execute(TAY()) = {
	incr_cycles(2);

	let input = reg_A;
	reg_Y = input;
	complete_transfer_instruction(input)
}

// =======================================

function clause execute(TSX()) = {
	incr_cycles(2);

	let input = reg_SP;
	reg_X = input;
	complete_transfer_instruction(input)
}

// =======================================

function clause execute(TXA()) = {
	incr_cycles(2);

	let input = reg_X;
	reg_A = input;
	complete_transfer_instruction(input)
}


// =======================================

function clause execute(TXS()) = {
	incr_cycles(2);

	let input = reg_X;
	reg_SP = input;
	true
}

// =======================================

function clause execute(TYA()) = {
	incr_cycles(2);

	let input = reg_Y;
	reg_A = input;
	complete_transfer_instruction(input)
}
