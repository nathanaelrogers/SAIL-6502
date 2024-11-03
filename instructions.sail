$include "./instructions/arithmetic/decimal.sail"

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
