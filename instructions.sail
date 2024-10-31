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

// union clause ast = ADC_IMM : (word)
// union clause ast = ADC_ZP : (word)
// union clause ast = ADC_ZP_X : (word)
// union clause ast = ADC_ABS : (address)
// union clause ast = ADC_ABS_X : (address)
// union clause ast = ADC_ABS_Y : (address)
// union clause ast = ADC_IND_X : (word)
// union clause ast = ADC_IND_Y : (word)

union clause ast = AND_IMM   : (word)
union clause ast = AND_ZP    : (word)
union clause ast = AND_ZP_X  : (word)
union clause ast = AND_ABS   : (address)
union clause ast = AND_ABS_X : (address)
union clause ast = AND_ABS_Y : (address)
union clause ast = AND_IND_X : (word)
union clause ast = AND_IND_Y : (word)
$include "./instructions/logical/instruction-execute-AND.sail"


// union clause ast = ASL : (unit)
// union clause ast = ASL_ZP : (word)
// union clause ast = ASL_ZP_X : (word)
// union clause ast = ASL_ABS : (address)
// union clause ast = ASL_ABS_X : (address)

//union clause ast = BCC : (unit)

//union clause ast = BCS : (unit)

//union clause ast = BEQ : (unit)

//union clause ast = BIT : (unit)

//union clause ast = BMI : (unit)

//union clause ast = BNE : (unit)

//union clause ast = BPL : (unit)

// union clause ast = BRK : (unit)

//union clause ast = BVC : (unit)

//union clause ast = BVS : (unit)

// union clause ast = CLC : (unit)

// union clause ast = CLD : (unit)

// union clause ast = CLI : (unit)

// union clause ast = CLV : (unit)

//union clause ast = CMP : (unit)

//union clause ast = CPX : (unit)

//union clause ast = CPY : (unit)

//union clause ast = DEC : (unit)

// union clause ast = DEX : (unit)

// union clause ast = DEY : (unit)

union clause ast = EOR_IMM   : (word)
union clause ast = EOR_ZP    : (word)
union clause ast = EOR_ZP_X  : (word)
union clause ast = EOR_ABS   : (address)
union clause ast = EOR_ABS_X : (address)
union clause ast = EOR_ABS_Y : (address)
union clause ast = EOR_IND_X : (word)
union clause ast = EOR_IND_Y : (word)
$include "./instructions/logical/instruction-execute-EOR.sail"

//union clause ast = INC : (unit)

// union clause ast = INX : (unit)

// union clause ast = INY : (unit)

//union clause ast = JMP : (unit)

//union clause ast = JSR : (unit)

//union clause ast = LDA : (unit)

//union clause ast = LDX : (unit)

//union clause ast = LDY : (unit)

// union clause ast = LSR : (unit)
// union clause ast = LSR_ZP : (word)
// union clause ast = LSR_ZP_X : (word)
// union clause ast = LSR_ABS : (address)
// union clause ast = LSR_ABS_X : (address)


// union clause ast = NOP : (unit)

union clause ast = ORA_IMM   : (word)
union clause ast = ORA_ZP    : (word)
union clause ast = ORA_ZP_X  : (word)
union clause ast = ORA_ABS   : (address)
union clause ast = ORA_ABS_X : (address)
union clause ast = ORA_ABS_Y : (address)
union clause ast = ORA_IND_X : (word)
union clause ast = ORA_IND_Y : (word)
$include "./instructions/logical/instruction-execute-ORA.sail"

// union clause ast = PHA : (unit)

// union clause ast = PHP : (unit)

// union clause ast = PLA : (unit)

// union clause ast = PLP : (unit)

// union clause ast = ROL : (unit)
// union clause ast = ROL_ZP : (word)
// union clause ast = ROL_ZP_X : (word)
// union clause ast = ROL_ABS : (address)
// union clause ast = ROL_ABS_X : (address)

// union clause ast = ROR : (unit)
// union clause ast = ROR_ZP : (word)
// union clause ast = ROR_ZP_X : (word)
// union clause ast = ROR_ABS : (address)
// union clause ast = ROR_ABS_X : (address)

// union clause ast = RTI : (unit)

// union clause ast = RTS : (unit)

//union clause ast = SBC : (unit)

// union clause ast = SEC : (unit)

// union clause ast = SED : (unit)

// union clause ast = SEI : (unit)

//union clause ast = STA : (unit)
//union clause ast = STX : (unit)
//union clause ast = STY : (unit)

// union clause ast = TAX : (unit)

// union clause ast = TAY : (unit)

// union clause ast = TSX : (unit)

// union clause ast = TXA : (unit)

// union clause ast = TXS : (unit)

// union clause ast = TYA : (unit)
