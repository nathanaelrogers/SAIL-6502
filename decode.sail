val decode08 : bits(8) -> ast
scattered function decode08

val decode16 : bits(16) -> ast
scattered function decode16

val decode24 : bits(24) -> ast
scattered function decode24

overload decode = {decode08, decode16, decode24}

/* ============== 1 byte instructions ============== */
function clause decode08(0x00) = BRK()
function clause decode08(0xEA) = NOP()

function clause decode08(0x18) = CLC()
function clause decode08(0xD8) = CLD()
function clause decode08(0x58) = CLI()
function clause decode08(0xB8) = CLV()
function clause decode08(0x38) = SEC()
function clause decode08(0xF8) = SED()
function clause decode08(0x78) = SEI()

function clause decode08(0xCA) = DEX()
function clause decode08(0x88) = DEY()
function clause decode08(0xE8) = INX()
function clause decode08(0xC8) = INY()

function clause decode08(0x0A) = ASL()
function clause decode08(0x4A) = LSR()
function clause decode08(0x2A) = ROL()
function clause decode08(0x6A) = ROR()

function clause decode08(0x48) = PHA()
function clause decode08(0x08) = PHP()
function clause decode08(0x68) = PLA()
function clause decode08(0x28) = PLP()

function clause decode08(0x40) = RTI()
function clause decode08(0x60) = RTS()

function clause decode08(0xAA) = TAX()
function clause decode08(0xA8) = TAY()
function clause decode08(0xBA) = TSX()
function clause decode08(0x8A) = TXA()
function clause decode08(0x9A) = TXS()
function clause decode08(0x98) = TYA()

/* ============== 2/3 byte instructions ============== */
function clause decode16(0x69 @ op : word)    = ADC_IMM(op)
function clause decode16(0x65 @ op : word)    = ADC_ZP(op)
function clause decode16(0x75 @ op : word)    = ADC_ZP_X(op)
function clause decode24(0x6D @ op : address) = ADC_ABS(op[7..0] @ op[15..8])
function clause decode24(0x7D @ op : address) = ADC_ABS_X(op[7..0] @ op[15..8])
function clause decode24(0x79 @ op : address) = ADC_ABS_Y(op[7..0] @ op[15..8])
function clause decode16(0x61 @ op : word)    = ADC_IND_X(op)
function clause decode16(0x71 @ op : word)    = ADC_IND_Y(op)

function clause decode16(0xE9 @ op : word)    = SBC_IMM(op)
function clause decode16(0xE5 @ op : word)    = SBC_ZP(op)
function clause decode16(0xF5 @ op : word)    = SBC_ZP_X(op)
function clause decode24(0xED @ op : address) = SBC_ABS(op[7..0] @ op[15..8])
function clause decode24(0xFD @ op : address) = SBC_ABS_X(op[7..0] @ op[15..8])
function clause decode24(0xF9 @ op : address) = SBC_ABS_Y(op[7..0] @ op[15..8])
function clause decode16(0xE1 @ op : word)    = SBC_IND_X(op)
function clause decode16(0xF1 @ op : word)    = SBC_IND_Y(op)

function clause decode16(0x29 @ op : word)    = AND_IMM(op)
function clause decode16(0x25 @ op : word)    = AND_ZP(op)
function clause decode16(0x35 @ op : word)    = AND_ZP_X(op)
function clause decode24(0x2D @ op : address) = AND_ABS(op[7..0] @ op[15..8])
function clause decode24(0x3D @ op : address) = AND_ABS_X(op[7..0] @ op[15..8])
function clause decode24(0x39 @ op : address) = AND_ABS_Y(op[7..0] @ op[15..8])
function clause decode16(0x21 @ op : word)    = AND_IND_X(op)
function clause decode16(0x31 @ op : word)    = AND_IND_Y(op)

function clause decode16(0x49 @ op : word)    = EOR_IMM(op)
function clause decode16(0x45 @ op : word)    = EOR_ZP(op)
function clause decode16(0x55 @ op : word)    = EOR_ZP_X(op)
function clause decode24(0x4D @ op : address) = EOR_ABS(op[7..0] @ op[15..8])
function clause decode24(0x5D @ op : address) = EOR_ABS_X(op[7..0] @ op[15..8])
function clause decode24(0x59 @ op : address) = EOR_ABS_Y(op[7..0] @ op[15..8])
function clause decode16(0x41 @ op : word)    = EOR_IND_X(op)
function clause decode16(0x51 @ op : word)    = EOR_IND_Y(op)

function clause decode16(0x09 @ op : word)    = ORA_IMM(op)
function clause decode16(0x05 @ op : word)    = ORA_ZP(op)
function clause decode16(0x15 @ op : word)    = ORA_ZP_X(op)
function clause decode24(0x0D @ op : address) = ORA_ABS(op[7..0] @ op[15..8])
function clause decode24(0x1D @ op : address) = ORA_ABS_X(op[7..0] @ op[15..8])
function clause decode24(0x19 @ op : address) = ORA_ABS_Y(op[7..0] @ op[15..8])
function clause decode16(0x01 @ op : word)    = ORA_IND_X(op)
function clause decode16(0x11 @ op : word)    = ORA_IND_Y(op)

function clause decode16(0x06 @ op : word)    = ASL_ZP(op)
function clause decode16(0x16 @ op : word)    = ASL_ZP_X(op)
function clause decode24(0x0E @ op : address) = ASL_ABS(op[7..0] @ op[15..8])
function clause decode24(0x1E @ op : address) = ASL_ABS_X(op[7..0] @ op[15..8])
function clause decode16(0x46 @ op : word)    = LSR_ZP(op)
function clause decode16(0x56 @ op : word)    = LSR_ZP_X(op)
function clause decode24(0x4E @ op : address) = LSR_ABS(op[7..0] @ op[15..8])
function clause decode24(0x5E @ op : address) = LSR_ABS_X(op[7..0] @ op[15..8])
function clause decode16(0x26 @ op : word)    = ROL_ZP(op)
function clause decode16(0x36 @ op : word)    = ROL_ZP_X(op)
function clause decode24(0x2E @ op : address) = ROL_ABS(op[7..0] @ op[15..8])
function clause decode24(0x3E @ op : address) = ROL_ABS_X(op[7..0] @ op[15..8])
function clause decode16(0x66 @ op : word)    = ROR_ZP(op)
function clause decode16(0x76 @ op : word)    = ROR_ZP_X(op)
function clause decode24(0x6E @ op : address) = ROR_ABS(op[7..0] @ op[15..8])
function clause decode24(0x7E @ op : address) = ROR_ABS_X(op[7..0] @ op[15..8])

function clause decode16(0x90 @ op : word)    = BCC_REL(op)
function clause decode16(0xB0 @ op : word)    = BCS_REL(op)
function clause decode16(0xF0 @ op : word)    = BEQ_REL(op)
function clause decode16(0x30 @ op : word)    = BMI_REL(op)
function clause decode16(0xD0 @ op : word)    = BNE_REL(op)
function clause decode16(0x10 @ op : word)    = BPL_REL(op)
function clause decode16(0x50 @ op : word)    = BVC_REL(op)
function clause decode16(0x70 @ op : word)    = BVS_REL(op)

function clause decode16(0x24 @ op : word)    = BIT_ZP(op)
function clause decode24(0x2C @ op : address) = BIT_ABS(op[7..0] @ op[15..8])

function clause decode16(0xC9 @ op : word)    = CMP_IMM(op)
function clause decode16(0xC5 @ op : word)    = CMP_ZP(op)
function clause decode16(0xD5 @ op : word)    = CMP_ZP_X(op)
function clause decode24(0xCD @ op : address) = CMP_ABS(op[7..0] @ op[15..8])
function clause decode24(0xDD @ op : address) = CMP_ABS_X(op[7..0] @ op[15..8])
function clause decode24(0xD9 @ op : address) = CMP_ABS_Y(op[7..0] @ op[15..8])
function clause decode16(0xC1 @ op : word)    = CMP_IND_X(op)
function clause decode16(0xD1 @ op : word)    = CMP_IND_Y(op)
function clause decode16(0xC0 @ op : word)    = CPY_IMM(op)
function clause decode16(0xC4 @ op : word)    = CPY_ZP(op)
function clause decode24(0xCC @ op : address) = CPY_ABS(op[7..0] @ op[15..8])
function clause decode16(0xE0 @ op : word)    = CPX_IMM(op)
function clause decode16(0xE4 @ op : word)    = CPX_ZP(op)
function clause decode24(0xEC @ op : address) = CPX_ABS(op[7..0] @ op[15..8])

function clause decode16(0xC6 @ op : word)    = DEC_ZP(op)
function clause decode16(0xD6 @ op : word)    = DEC_ZP_X(op)
function clause decode24(0xCE @ op : address) = DEC_ABS(op[7..0] @ op[15..8])
function clause decode24(0xDE @ op : address) = DEC_ABS_X(op[7..0] @ op[15..8])
function clause decode16(0xE6 @ op : word)    = INC_ZP(op)
function clause decode16(0xF6 @ op : word)    = INC_ZP_X(op)
function clause decode24(0xEE @ op : address) = INC_ABS(op[7..0] @ op[15..8])
function clause decode24(0xFE @ op : address) = INC_ABS_X(op[7..0] @ op[15..8])

function clause decode24(0x4C @ op : address) = JMP_ABS(op[7..0] @ op[15..8])
function clause decode24(0x6C @ op : address) = JMP_IND(op[7..0] @ op[15..8])
function clause decode24(0x20 @ op : address) = JSR_ABS(op[7..0] @ op[15..8])

function clause decode16(0xA9 @ op : word)    = LDA_IMM(op)
function clause decode16(0xA5 @ op : word)    = LDA_ZP(op)
function clause decode16(0xB5 @ op : word)    = LDA_ZP_X(op)
function clause decode24(0xAD @ op : address) = LDA_ABS(op[7..0] @ op[15..8])
function clause decode24(0xBD @ op : address) = LDA_ABS_X(op[7..0] @ op[15..8])
function clause decode24(0xB9 @ op : address) = LDA_ABS_Y(op[7..0] @ op[15..8])
function clause decode16(0xA1 @ op : word)    = LDA_IND_X(op)
function clause decode16(0xB1 @ op : word)    = LDA_IND_Y(op)
function clause decode16(0xA2 @ op : word)    = LDX_IMM(op)
function clause decode16(0xA6 @ op : word)    = LDX_ZP(op)
function clause decode16(0xB6 @ op : word)    = LDX_ZP_Y(op)
function clause decode24(0xAE @ op : address) = LDX_ABS(op[7..0] @ op[15..8])
function clause decode24(0xBE @ op : address) = LDX_ABS_Y(op[7..0] @ op[15..8])
function clause decode16(0xA0 @ op : word)    = LDY_IMM(op)
function clause decode16(0xA4 @ op : word)    = LDY_ZP(op)
function clause decode16(0xB4 @ op : word)    = LDY_ZP_X(op)
function clause decode24(0xAC @ op : address) = LDY_ABS(op[7..0] @ op[15..8])
function clause decode24(0xBC @ op : address) = LDY_ABS_X(op[7..0] @ op[15..8])

function clause decode16(0x85 @ op : word)    = STA_ZP(op)
function clause decode16(0x95 @ op : word)    = STA_ZP_X(op)
function clause decode24(0x8D @ op : address) = STA_ABS(op[7..0] @ op[15..8])
function clause decode24(0x9D @ op : address) = STA_ABS_X(op[7..0] @ op[15..8])
function clause decode24(0x99 @ op : address) = STA_ABS_Y(op[7..0] @ op[15..8])
function clause decode16(0x81 @ op : word)    = STA_IND_X(op)
function clause decode16(0x91 @ op : word)    = STA_IND_Y(op)
function clause decode16(0x86 @ op : word)    = STX_ZP(op)
function clause decode16(0x96 @ op : word)    = STX_ZP_Y(op)
function clause decode24(0x8E @ op : address) = STX_ABS(op[7..0] @ op[15..8])
function clause decode16(0x84 @ op : word)    = STY_ZP(op)
function clause decode16(0x94 @ op : word)    = STY_ZP_X(op)
function clause decode24(0x8C @ op : address) = STY_ABS(op[7..0] @ op[15..8])

// If it's not a valid single byte instruction, read another byte and try decode.
function clause decode08(op) = {
	let next_byte : word = read(reg_PC);
	incr_pc(1);

	decode16(EXTZ(op) << 8 | EXTZ(next_byte));
}

// If it's not a valid instruction, read another byte and try decode.
function clause decode16(op) = {
	let next_byte : word = read(reg_PC);
	incr_pc(1);

	decode24(EXTZ(op) << 8 | EXTZ(next_byte));
}

// Catch an invalid instruction
function clause decode24(instruction) = {incr_cycles(1); INVALID(instruction)}

