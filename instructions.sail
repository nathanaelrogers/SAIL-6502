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

// 1 byte instructions
scattered function decode08

function clause decode08(0b0000 @ 0b0000) // $00
	= BRK()
function clause decode08(0b0100 @ 0b0000) // $40
	= RTI()
function clause decode08(0b0110 @ 0b0000) // $60
	= RTS()
function clause decode08(0b0000 @ 0b1000) // $08
	= PHP()

function clause decode08(0b0001 @ 0b1000) // $18
	= CLC()
function clause decode08(0b0010 @ 0b1000) // $28
	= PLP()
function clause decode08(0b0011 @ 0b1000) // $38
	= SEC()
function clause decode08(0b0100 @ 0b1000) // $48
	= PHA()
function clause decode08(0b0101 @ 0b1000) // $58
	= CLI()
function clause decode08(0b0110 @ 0b1000) // $68
	= PLA()
function clause decode08(0b0111 @ 0b1000) // $78
	= SEI()
function clause decode08(0b1000 @ 0b1000) // $88
	= DEY()
function clause decode08(0b1001 @ 0b1000) // $98
	= TYA()
function clause decode08(0b1010 @ 0b1000) // $A8
	= TAY()
function clause decode08(0b1011 @ 0b1000) // $B8
	= CLV()
function clause decode08(0b1100 @ 0b1000) // $C8
	= INY()
function clause decode08(0b1101 @ 0b1000) // $D8
	= CLD()
function clause decode08(0b1110 @ 0b1000) // $E8
	= INX()
function clause decode08(0b1111 @ 0b1000) // $F8
	= SED()

function clause decode08(0b0000 @ 0b1010) // $0A
	= ASL()
function clause decode08(0b0010 @ 0b1010) // $2A
	= ROL()
function clause decode08(0b0100 @ 0b1010) // $4A
	= LSR()
function clause decode08(0b0110 @ 0b1010) // $6A
	= ROR()
function clause decode08(0b1000 @ 0b1010) // $8A
	= TXA()
function clause decode08(0b1001 @ 0b1010) // $9A
	= TXS()
function clause decode08(0b1010 @ 0b1010) // $AA
	= TAX()
function clause decode08(0b1011 @ 0b1010) // $BA
	= TSX()
function clause decode08(0b1100 @ 0b1010) // $CA
	= DEX()
function clause decode08(0b1110 @ 0b1010) // $EA
	= NOP()

// Immediate, Zero-Page, Relative, Indexed (using Zero-Page, X/Y)
scattered function decode16

// Absolute, Indexed (using Absolute, X/Y), Indirect (all types)
scattered function decode24
