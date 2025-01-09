val assembly : ast -> string
scattered function assembly

val make_str : (addrmode, string, string) -> string
function make_str(addrmode, name, op) = {
	match addrmode {
		mode(abs)   => concat_str(name, op),
		mode(abs_x) => concat_str(name, concat_str(op, ",X")),
		mode(abs_y) => concat_str(name, concat_str(op, ",Y")),
		mode(imm)   => concat_str(name, concat_str("#", op)),
		mode(rel)   => concat_str(name, op),
		mode(ind)   => concat_str(name, concat_str(concat_str("(", op), ")")),
		mode(ind_x) => concat_str(name, concat_str(concat_str("(", op), ",X)")),
		mode(ind_y) => concat_str(name, concat_str(concat_str("(", op), "),Y")),
		mode(zp)    => concat_str(name, op),
		mode(zp_x)  => concat_str(name, concat_str(op, ",X"))
	}
}

function clause assembly(ADC_IMM(op))   = make_str(mode(imm),   "ADC ", my_hex_str(op))
function clause assembly(ADC_ZP(op))    = make_str(mode(zp),    "ADC ", my_hex_str(op))
function clause assembly(ADC_ZP_X(op))  = make_str(mode(zp_x),  "ADC ", my_hex_str(op))
function clause assembly(ADC_ABS(op))   = make_str(mode(abs),   "ADC ", my_hex_str(op))
function clause assembly(ADC_ABS_X(op)) = make_str(mode(abs_x), "ADC ", my_hex_str(op))
function clause assembly(ADC_ABS_Y(op)) = make_str(mode(abs_y), "ADC ", my_hex_str(op))
function clause assembly(ADC_IND_X(op)) = make_str(mode(ind_x), "ADC ", my_hex_str(op))
function clause assembly(ADC_IND_Y(op)) = make_str(mode(ind_y), "ADC ", my_hex_str(op))

function clause assembly(AND_IMM(op))   = make_str(mode(imm),   "AND ", my_hex_str(op))
function clause assembly(AND_ZP(op))    = make_str(mode(zp),    "AND ", my_hex_str(op))
function clause assembly(AND_ZP_X(op))  = make_str(mode(zp_x),  "AND ", my_hex_str(op))
function clause assembly(AND_ABS(op))   = make_str(mode(abs),   "AND ", my_hex_str(op))
function clause assembly(AND_ABS_X(op)) = make_str(mode(abs_x), "AND ", my_hex_str(op))
function clause assembly(AND_ABS_Y(op)) = make_str(mode(abs_y), "AND ", my_hex_str(op))
function clause assembly(AND_IND_X(op)) = make_str(mode(ind_x), "AND ", my_hex_str(op))
function clause assembly(AND_IND_Y(op)) = make_str(mode(ind_y), "AND ", my_hex_str(op))

function clause assembly(ASL_ACC(op))   = "ASL A"
function clause assembly(ASL_ZP(op))    = make_str(mode(zp),    "ASL ", my_hex_str(op))
function clause assembly(ASL_ZP_X(op))  = make_str(mode(zp_x),  "ASL ", my_hex_str(op))
function clause assembly(ASL_ABS(op))   = make_str(mode(abs),   "ASL ", my_hex_str(op))
function clause assembly(ASL_ABS_X(op)) = make_str(mode(abs_x), "ASL ", my_hex_str(op))

function clause assembly(BCC_REL(op))   = make_str(mode(rel),   "BCC ", my_hex_str(op))
function clause assembly(BCS_REL(op))   = make_str(mode(rel),   "BCS ", my_hex_str(op))
function clause assembly(BEQ_REL(op))   = make_str(mode(rel),   "BEQ ", my_hex_str(op))
function clause assembly(BMI_REL(op))   = make_str(mode(rel),   "BMI ", my_hex_str(op))
function clause assembly(BNE_REL(op))   = make_str(mode(rel),   "BNE ", my_hex_str(op))
function clause assembly(BPL_REL(op))   = make_str(mode(rel),   "BPL ", my_hex_str(op))
function clause assembly(BVC_REL(op))   = make_str(mode(rel),   "BVC ", my_hex_str(op))
function clause assembly(BVS_REL(op))   = make_str(mode(rel),   "BVS ", my_hex_str(op))

function clause assembly(BIT_ZP(op))    = make_str(mode(zp),    "BIT ", my_hex_str(op))
function clause assembly(BIT_ABS(op))   = make_str(mode(abs),   "BIT ", my_hex_str(op))

function clause assembly(BRK())     = "BRK"

function clause assembly(CLC_IMP())     = "CLC"
function clause assembly(CLD_IMP())     = "CLD"
function clause assembly(CLI_IMP())     = "CLI"
function clause assembly(CLV_IMP())     = "CLV"

function clause assembly(CMP_IMM(op))   = make_str(mode(imm),   "CMP ", my_hex_str(op))
function clause assembly(CMP_ZP(op))    = make_str(mode(zp),    "CMP ", my_hex_str(op))
function clause assembly(CMP_ZP_X(op))  = make_str(mode(zp_x),  "CMP ", my_hex_str(op))
function clause assembly(CMP_ABS(op))   = make_str(mode(abs),   "CMP ", my_hex_str(op))
function clause assembly(CMP_ABS_X(op)) = make_str(mode(abs_x), "CMP ", my_hex_str(op))
function clause assembly(CMP_ABS_Y(op)) = make_str(mode(abs_y), "CMP ", my_hex_str(op))
function clause assembly(CMP_IND_X(op)) = make_str(mode(ind_x), "CMP ", my_hex_str(op))
function clause assembly(CMP_IND_Y(op)) = make_str(mode(ind_y), "CMP ", my_hex_str(op))

function clause assembly(CPX_IMM(op))   = make_str(mode(imm),   "CPX ", my_hex_str(op))
function clause assembly(CPX_ZP(op))    = make_str(mode(zp),    "CPX ", my_hex_str(op))
function clause assembly(CPX_ABS(op))   = make_str(mode(abs),   "CPX ", my_hex_str(op))

function clause assembly(CPY_IMM(op))   = make_str(mode(imm),   "CPY ", my_hex_str(op))
function clause assembly(CPY_ZP(op))    = make_str(mode(zp),    "CPY ", my_hex_str(op))
function clause assembly(CPY_ABS(op))   = make_str(mode(abs),   "CPY ", my_hex_str(op))

function clause assembly(DEC_ZP(op))    = make_str(mode(zp),    "DEC ", my_hex_str(op))
function clause assembly(DEC_ZP_X(op))  = make_str(mode(zp_x),  "DEC ", my_hex_str(op))
function clause assembly(DEC_ABS(op))   = make_str(mode(abs),   "DEC ", my_hex_str(op))
function clause assembly(DEC_ABS_X(op)) = make_str(mode(abs_x), "DEC ", my_hex_str(op))

function clause assembly(DEX_IMP())     = "DEX"
function clause assembly(DEY_IMP())     = "DEY"

function clause assembly(EOR_IMM(op))   = make_str(mode(imm),   "EOR ", my_hex_str(op))
function clause assembly(EOR_ZP(op))    = make_str(mode(zp),    "EOR ", my_hex_str(op))
function clause assembly(EOR_ZP_X(op))  = make_str(mode(zp_x),  "EOR ", my_hex_str(op))
function clause assembly(EOR_ABS(op))   = make_str(mode(abs),   "EOR ", my_hex_str(op))
function clause assembly(EOR_ABS_X(op)) = make_str(mode(abs_x), "EOR ", my_hex_str(op))
function clause assembly(EOR_ABS_Y(op)) = make_str(mode(abs_y), "EOR ", my_hex_str(op))
function clause assembly(EOR_IND_X(op)) = make_str(mode(ind_x), "EOR ", my_hex_str(op))
function clause assembly(EOR_IND_Y(op)) = make_str(mode(ind_y), "EOR ", my_hex_str(op))

function clause assembly(INC_ZP(op))    = make_str(mode(zp),    "INC ", my_hex_str(op))
function clause assembly(INC_ZP_X(op))  = make_str(mode(zp_x),  "INC ", my_hex_str(op))
function clause assembly(INC_ABS(op))   = make_str(mode(abs),   "INC ", my_hex_str(op))
function clause assembly(INC_ABS_X(op)) = make_str(mode(abs_x), "INC ", my_hex_str(op))

function clause assembly(INX_IMP())     = "INX"
function clause assembly(INY_IMP())     = "INY"

function clause assembly(JMP_ABS(op))   = make_str(mode(abs),   "JMP ", my_hex_str(op))
function clause assembly(JMP_IND(op))   = make_str(mode(ind),   "JMP ", my_hex_str(op))

function clause assembly(JSR_ABS(op))   = make_str(mode(abs),   "JSR ", my_hex_str(op))

function clause assembly(LDA_IMM(op))   = make_str(mode(imm),   "LDA ", my_hex_str(op))
function clause assembly(LDA_ZP(op))    = make_str(mode(zp),    "LDA ", my_hex_str(op))
function clause assembly(LDA_ZP_X(op))  = make_str(mode(zp_x),  "LDA ", my_hex_str(op))
function clause assembly(LDA_ABS(op))   = make_str(mode(abs),   "LDA ", my_hex_str(op))
function clause assembly(LDA_ABS_X(op)) = make_str(mode(abs_x), "LDA ", my_hex_str(op))
function clause assembly(LDA_ABS_Y(op)) = make_str(mode(abs_y), "LDA ", my_hex_str(op))
function clause assembly(LDA_IND_X(op)) = make_str(mode(ind_x), "LDA ", my_hex_str(op))
function clause assembly(LDA_IND_Y(op)) = make_str(mode(ind_y), "LDA ", my_hex_str(op))

function clause assembly(LDX_IMM(op))   = make_str(mode(imm),   "LDX ", my_hex_str(op))
function clause assembly(LDX_ZP(op))    = make_str(mode(zp),    "LDX ", my_hex_str(op))
function clause assembly(LDX_ZP_Y(op))  = make_str(mode(zp_y),  "LDX ", my_hex_str(op))
function clause assembly(LDX_ABS(op))   = make_str(mode(abs),   "LDX ", my_hex_str(op))
function clause assembly(LDX_ABS_Y(op)) = make_str(mode(abs_y), "LDX ", my_hex_str(op))

function clause assembly(LDY_IMM(op))   = make_str(mode(imm),   "LDY ", my_hex_str(op))
function clause assembly(LDY_ZP(op))    = make_str(mode(zp),    "LDY ", my_hex_str(op))
function clause assembly(LDY_ZP_X(op))  = make_str(mode(zp_x),  "LDY ", my_hex_str(op))
function clause assembly(LDY_ABS(op))   = make_str(mode(abs),   "LDY ", my_hex_str(op))
function clause assembly(LDY_ABS_X(op)) = make_str(mode(abs_x), "LDY ", my_hex_str(op))

function clause assembly(LSR_ACC(op))   = "LSR A"
function clause assembly(LSR_ZP(op))    = make_str(mode(zp),    "LSR ", my_hex_str(op))
function clause assembly(LSR_ZP_X(op))  = make_str(mode(zp_x),  "LSR ", my_hex_str(op))
function clause assembly(LSR_ABS(op))   = make_str(mode(abs),   "LSR ", my_hex_str(op))
function clause assembly(LSR_ABS_X(op)) = make_str(mode(abs_x), "LSR ", my_hex_str(op))

function clause assembly(ORA_IMM(op))   = make_str(mode(imm),   "ORA ", my_hex_str(op))
function clause assembly(ORA_ZP(op))    = make_str(mode(zp),    "ORA ", my_hex_str(op))
function clause assembly(ORA_ZP_X(op))  = make_str(mode(zp_x),  "ORA ", my_hex_str(op))
function clause assembly(ORA_ABS(op))   = make_str(mode(abs),   "ORA ", my_hex_str(op))
function clause assembly(ORA_ABS_X(op)) = make_str(mode(abs_x), "ORA ", my_hex_str(op))
function clause assembly(ORA_ABS_Y(op)) = make_str(mode(abs_y), "ORA ", my_hex_str(op))
function clause assembly(ORA_IND_X(op)) = make_str(mode(ind_x), "ORA ", my_hex_str(op))
function clause assembly(ORA_IND_Y(op)) = make_str(mode(ind_y), "ORA ", my_hex_str(op))

function clause assembly(NOP())         = "NOP"

function clause assembly(PHA_IMP())     = "PHA"
function clause assembly(PHP_IMP())     = "PHP"
function clause assembly(PLA_IMP())     = "PLA"
function clause assembly(PLP_IMP())     = "PLP"

function clause assembly(ROL_ACC(op))   = "ROL A"
function clause assembly(ROL_ZP(op))    = make_str(mode(zp),    "ROL ", my_hex_str(op))
function clause assembly(ROL_ZP_X(op))  = make_str(mode(zp_x),  "ROL ", my_hex_str(op))
function clause assembly(ROL_ABS(op))   = make_str(mode(abs),   "ROL ", my_hex_str(op))
function clause assembly(ROL_ABS_X(op)) = make_str(mode(abs_x), "ROL ", my_hex_str(op))

function clause assembly(ROR_ACC(op))   = "ROR A"
function clause assembly(ROR_ZP(op))    = make_str(mode(zp),    "ROR ", my_hex_str(op))
function clause assembly(ROR_ZP_X(op))  = make_str(mode(zp_x),  "ROR ", my_hex_str(op))
function clause assembly(ROR_ABS(op))   = make_str(mode(abs),   "ROR ", my_hex_str(op))
function clause assembly(ROR_ABS_X(op)) = make_str(mode(abs_x), "ROR ", my_hex_str(op))

function clause assembly(RTI_IMP())     = "RTI"

function clause assembly(RTS_IMP())     = "RTS"

function clause assembly(SBC_IMM(op))   = make_str(mode(imm),   "SBC ", my_hex_str(op))
function clause assembly(SBC_ZP(op))    = make_str(mode(zp),    "SBC ", my_hex_str(op))
function clause assembly(SBC_ZP_X(op))  = make_str(mode(zp_x),  "SBC ", my_hex_str(op))
function clause assembly(SBC_ABS(op))   = make_str(mode(abs),   "SBC ", my_hex_str(op))
function clause assembly(SBC_ABS_X(op)) = make_str(mode(abs_x), "SBC ", my_hex_str(op))
function clause assembly(SBC_ABS_Y(op)) = make_str(mode(abs_y), "SBC ", my_hex_str(op))
function clause assembly(SBC_IND_X(op)) = make_str(mode(ind_x), "SBC ", my_hex_str(op))
function clause assembly(SBC_IND_Y(op)) = make_str(mode(ind_y), "SBC ", my_hex_str(op))

function clause assembly(SEC_IMP())     = "SEC"
function clause assembly(SED_IMP())     = "SED"
function clause assembly(SEI_IMP())     = "SEI"
function clause assembly(STA_ZP(op))    = make_str(mode(zp),    "STA ", my_hex_str(op))
function clause assembly(STA_ZP_X(op))  = make_str(mode(zp_x),  "STA ", my_hex_str(op))
function clause assembly(STA_ABS(op))   = make_str(mode(abs),   "STA ", my_hex_str(op))
function clause assembly(STA_ABS_X(op)) = make_str(mode(abs_x), "STA ", my_hex_str(op))
function clause assembly(STA_ABS_Y(op)) = make_str(mode(abs_y), "STA ", my_hex_str(op))
function clause assembly(STA_IND_X(op)) = make_str(mode(ind_x), "STA ", my_hex_str(op))
function clause assembly(STA_IND_Y(op)) = make_str(mode(ind_y), "STA ", my_hex_str(op))

function clause assembly(STX_ZP(op))    = make_str(mode(zp),    "STX ", my_hex_str(op))
function clause assembly(STX_ZP_Y(op))  = make_str(mode(zp_y),  "STX ", my_hex_str(op))
function clause assembly(STX_ABS(op))   = make_str(mode(abs),   "STX ", my_hex_str(op))

function clause assembly(STY_ZP(op))    = make_str(mode(zp),    "STY ", my_hex_str(op))
function clause assembly(STY_ZP_X(op))  = make_str(mode(zp_x),  "STY ", my_hex_str(op))
function clause assembly(STY_ABS(op))   = make_str(mode(abs),   "STY ", my_hex_str(op))

function clause assembly(TAX_IMP())     = "TAX"
function clause assembly(TAY_IMP())     = "TAY"
function clause assembly(TSX_IMP())     = "TSX"
function clause assembly(TXA_IMP())     = "TXA"
function clause assembly(TXS_IMP())     = "TXS"
function clause assembly(TYA_IMP())     = "TYA"

function clause assembly(INVALID(instruction)) = concat_str("Invalid instruction: ", bits_str(instruction))