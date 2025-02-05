val assembly : (address, ast) -> string
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

function clause assembly(PC, ADC_IMM(op))   = make_str(mode(imm),   "ADC ", my_hex_str(op))
function clause assembly(PC, ADC_ZP(op))    = make_str(mode(zp),    "ADC ", my_hex_str(op))
function clause assembly(PC, ADC_ZP_X(op))  = make_str(mode(zp_x),  "ADC ", my_hex_str(op))
function clause assembly(PC, ADC_ABS(op))   = make_str(mode(abs),   "ADC ", my_hex_str(op))
function clause assembly(PC, ADC_ABS_X(op)) = make_str(mode(abs_x), "ADC ", my_hex_str(op))
function clause assembly(PC, ADC_ABS_Y(op)) = make_str(mode(abs_y), "ADC ", my_hex_str(op))
function clause assembly(PC, ADC_IND_X(op)) = make_str(mode(ind_x), "ADC ", my_hex_str(op))
function clause assembly(PC, ADC_IND_Y(op)) = make_str(mode(ind_y), "ADC ", my_hex_str(op))

function clause assembly(PC, AND_IMM(op))   = make_str(mode(imm),   "AND ", my_hex_str(op))
function clause assembly(PC, AND_ZP(op))    = make_str(mode(zp),    "AND ", my_hex_str(op))
function clause assembly(PC, AND_ZP_X(op))  = make_str(mode(zp_x),  "AND ", my_hex_str(op))
function clause assembly(PC, AND_ABS(op))   = make_str(mode(abs),   "AND ", my_hex_str(op))
function clause assembly(PC, AND_ABS_X(op)) = make_str(mode(abs_x), "AND ", my_hex_str(op))
function clause assembly(PC, AND_ABS_Y(op)) = make_str(mode(abs_y), "AND ", my_hex_str(op))
function clause assembly(PC, AND_IND_X(op)) = make_str(mode(ind_x), "AND ", my_hex_str(op))
function clause assembly(PC, AND_IND_Y(op)) = make_str(mode(ind_y), "AND ", my_hex_str(op))

function clause assembly(PC, ASL(op))   = "ASL A"
function clause assembly(PC, ASL_ZP(op))    = make_str(mode(zp),    "ASL ", my_hex_str(op))
function clause assembly(PC, ASL_ZP_X(op))  = make_str(mode(zp_x),  "ASL ", my_hex_str(op))
function clause assembly(PC, ASL_ABS(op))   = make_str(mode(abs),   "ASL ", my_hex_str(op))
function clause assembly(PC, ASL_ABS_X(op)) = make_str(mode(abs_x), "ASL ", my_hex_str(op))

function clause assembly(PC, BCC_REL(op))   = "BCC"
function clause assembly(PC, BCS_REL(op))   = "BCS"
function clause assembly(PC, BEQ_REL(op))   = "BEQ"
function clause assembly(PC, BMI_REL(op))   = "BMI"
function clause assembly(PC, BNE_REL(op))   = "BNE"
function clause assembly(PC, BPL_REL(op))   = "BPL"
function clause assembly(PC, BVC_REL(op))   = "BVC"
function clause assembly(PC, BVS_REL(op))   = "BVS"

function clause assembly(PC, BIT_ZP(op))    = make_str(mode(zp),    "BIT ", my_hex_str(op))
function clause assembly(PC, BIT_ABS(op))   = make_str(mode(abs),   "BIT ", my_hex_str(op))

function clause assembly(PC, BRK())     = "BRK"

function clause assembly(PC, CLC())     = "CLC"
function clause assembly(PC, CLD())     = "CLD"
function clause assembly(PC, CLI())     = "CLI"
function clause assembly(PC, CLV())     = "CLV"

function clause assembly(PC, CMP_IMM(op))   = make_str(mode(imm),   "CMP ", my_hex_str(op))
function clause assembly(PC, CMP_ZP(op))    = make_str(mode(zp),    "CMP ", my_hex_str(op))
function clause assembly(PC, CMP_ZP_X(op))  = make_str(mode(zp_x),  "CMP ", my_hex_str(op))
function clause assembly(PC, CMP_ABS(op))   = make_str(mode(abs),   "CMP ", my_hex_str(op))
function clause assembly(PC, CMP_ABS_X(op)) = make_str(mode(abs_x), "CMP ", my_hex_str(op))
function clause assembly(PC, CMP_ABS_Y(op)) = make_str(mode(abs_y), "CMP ", my_hex_str(op))
function clause assembly(PC, CMP_IND_X(op)) = make_str(mode(ind_x), "CMP ", my_hex_str(op))
function clause assembly(PC, CMP_IND_Y(op)) = make_str(mode(ind_y), "CMP ", my_hex_str(op))

function clause assembly(PC, CPX_IMM(op))   = make_str(mode(imm),   "CPX ", my_hex_str(op))
function clause assembly(PC, CPX_ZP(op))    = make_str(mode(zp),    "CPX ", my_hex_str(op))
function clause assembly(PC, CPX_ABS(op))   = make_str(mode(abs),   "CPX ", my_hex_str(op))

function clause assembly(PC, CPY_IMM(op))   = make_str(mode(imm),   "CPY ", my_hex_str(op))
function clause assembly(PC, CPY_ZP(op))    = make_str(mode(zp),    "CPY ", my_hex_str(op))
function clause assembly(PC, CPY_ABS(op))   = make_str(mode(abs),   "CPY ", my_hex_str(op))

function clause assembly(PC, DEC_ZP(op))    = make_str(mode(zp),    "DEC ", my_hex_str(op))
function clause assembly(PC, DEC_ZP_X(op))  = make_str(mode(zp_x),  "DEC ", my_hex_str(op))
function clause assembly(PC, DEC_ABS(op))   = make_str(mode(abs),   "DEC ", my_hex_str(op))
function clause assembly(PC, DEC_ABS_X(op)) = make_str(mode(abs_x), "DEC ", my_hex_str(op))

function clause assembly(PC, DEX())     = "DEX"
function clause assembly(PC, DEY())     = "DEY"

function clause assembly(PC, EOR_IMM(op))   = make_str(mode(imm),   "EOR ", my_hex_str(op))
function clause assembly(PC, EOR_ZP(op))    = make_str(mode(zp),    "EOR ", my_hex_str(op))
function clause assembly(PC, EOR_ZP_X(op))  = make_str(mode(zp_x),  "EOR ", my_hex_str(op))
function clause assembly(PC, EOR_ABS(op))   = make_str(mode(abs),   "EOR ", my_hex_str(op))
function clause assembly(PC, EOR_ABS_X(op)) = make_str(mode(abs_x), "EOR ", my_hex_str(op))
function clause assembly(PC, EOR_ABS_Y(op)) = make_str(mode(abs_y), "EOR ", my_hex_str(op))
function clause assembly(PC, EOR_IND_X(op)) = make_str(mode(ind_x), "EOR ", my_hex_str(op))
function clause assembly(PC, EOR_IND_Y(op)) = make_str(mode(ind_y), "EOR ", my_hex_str(op))

function clause assembly(PC, INC_ZP(op))    = make_str(mode(zp),    "INC ", my_hex_str(op))
function clause assembly(PC, INC_ZP_X(op))  = make_str(mode(zp_x),  "INC ", my_hex_str(op))
function clause assembly(PC, INC_ABS(op))   = make_str(mode(abs),   "INC ", my_hex_str(op))
function clause assembly(PC, INC_ABS_X(op)) = make_str(mode(abs_x), "INC ", my_hex_str(op))

function clause assembly(PC, INX())     = "INX"
function clause assembly(PC, INY())     = "INY"

function clause assembly(PC, JMP_ABS(op))   = make_str(mode(abs),   "JMP ", my_hex_str(op))
function clause assembly(PC, JMP_IND(op))   = make_str(mode(ind),   "JMP ", my_hex_str(op))

function clause assembly(PC, JSR_ABS(op))   = make_str(mode(abs),   "JSR ", my_hex_str(op))

function clause assembly(PC, LDA_IMM(op))   = make_str(mode(imm),   "LDA ", my_hex_str(op))
function clause assembly(PC, LDA_ZP(op))    = make_str(mode(zp),    "LDA ", my_hex_str(op))
function clause assembly(PC, LDA_ZP_X(op))  = make_str(mode(zp_x),  "LDA ", my_hex_str(op))
function clause assembly(PC, LDA_ABS(op))   = make_str(mode(abs),   "LDA ", my_hex_str(op))
function clause assembly(PC, LDA_ABS_X(op)) = make_str(mode(abs_x), "LDA ", my_hex_str(op))
function clause assembly(PC, LDA_ABS_Y(op)) = make_str(mode(abs_y), "LDA ", my_hex_str(op))
function clause assembly(PC, LDA_IND_X(op)) = make_str(mode(ind_x), "LDA ", my_hex_str(op))
function clause assembly(PC, LDA_IND_Y(op)) = make_str(mode(ind_y), "LDA ", my_hex_str(op))
function clause assembly(PC, LDX_IMM(op))   = make_str(mode(imm),   "LDX ", my_hex_str(op))
function clause assembly(PC, LDX_ZP(op))    = make_str(mode(zp),    "LDX ", my_hex_str(op))
function clause assembly(PC, LDX_ZP_Y(op))  = make_str(mode(zp_y),  "LDX ", my_hex_str(op))
function clause assembly(PC, LDX_ABS(op))   = make_str(mode(abs),   "LDX ", my_hex_str(op))
function clause assembly(PC, LDX_ABS_Y(op)) = make_str(mode(abs_y), "LDX ", my_hex_str(op))
function clause assembly(PC, LDY_IMM(op))   = make_str(mode(imm),   "LDY ", my_hex_str(op))
function clause assembly(PC, LDY_ZP(op))    = make_str(mode(zp),    "LDY ", my_hex_str(op))
function clause assembly(PC, LDY_ZP_X(op))  = make_str(mode(zp_x),  "LDY ", my_hex_str(op))
function clause assembly(PC, LDY_ABS(op))   = make_str(mode(abs),   "LDY ", my_hex_str(op))
function clause assembly(PC, LDY_ABS_X(op)) = make_str(mode(abs_x), "LDY ", my_hex_str(op))
function clause assembly(PC, STA_ZP(op))    = make_str(mode(zp),    "STA ", my_hex_str(op))
function clause assembly(PC, STA_ZP_X(op))  = make_str(mode(zp_x),  "STA ", my_hex_str(op))
function clause assembly(PC, STA_ABS(op))   = make_str(mode(abs),   "STA ", my_hex_str(op))
function clause assembly(PC, STA_ABS_X(op)) = make_str(mode(abs_x), "STA ", my_hex_str(op))
function clause assembly(PC, STA_ABS_Y(op)) = make_str(mode(abs_y), "STA ", my_hex_str(op))
function clause assembly(PC, STA_IND_X(op)) = make_str(mode(ind_x), "STA ", my_hex_str(op))
function clause assembly(PC, STA_IND_Y(op)) = make_str(mode(ind_y), "STA ", my_hex_str(op))
function clause assembly(PC, STX_ZP(op))    = make_str(mode(zp),    "STX ", my_hex_str(op))
function clause assembly(PC, STX_ZP_Y(op))  = make_str(mode(zp_y),  "STX ", my_hex_str(op))
function clause assembly(PC, STX_ABS(op))   = make_str(mode(abs),   "STX ", my_hex_str(op))
function clause assembly(PC, STY_ZP(op))    = make_str(mode(zp),    "STY ", my_hex_str(op))
function clause assembly(PC, STY_ZP_X(op))  = make_str(mode(zp_x),  "STY ", my_hex_str(op))
function clause assembly(PC, STY_ABS(op))   = make_str(mode(abs),   "STY ", my_hex_str(op))
function clause assembly(PC, TAX())     = "TAX"
function clause assembly(PC, TAY())     = "TAY"
function clause assembly(PC, TSX())     = "TSX"
function clause assembly(PC, TXA())     = "TXA"
function clause assembly(PC, TXS())     = "TXS"
function clause assembly(PC, TYA())     = "TYA"

function clause assembly(PC, LSR(op))   = "LSR A"
function clause assembly(PC, LSR_ZP(op))    = make_str(mode(zp),    "LSR ", my_hex_str(op))
function clause assembly(PC, LSR_ZP_X(op))  = make_str(mode(zp_x),  "LSR ", my_hex_str(op))
function clause assembly(PC, LSR_ABS(op))   = make_str(mode(abs),   "LSR ", my_hex_str(op))
function clause assembly(PC, LSR_ABS_X(op)) = make_str(mode(abs_x), "LSR ", my_hex_str(op))

function clause assembly(PC, ORA_IMM(op))   = make_str(mode(imm),   "ORA ", my_hex_str(op))
function clause assembly(PC, ORA_ZP(op))    = make_str(mode(zp),    "ORA ", my_hex_str(op))
function clause assembly(PC, ORA_ZP_X(op))  = make_str(mode(zp_x),  "ORA ", my_hex_str(op))
function clause assembly(PC, ORA_ABS(op))   = make_str(mode(abs),   "ORA ", my_hex_str(op))
function clause assembly(PC, ORA_ABS_X(op)) = make_str(mode(abs_x), "ORA ", my_hex_str(op))
function clause assembly(PC, ORA_ABS_Y(op)) = make_str(mode(abs_y), "ORA ", my_hex_str(op))
function clause assembly(PC, ORA_IND_X(op)) = make_str(mode(ind_x), "ORA ", my_hex_str(op))
function clause assembly(PC, ORA_IND_Y(op)) = make_str(mode(ind_y), "ORA ", my_hex_str(op))

function clause assembly(PC, NOP())         = "NOP"

function clause assembly(PC, PHA())     = "PHA"
function clause assembly(PC, PHP())     = "PHP"
function clause assembly(PC, PLA())     = "PLA"
function clause assembly(PC, PLP())     = "PLP"

function clause assembly(PC, ROL(op))   = "ROL A"
function clause assembly(PC, ROL_ZP(op))    = make_str(mode(zp),    "ROL ", my_hex_str(op))
function clause assembly(PC, ROL_ZP_X(op))  = make_str(mode(zp_x),  "ROL ", my_hex_str(op))
function clause assembly(PC, ROL_ABS(op))   = make_str(mode(abs),   "ROL ", my_hex_str(op))
function clause assembly(PC, ROL_ABS_X(op)) = make_str(mode(abs_x), "ROL ", my_hex_str(op))

function clause assembly(PC, ROR(op))   = "ROR A"
function clause assembly(PC, ROR_ZP(op))    = make_str(mode(zp),    "ROR ", my_hex_str(op))
function clause assembly(PC, ROR_ZP_X(op))  = make_str(mode(zp_x),  "ROR ", my_hex_str(op))
function clause assembly(PC, ROR_ABS(op))   = make_str(mode(abs),   "ROR ", my_hex_str(op))
function clause assembly(PC, ROR_ABS_X(op)) = make_str(mode(abs_x), "ROR ", my_hex_str(op))

function clause assembly(PC, RTI())     = "RTI"

function clause assembly(PC, RTS())     = "RTS"

function clause assembly(PC, SBC_IMM(op))   = make_str(mode(imm),   "SBC ", my_hex_str(op))
function clause assembly(PC, SBC_ZP(op))    = make_str(mode(zp),    "SBC ", my_hex_str(op))
function clause assembly(PC, SBC_ZP_X(op))  = make_str(mode(zp_x),  "SBC ", my_hex_str(op))
function clause assembly(PC, SBC_ABS(op))   = make_str(mode(abs),   "SBC ", my_hex_str(op))
function clause assembly(PC, SBC_ABS_X(op)) = make_str(mode(abs_x), "SBC ", my_hex_str(op))
function clause assembly(PC, SBC_ABS_Y(op)) = make_str(mode(abs_y), "SBC ", my_hex_str(op))
function clause assembly(PC, SBC_IND_X(op)) = make_str(mode(ind_x), "SBC ", my_hex_str(op))
function clause assembly(PC, SBC_IND_Y(op)) = make_str(mode(ind_y), "SBC ", my_hex_str(op))

function clause assembly(PC, SEC())     = "SEC"
function clause assembly(PC, SED())     = "SED"
function clause assembly(PC, SEI())     = "SEI"

function clause assembly(PC, INVALID(instruction)) = concat_str("Invalid instruction: ", bits_str(instruction))