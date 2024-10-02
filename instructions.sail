// ast of all instructions (needs useful return? parameter? type)

scattered union ast

union clause ast = ADC : (unit)
union clause ast = AND : (unit)
union clause ast = ASL : (unit)
union clause ast = BCC : (unit)
union clause ast = BCS : (unit)
union clause ast = BEQ : (unit)
union clause ast = BIT : (unit)
union clause ast = BMI : (unit)
union clause ast = BNE : (unit)
union clause ast = BPL : (unit)
union clause ast = BRK : (unit)
union clause ast = BVC : (unit)
union clause ast = BVS : (unit)
union clause ast = CLC : (unit)
union clause ast = CLD : (unit)
union clause ast = CLI : (unit)
union clause ast = CLV : (unit)
union clause ast = CMP : (unit)
union clause ast = CPX : (unit)
union clause ast = CPY : (unit)
union clause ast = DEC : (unit)
union clause ast = DEX : (unit)
union clause ast = DEY : (unit)
union clause ast = EOR : (unit)
union clause ast = INC : (unit)
union clause ast = INX : (unit)
union clause ast = INY : (unit)
union clause ast = JMP : (unit)
union clause ast = JSR : (unit)
union clause ast = LDA : (unit)
union clause ast = LDX : (unit)
union clause ast = LDY : (unit)
union clause ast = LSR : (unit)
union clause ast = NOP : (unit)
union clause ast = ORA : (unit)
union clause ast = PHA : (unit)
union clause ast = PHP : (unit)
union clause ast = PLA : (unit)
union clause ast = PLP : (unit)
union clause ast = ROL : (unit)
union clause ast = ROR : (unit)
union clause ast = RTI : (unit)
union clause ast = RTS : (unit)
union clause ast = SBC : (unit)
union clause ast = SEC : (unit)
union clause ast = SED : (unit)
union clause ast = SEI : (unit)
union clause ast = STA : (unit)
union clause ast = STX : (unit)
union clause ast = STY : (unit)
union clause ast = TAX : (unit)
union clause ast = TAY : (unit)
union clause ast = TSX : (unit)
union clause ast = TXA : (unit)
union clause ast = TXS : (unit)
union clause ast = TYA : (unit)

type instruction_one_byte = bits(8)
type instruction_two_byte = bits(16)
type instruction_tri_byte = bits(24)

val decode08 : instruction_one_byte -> ast
val decode16 : instruction_two_byte -> ast
val decode24 : instruction_tri_byte -> ast

// Implied
scattered function decode08

// Immediate, Zero-Page, Relative, Indexed (using Zero-Page, X/Y)
scattered function decode16

// Absolute, Indexed (using Absolute, X/Y), Indirect (all types)
scattered function decode24
