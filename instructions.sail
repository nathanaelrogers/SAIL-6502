scattered union ast

val execute : ast -> bool
scattered function execute

val decode08 : (bits(8), bool) -> ast
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
$include "./instructions/arithmetic/instruction-execute-ADC.sail"

union clause ast = AND_IMM   : (word)
union clause ast = AND_ZP    : (word)
union clause ast = AND_ZP_X  : (word)
union clause ast = AND_ABS   : (address)
union clause ast = AND_ABS_X : (address)
union clause ast = AND_ABS_Y : (address)
union clause ast = AND_IND_X : (word)
union clause ast = AND_IND_Y : (word)
$include "./instructions/logical/instruction-execute-AND.sail"

union clause ast = EOR_IMM   : (word)
union clause ast = EOR_ZP    : (word)
union clause ast = EOR_ZP_X  : (word)
union clause ast = EOR_ABS   : (address)
union clause ast = EOR_ABS_X : (address)
union clause ast = EOR_ABS_Y : (address)
union clause ast = EOR_IND_X : (word)
union clause ast = EOR_IND_Y : (word)
$include "./instructions/logical/instruction-execute-EOR.sail"

union clause ast = LDA_IMM   : (word)
union clause ast = LDA_ZP    : (word)
union clause ast = LDA_ZP_X  : (word)
union clause ast = LDA_ABS   : (address)
union clause ast = LDA_ABS_X : (address)
union clause ast = LDA_ABS_Y : (address)
union clause ast = LDA_IND_X : (word)
union clause ast = LDA_IND_Y : (word)
$include "./instructions/transfer/instruction-execute-LDA.sail"

union clause ast = LDX_IMM   : (word)
union clause ast = LDX_ZP    : (word)
union clause ast = LDX_ZP_Y  : (word)
union clause ast = LDX_ABS   : (address)
union clause ast = LDX_ABS_Y : (address)
$include "./instructions/transfer/instruction-execute-LDX.sail"

union clause ast = LDY_IMM   : (word)
union clause ast = LDY_ZP    : (word)
union clause ast = LDY_ZP_X  : (word)
union clause ast = LDY_ABS   : (address)
union clause ast = LDY_ABS_X : (address)
$include "./instructions/transfer/instruction-execute-LDY.sail"

union clause ast = ORA_IMM   : (word)
union clause ast = ORA_ZP    : (word)
union clause ast = ORA_ZP_X  : (word)
union clause ast = ORA_ABS   : (address)
union clause ast = ORA_ABS_X : (address)
union clause ast = ORA_ABS_Y : (address)
union clause ast = ORA_IND_X : (word)
union clause ast = ORA_IND_Y : (word)
$include "./instructions/logical/instruction-execute-ORA.sail"

union clause ast = SBC_IMM   : (word)
union clause ast = SBC_ZP    : (word)
union clause ast = SBC_ZP_X  : (word)
union clause ast = SBC_ABS   : (address)
union clause ast = SBC_ABS_X : (address)
union clause ast = SBC_ABS_Y : (address)
union clause ast = SBC_IND_X : (word)
union clause ast = SBC_IND_Y : (word)
$include "./instructions/arithmetic/instruction-execute-SBC.sail"

union clause ast = STA_ZP    : (word)
union clause ast = STA_ZP_X  : (word)
union clause ast = STA_ABS   : (address)
union clause ast = STA_ABS_X : (address)
union clause ast = STA_ABS_Y : (address)
union clause ast = STA_IND_X : (word)
union clause ast = STA_IND_Y : (word)
$include "./instructions/transfer/instruction-execute-STA.sail"

union clause ast = STX_ZP    : (word)
union clause ast = STX_ZP_Y  : (word)
union clause ast = STX_ABS   : (address)
$include "./instructions/transfer/instruction-execute-STX.sail"

union clause ast = STY_ZP    : (word)
union clause ast = STY_ZP_X  : (word)
union clause ast = STY_ABS   : (address)
$include "./instructions/transfer/instruction-execute-STY.sail"
