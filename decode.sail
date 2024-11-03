/* ============== 1 byte instructions ============== */

// If it's not a valid single byte instruction, read another byte and try decode.
function clause decode08(this, last_execute) = {
	if (last_execute == false) then incr_cycles(1);
	let PC : address = access(reg(PC_H)) @ access(reg(PC_L));
	let next_byte : word = read(PC);
	incr_pc();

	decode16(EXTZ(this) << 8 | EXTZ(next_byte));
}

/* ============== 2 byte instructions ============== */

function clause decode16(0x69 @ op : word) = {incr_cycles(1); ADC_IMM(op)}
function clause decode16(0x65 @ op : word) = {incr_cycles(1); ADC_ZP(op)}
function clause decode16(0x75 @ op : word) = {incr_cycles(1); ADC_ZP_X(op)}
function clause decode16(0x61 @ op : word) = {incr_cycles(1); ADC_IND_X(op)}
function clause decode16(0x71 @ op : word) = {incr_cycles(1); ADC_IND_Y(op)}

function clause decode16(0x29 @ op : word) = {incr_cycles(1); AND_IMM(op)}
function clause decode16(0x25 @ op : word) = {incr_cycles(1); AND_ZP(op)}
function clause decode16(0x35 @ op : word) = {incr_cycles(1); AND_ZP_X(op)}
function clause decode16(0x21 @ op : word) = {incr_cycles(1); AND_IND_X(op)}
function clause decode16(0x31 @ op : word) = {incr_cycles(1); AND_IND_Y(op)}

function clause decode16(0x49 @ op : word) = {incr_cycles(1); EOR_IMM(op)}
function clause decode16(0x45 @ op : word) = {incr_cycles(1); EOR_ZP(op)}
function clause decode16(0x55 @ op : word) = {incr_cycles(1); EOR_ZP_X(op)}
function clause decode16(0x41 @ op : word) = {incr_cycles(1); EOR_IND_X(op)}
function clause decode16(0x51 @ op : word) = {incr_cycles(1); EOR_IND_Y(op)}

function clause decode16(0xA9 @ op : word) = {incr_cycles(1); LDA_IMM(op)}
function clause decode16(0xA5 @ op : word) = {incr_cycles(1); LDA_ZP(op)}
function clause decode16(0xB5 @ op : word) = {incr_cycles(1); LDA_ZP_X(op)}
function clause decode16(0xA1 @ op : word) = {incr_cycles(1); LDA_IND_X(op)}
function clause decode16(0xB1 @ op : word) = {incr_cycles(1); LDA_IND_Y(op)}

function clause decode16(0x09 @ op : word) = {incr_cycles(1); ORA_IMM(op)}
function clause decode16(0x05 @ op : word) = {incr_cycles(1); ORA_ZP(op)}
function clause decode16(0x15 @ op : word) = {incr_cycles(1); ORA_ZP_X(op)}
function clause decode16(0x01 @ op : word) = {incr_cycles(1); ORA_IND_X(op)}
function clause decode16(0x11 @ op : word) = {incr_cycles(1); ORA_IND_Y(op)}

function clause decode16(0xE9 @ op : word) = {incr_cycles(1); SBC_IMM(op)}
function clause decode16(0xE5 @ op : word) = {incr_cycles(1); SBC_ZP(op)}
function clause decode16(0xF5 @ op : word) = {incr_cycles(1); SBC_ZP_X(op)}
function clause decode16(0xE1 @ op : word) = {incr_cycles(1); SBC_IND_X(op)}
function clause decode16(0xF1 @ op : word) = {incr_cycles(1); SBC_IND_Y(op)}

// If it's not a valid 2 byte instruction, read another byte and try decode.
function clause decode16(this) = {
	incr_cycles(1);
	let PC : address = access(reg(PC_H)) @ access(reg(PC_L));
	let next_byte : word = read(PC);
	incr_pc();

	decode24(EXTZ(this) << 8 | EXTZ(next_byte));
}

/* ============== 3 byte instructions ============== */

function clause decode24(0x6D @ op : address) = {incr_cycles(1); ADC_ABS(op)}
function clause decode24(0x7D @ op : address) = {incr_cycles(1); ADC_ABS_X(op)}
function clause decode24(0x79 @ op : address) = {incr_cycles(1); ADC_ABS_Y(op)}

function clause decode24(0x2D @ op : address) = {incr_cycles(1); AND_ABS(op)}
function clause decode24(0x3D @ op : address) = {incr_cycles(1); AND_ABS_X(op)}
function clause decode24(0x39 @ op : address) = {incr_cycles(1); AND_ABS_Y(op)}

function clause decode24(0x4D @ op : address) = {incr_cycles(1); EOR_ABS(op)}
function clause decode24(0x5D @ op : address) = {incr_cycles(1); EOR_ABS_X(op)}
function clause decode24(0x59 @ op : address) = {incr_cycles(1); EOR_ABS_Y(op)}

function clause decode24(0xAD @ op : address) = {incr_cycles(1); LDA_ABS(op)}
function clause decode24(0xBD @ op : address) = {incr_cycles(1); LDA_ABS_X(op)}
function clause decode24(0xB9 @ op : address) = {incr_cycles(1); LDA_ABS_Y(op)}

function clause decode24(0x0D @ op : address) = {incr_cycles(1); ORA_ABS(op)}
function clause decode24(0x1D @ op : address) = {incr_cycles(1); ORA_ABS_X(op)}
function clause decode24(0x19 @ op : address) = {incr_cycles(1); ORA_ABS_Y(op)}

function clause decode24(0xED @ op : address) = {incr_cycles(1); SBC_ABS(op)}
function clause decode24(0xFD @ op : address) = {incr_cycles(1); SBC_ABS_X(op)}
function clause decode24(0xF9 @ op : address) = {incr_cycles(1); SBC_ABS_Y(op)}

// Catch an invalid instruction
union clause ast = INVALID : (bits(24))
function clause decode24(instruction) = {incr_cycles(1); INVALID(instruction)}
function clause execute(INVALID(instruction)) = false