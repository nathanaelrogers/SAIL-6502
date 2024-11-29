/* ============== 1 byte instructions ============== */

function clause decode08(0xAA, last_execute)  = {if (last_execute == false) then incr_cycles(1); TAX_IMP()}
function clause decode08(0xA8, last_execute)  = {if (last_execute == false) then incr_cycles(1); TAY_IMP()}
function clause decode08(0xBA, last_execute)  = {if (last_execute == false) then incr_cycles(1); TSX_IMP()}
function clause decode08(0x8A, last_execute)  = {if (last_execute == false) then incr_cycles(1); TXA_IMP()}
function clause decode08(0x9A, last_execute)  = {if (last_execute == false) then incr_cycles(1); TXS_IMP()}
function clause decode08(0x98, last_execute)  = {if (last_execute == false) then incr_cycles(1); TYA_IMP()}

// If it's not a valid single byte instruction, read another byte and try decode.
function clause decode08(this, last_execute) = {
	if (last_execute == false) then incr_cycles(1);
	let PC : address = reg_PC[15..8] @ reg_PC[7..0];
	let next_byte : word = read(PC);
	incr_pc();

	decode16(EXTZ(this) << 8 | EXTZ(next_byte));
}

/* ============== 2/3 byte instructions ============== */

function clause decode16(0x69 @ op : word)    = {incr_cycles(1); ADC_IMM(op)}
function clause decode16(0x65 @ op : word)    = {incr_cycles(1); ADC_ZP(op)}
function clause decode16(0x75 @ op : word)    = {incr_cycles(1); ADC_ZP_X(op)}
function clause decode24(0x6D @ op : address) = {incr_cycles(1); ADC_ABS(op)}
function clause decode24(0x7D @ op : address) = {incr_cycles(1); ADC_ABS_X(op)}
function clause decode24(0x79 @ op : address) = {incr_cycles(1); ADC_ABS_Y(op)}
function clause decode16(0x61 @ op : word)    = {incr_cycles(1); ADC_IND_X(op)}
function clause decode16(0x71 @ op : word)    = {incr_cycles(1); ADC_IND_Y(op)}

function clause decode16(0x29 @ op : word)    = {incr_cycles(1); AND_IMM(op)}
function clause decode16(0x25 @ op : word)    = {incr_cycles(1); AND_ZP(op)}
function clause decode16(0x35 @ op : word)    = {incr_cycles(1); AND_ZP_X(op)}
function clause decode24(0x2D @ op : address) = {incr_cycles(1); AND_ABS(op)}
function clause decode24(0x3D @ op : address) = {incr_cycles(1); AND_ABS_X(op)}
function clause decode24(0x39 @ op : address) = {incr_cycles(1); AND_ABS_Y(op)}
function clause decode16(0x21 @ op : word)    = {incr_cycles(1); AND_IND_X(op)}
function clause decode16(0x31 @ op : word)    = {incr_cycles(1); AND_IND_Y(op)}

function clause decode16(0x49 @ op : word)    = {incr_cycles(1); EOR_IMM(op)}
function clause decode16(0x45 @ op : word)    = {incr_cycles(1); EOR_ZP(op)}
function clause decode16(0x55 @ op : word)    = {incr_cycles(1); EOR_ZP_X(op)}
function clause decode24(0x4D @ op : address) = {incr_cycles(1); EOR_ABS(op)}
function clause decode24(0x5D @ op : address) = {incr_cycles(1); EOR_ABS_X(op)}
function clause decode24(0x59 @ op : address) = {incr_cycles(1); EOR_ABS_Y(op)}
function clause decode16(0x41 @ op : word)    = {incr_cycles(1); EOR_IND_X(op)}
function clause decode16(0x51 @ op : word)    = {incr_cycles(1); EOR_IND_Y(op)}

function clause decode16(0xA9 @ op : word)    = {incr_cycles(1); LDA_IMM(op)}
function clause decode16(0xA5 @ op : word)    = {incr_cycles(1); LDA_ZP(op)}
function clause decode16(0xB5 @ op : word)    = {incr_cycles(1); LDA_ZP_X(op)}
function clause decode24(0xAD @ op : address) = {incr_cycles(1); LDA_ABS(op)}
function clause decode24(0xBD @ op : address) = {incr_cycles(1); LDA_ABS_X(op)}
function clause decode24(0xB9 @ op : address) = {incr_cycles(1); LDA_ABS_Y(op)}
function clause decode16(0xA1 @ op : word)    = {incr_cycles(1); LDA_IND_X(op)}
function clause decode16(0xB1 @ op : word)    = {incr_cycles(1); LDA_IND_Y(op)}

function clause decode16(0xA2 @ op : word)    = {incr_cycles(1); LDX_IMM(op)}
function clause decode16(0xA6 @ op : word)    = {incr_cycles(1); LDX_ZP(op)}
function clause decode16(0xB6 @ op : word)    = {incr_cycles(1); LDX_ZP_Y(op)}
function clause decode24(0xAE @ op : address) = {incr_cycles(1); LDX_ABS(op)}
function clause decode24(0xBE @ op : address) = {incr_cycles(1); LDX_ABS_Y(op)}

function clause decode16(0xA0 @ op : word)    = {incr_cycles(1); LDY_IMM(op)}
function clause decode16(0xA4 @ op : word)    = {incr_cycles(1); LDY_ZP(op)}
function clause decode16(0xB4 @ op : word)    = {incr_cycles(1); LDY_ZP_X(op)}
function clause decode24(0xAC @ op : address) = {incr_cycles(1); LDY_ABS(op)}
function clause decode24(0xBC @ op : address) = {incr_cycles(1); LDY_ABS_X(op)}

function clause decode16(0x09 @ op : word)    = {incr_cycles(1); ORA_IMM(op)}
function clause decode16(0x05 @ op : word)    = {incr_cycles(1); ORA_ZP(op)}
function clause decode16(0x15 @ op : word)    = {incr_cycles(1); ORA_ZP_X(op)}
function clause decode24(0x0D @ op : address) = {incr_cycles(1); ORA_ABS(op)}
function clause decode24(0x1D @ op : address) = {incr_cycles(1); ORA_ABS_X(op)}
function clause decode24(0x19 @ op : address) = {incr_cycles(1); ORA_ABS_Y(op)}
function clause decode16(0x01 @ op : word)    = {incr_cycles(1); ORA_IND_X(op)}
function clause decode16(0x11 @ op : word)    = {incr_cycles(1); ORA_IND_Y(op)}

function clause decode16(0xE9 @ op : word)    = {incr_cycles(1); SBC_IMM(op)}
function clause decode16(0xE5 @ op : word)    = {incr_cycles(1); SBC_ZP(op)}
function clause decode16(0xF5 @ op : word)    = {incr_cycles(1); SBC_ZP_X(op)}
function clause decode24(0xED @ op : address) = {incr_cycles(1); SBC_ABS(op)}
function clause decode24(0xFD @ op : address) = {incr_cycles(1); SBC_ABS_X(op)}
function clause decode24(0xF9 @ op : address) = {incr_cycles(1); SBC_ABS_Y(op)}
function clause decode16(0xE1 @ op : word)    = {incr_cycles(1); SBC_IND_X(op)}
function clause decode16(0xF1 @ op : word)    = {incr_cycles(1); SBC_IND_Y(op)}

function clause decode16(0x85 @ op : word)    = {incr_cycles(1); STA_ZP(op)}
function clause decode16(0x95 @ op : word)    = {incr_cycles(1); STA_ZP_X(op)}
function clause decode24(0x8D @ op : address) = {incr_cycles(1); STA_ABS(op)}
function clause decode24(0x9D @ op : address) = {incr_cycles(1); STA_ABS_X(op)}
function clause decode24(0x99 @ op : address) = {incr_cycles(1); STA_ABS_Y(op)}
function clause decode16(0x81 @ op : word)    = {incr_cycles(1); STA_IND_X(op)}
function clause decode16(0x91 @ op : word)    = {incr_cycles(1); STA_IND_Y(op)}

function clause decode16(0x86 @ op : word)    = {incr_cycles(1); STX_ZP(op)}
function clause decode16(0x96 @ op : word)    = {incr_cycles(1); STX_ZP_Y(op)}
function clause decode24(0x8E @ op : address) = {incr_cycles(1); STX_ABS(op)}

function clause decode16(0x84 @ op : word)    = {incr_cycles(1); STY_ZP(op)}
function clause decode16(0x94 @ op : word)    = {incr_cycles(1); STY_ZP_X(op)}
function clause decode24(0x8C @ op : address) = {incr_cycles(1); STY_ABS(op)}

// If it's not a valid instruction, read another byte and try decode.
function clause decode16(this) = {
	incr_cycles(1);
	let PC : address = reg_PC[15..8] @ reg_PC[7..0];
	let next_byte : word = read(PC);
	incr_pc();

	decode24(EXTZ(this) << 8 | EXTZ(next_byte));
}

// Catch an invalid instruction
union clause ast = INVALID : (bits(24))
function clause decode24(instruction) = {incr_cycles(1); INVALID(instruction)}
function clause execute(INVALID(instruction)) = false