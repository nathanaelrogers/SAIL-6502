scattered union ast

val execute : ast -> bool
scattered function execute

val decode08 : bits(8) -> ast
scattered function decode08

val decode16 : bits(16) -> ast
scattered function decode16

val decode24 : bits(24) -> ast
scattered function decode24

overload decode = {decode08, decode16, decode24}

union clause ast = ADC_IMM   : (word)
union clause ast = ADC_ZP    : (word)
union clause ast = ADC_ZP_X  : (word)
union clause ast = ADC_ABS   : (address)
union clause ast = ADC_ABS_X : (address)
union clause ast = ADC_ABS_Y : (address)
union clause ast = ADC_IND_X : (word)
union clause ast = ADC_IND_Y : (word)
$include "./instructions/arithmetic/ADC.sail"

union clause ast = AND_IMM   : (word)
union clause ast = AND_ZP    : (word)
union clause ast = AND_ZP_X  : (word)
union clause ast = AND_ABS   : (address)
union clause ast = AND_ABS_X : (address)
union clause ast = AND_ABS_Y : (address)
union clause ast = AND_IND_X : (word)
union clause ast = AND_IND_Y : (word)
$include "./instructions/logical/AND.sail"

union clause ast = BCC_REL   : (word)
union clause ast = BCS_REL   : (word)
union clause ast = BEQ_REL   : (word)
union clause ast = BMI_REL   : (word)
union clause ast = BNE_REL   : (word)
union clause ast = BPL_REL   : (word)
union clause ast = BVC_REL   : (word)
union clause ast = BVS_REL   : (word)
$include "./instructions/branch.sail"

union clause ast = CLC_IMP   : (unit)
union clause ast = CLD_IMP   : (unit)
$include "./instructions/flag/CLC.sail"
$include "./instructions/flag/CLD.sail"

union clause ast = CMP_IMM   : (word)
union clause ast = CMP_ZP    : (word)
union clause ast = CMP_ZP_X  : (word)
union clause ast = CMP_ABS   : (address)
union clause ast = CMP_ABS_X : (address)
union clause ast = CMP_ABS_Y : (address)
union clause ast = CMP_IND_X : (word)
union clause ast = CMP_IND_Y : (word)
$include "./instructions/comparison/CMP.sail"

union clause ast = CPY_IMM   : (word)
union clause ast = CPY_ZP    : (word)
union clause ast = CPY_ABS   : (address)
$include "./instructions/comparison/CPY.sail"

union clause ast = CPX_IMM   : (word)
union clause ast = CPX_ZP    : (word)
union clause ast = CPX_ABS   : (address)
$include "./instructions/comparison/CPX.sail"

union clause ast = DEX_IMP   : (unit)
union clause ast = DEY_IMP   : (unit)
$include "./instructions/increment/DEX.sail"
$include "./instructions/increment/DEY.sail"

union clause ast = EOR_IMM   : (word)
union clause ast = EOR_ZP    : (word)
union clause ast = EOR_ZP_X  : (word)
union clause ast = EOR_ABS   : (address)
union clause ast = EOR_ABS_X : (address)
union clause ast = EOR_ABS_Y : (address)
union clause ast = EOR_IND_X : (word)
union clause ast = EOR_IND_Y : (word)
$include "./instructions/logical/EOR.sail"

union clause ast = INC_ZP    : (word)
union clause ast = INC_ZP_X  : (word)
union clause ast = INC_ABS   : (address)
union clause ast = INC_ABS_X : (address)
$include "./instructions/increment/INC.sail"

union clause ast = INX_IMP   : (unit)
union clause ast = INY_IMP   : (unit)
$include "./instructions/increment/INX.sail"
$include "./instructions/increment/INY.sail"

union clause ast = JMP_ABS   : (address)
union clause ast = JMP_IND   : (address)
$include "./instructions/subroutine/JMP.sail"

union clause ast = JSR_ABS   : (address)
$include "./instructions/subroutine/JSR.sail"

union clause ast = LDA_IMM   : (word)
union clause ast = LDA_ZP    : (word)
union clause ast = LDA_ZP_X  : (word)
union clause ast = LDA_ABS   : (address)
union clause ast = LDA_ABS_X : (address)
union clause ast = LDA_ABS_Y : (address)
union clause ast = LDA_IND_X : (word)
union clause ast = LDA_IND_Y : (word)
$include "./instructions/transfer/LDA.sail"

union clause ast = LDX_IMM   : (word)
union clause ast = LDX_ZP    : (word)
union clause ast = LDX_ZP_Y  : (word)
union clause ast = LDX_ABS   : (address)
union clause ast = LDX_ABS_Y : (address)
$include "./instructions/transfer/LDX.sail"

union clause ast = LDY_IMM   : (word)
union clause ast = LDY_ZP    : (word)
union clause ast = LDY_ZP_X  : (word)
union clause ast = LDY_ABS   : (address)
union clause ast = LDY_ABS_X : (address)
$include "./instructions/transfer/LDY.sail"

union clause ast = ORA_IMM   : (word)
union clause ast = ORA_ZP    : (word)
union clause ast = ORA_ZP_X  : (word)
union clause ast = ORA_ABS   : (address)
union clause ast = ORA_ABS_X : (address)
union clause ast = ORA_ABS_Y : (address)
union clause ast = ORA_IND_X : (word)
union clause ast = ORA_IND_Y : (word)
$include "./instructions/logical/ORA.sail"

union clause ast = PHA_IMP   : (unit)
union clause ast = PHP_IMP   : (unit)
union clause ast = PLA_IMP   : (unit)
union clause ast = PLP_IMP   : (unit)
$include "./instructions/stack/PHA.sail"
$include "./instructions/stack/PHP.sail"
$include "./instructions/stack/PLA.sail"
$include "./instructions/stack/PLP.sail"

union clause ast = RTS_IMP   : (unit)
$include "./instructions/subroutine/RTS.sail"

union clause ast = SBC_IMM   : (word)
union clause ast = SBC_ZP    : (word)
union clause ast = SBC_ZP_X  : (word)
union clause ast = SBC_ABS   : (address)
union clause ast = SBC_ABS_X : (address)
union clause ast = SBC_ABS_Y : (address)
union clause ast = SBC_IND_X : (word)
union clause ast = SBC_IND_Y : (word)
$include "./instructions/arithmetic/SBC.sail"

union clause ast = SEC_IMP   : (unit)
union clause ast = SED_IMP   : (unit)
$include "./instructions/flag/SEC.sail"
$include "./instructions/flag/SED.sail"

union clause ast = STA_ZP    : (word)
union clause ast = STA_ZP_X  : (word)
union clause ast = STA_ABS   : (address)
union clause ast = STA_ABS_X : (address)
union clause ast = STA_ABS_Y : (address)
union clause ast = STA_IND_X : (word)
union clause ast = STA_IND_Y : (word)
$include "./instructions/transfer/STA.sail"

union clause ast = STX_ZP    : (word)
union clause ast = STX_ZP_Y  : (word)
union clause ast = STX_ABS   : (address)
$include "./instructions/transfer/STX.sail"

union clause ast = STY_ZP    : (word)
union clause ast = STY_ZP_X  : (word)
union clause ast = STY_ABS   : (address)
$include "./instructions/transfer/STY.sail"

union clause ast = TAX_IMP   : (unit)
union clause ast = TAY_IMP   : (unit)
union clause ast = TSX_IMP   : (unit)
union clause ast = TXA_IMP   : (unit)
union clause ast = TXS_IMP   : (unit)
union clause ast = TYA_IMP   : (unit)
$include "./instructions/transfer/TAX.sail"
$include "./instructions/transfer/TAY.sail"
$include "./instructions/transfer/TSX.sail"
$include "./instructions/transfer/TXA.sail"
$include "./instructions/transfer/TXS.sail"
$include "./instructions/transfer/TYA.sail"
