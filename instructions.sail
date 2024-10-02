type regname = bits(2)
type imm = bits(8)

mapping reg_name : reg_enum <-> regname = {
	A <-> 0b00,
	X <-> 0b01,
	Y <-> 0b10,
	S <-> 0b11
}

val read_reg : regname -> word
function read_reg(r) = {
	match r {
		0b00 => reg_A,
		0b01 => reg_X,
		0b10 => reg_Y,
		0b11 => reg_S
	}
}

val write_reg : (regname, word) -> unit
function write_reg(r, w) = {
	match r {
		0b00 => reg_A = w,
		0b01 => reg_X = w,
		0b10 => reg_Y = w,
		0b11 => reg_S = w
	}
}

// Set and access flags in different method from normal read/write?

val set_flags : (bits(1), bits(1), bits(1), bits(1), bits(1), bits(1), bits(1)) -> unit
function set_flags(n, v, b, d, i, z, c) = {
	reg_P->n() = n;
	reg_P->v() = v;
	reg_P->b() = b;
	reg_P->d() = d;
	reg_P->i() = i;
	reg_P->z() = z;
	reg_P->c() = c;
}

function flag_n() : (unit) -> bits(1) = reg_P.n()
function flag_v() : (unit) -> bits(1) = reg_P.v()
function flag_b() : (unit) -> bits(1) = reg_P.b()
function flag_d() : (unit) -> bits(1) = reg_P.d()
function flag_i() : (unit) -> bits(1) = reg_P.i()
function flag_z() : (unit) -> bits(1) = reg_P.z()
function flag_c() : (unit) -> bits(1) = reg_P.c()



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

type instruction_1_byte = bits(8)
type instruction_2_byte = bits(16)
type instruction_3_byte = bits(24)
type instruction_4_byte = bits(32)

val decode08 : instruction_1_byte -> ast
val decode16 : instruction_2_byte -> ast
val decode24 : instruction_3_byte -> ast
val decode32 : instruction_4_byte -> ast

// Implied
scattered function decode08

// Immediate, Zero-Page, Relative
scattered function decode16

// Absolute, Indexed (using Zero-Page, X/Y), Indirect, Pre-Indexed Indirect, Post-Indexed Indirect
scattered function decode24

// Indexed (using Absolute, X/Y)
scattered function decode32