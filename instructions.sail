type instruction_one_byte = bits(8)
type instruction_two_byte = bits(16)
type instruction_tri_byte = bits(24)

scattered union ast

val decode08 : (instruction_one_byte, bool) -> ast
scattered function decode08

val decode16 : instruction_two_byte -> ast
scattered function decode16

val decode24 : instruction_tri_byte -> ast
scattered function decode24

overload decode = {decode08, decode16, decode24}

val execute : ast -> bool
scattered function execute

val assembly : ast -> string
scattered function assembly

/* ===== ABSTRACT SYNTAX TREE ===== */

// union clause ast = ADC_IMM : (word)
// union clause ast = ADC_ZP : (word)
// union clause ast = ADC_ZP_X : (word)
// union clause ast = ADC_ABS : (address)
// union clause ast = ADC_ABS_X : (address)
// union clause ast = ADC_ABS_Y : (address)
// union clause ast = ADC_IND_X : (word)
// union clause ast = ADC_IND_Y : (word)

union clause ast = AND_IMM : (word)
union clause ast = AND_ZP : (word)
union clause ast = AND_ZP_X : (word)
union clause ast = AND_ABS : (address)
union clause ast = AND_ABS_X : (address)
union clause ast = AND_ABS_Y : (address)
union clause ast = AND_IND_X : (word)
union clause ast = AND_IND_Y : (word)


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

//union clause ast = EOR : (unit)

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

//union clause ast = ORA : (unit)

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

/* ===== DECODE ===== */

/* 1 byte instructions */
// function clause decode08(0x00) = BRK()
// function clause decode08(0x40) = RTI()
// function clause decode08(0x60) = RTS()
// function clause decode08(0x08) = PHP()
// function clause decode08(0x18) = CLC()
// function clause decode08(0x28) = PLP()
// function clause decode08(0x38) = SEC()
// function clause decode08(0x48) = PHA()
// function clause decode08(0x58) = CLI()
// function clause decode08(0x68) = PLA()
// function clause decode08(0x78) = SEI()
// function clause decode08(0x88) = DEY()
// function clause decode08(0x98) = TYA()
// function clause decode08(0xA8) = TAY()
// function clause decode08(0xB8) = CLV()
// function clause decode08(0xC8) = INY()
// function clause decode08(0xD8) = CLD()
// function clause decode08(0xE8) = INX()
// function clause decode08(0xF8) = SED()
// function clause decode08(0x0A) = ASL()
// function clause decode08(0x2A) = ROL()
// function clause decode08(0x4A) = LSR()
// function clause decode08(0x6A) = ROR()
// function clause decode08(0x8A) = TXA()
// function clause decode08(0x9A) = TXS()
// function clause decode08(0xAA) = TAX()
// function clause decode08(0xBA) = TSX()
// function clause decode08(0xCA) = DEX()
// function clause decode08(0xEA) = NOP()

// If it's not a valid single byte instruction, read another byte and try decode.
function clause decode08(this, last_execute) = {
	if (last_execute == false) then incr_cycles();
	let PC : address = reg(name(PC_H)) @ reg(name(PC_L));
	let next_byte : word = read(PC);
	incr_pc();

	decode16(EXTZ(this) << 8 | EXTZ(next_byte));
}

/* 2 byte instructions */
// function clause decode16(0x69 @ op : word) = ADC_IMM(op)
// function clause decode16(0x65 @ op : word) = ADC_ZP(op)
// function clause decode16(0x75 @ op : word) = ADC_ZP_X(op)
// function clause decode16(0x61 @ op : word) = ADC_IND_X(op)
// function clause decode16(0x71 @ op : word) = ADC_IND_Y(op)

function clause decode16(0x29 @ op : word) = {incr_cycles(); AND_IMM(op)}
function clause decode16(0x25 @ op : word) = {incr_cycles(); AND_ZP(op)}
function clause decode16(0x35 @ op : word) = {incr_cycles(); AND_ZP_X(op)}
function clause decode16(0x21 @ op : word) = {incr_cycles(); AND_IND_X(op)}
function clause decode16(0x31 @ op : word) = {incr_cycles(); AND_IND_Y(op)}

// function clause decode16(0x06 @ op : word) = ASL_ZP(op)
// function clause decode16(0x16 @ op : word) = ASL_ZP_X(op)

// If it's not a valid 2 byte instruction, read another byte and try decode.
function clause decode16(this) = {
	incr_cycles();
	let PC : address = reg(name(PC_H)) @ reg(name(PC_L));
	let next_byte : word = read(PC);
	incr_pc();

	decode24(EXTZ(this) << 8 | EXTZ(next_byte));
}

/* 3 byte instructions */
// function clause decode24(0x6D @ op : address) = ADC_ABS(op)
// function clause decode24(0x7D @ op : address) = ADC_ABS_X(op)
// function clause decode24(0x79 @ op : address) = ADC_ABS_Y(op)

function clause decode24(0x2D @ op : address) = {incr_cycles(); AND_ABS(op)}
function clause decode24(0x3D @ op : address) = {incr_cycles(); AND_ABS_X(op)}
function clause decode24(0x39 @ op : address) = {incr_cycles(); AND_ABS_Y(op)}

// function clause decode24(0x0E @ op : address) = ASL_ABS(op)
// function clause decode24(0x1E @ op : address) = ASL_ABS_X(op)

union clause ast = INVALID : (bits(24))
function clause decode24(instruction) = {incr_cycles(); INVALID(instruction)}
function clause assembly(INVALID(instruction)) = concat_str("Invalid instruction: ", bits_str(instruction))
function clause execute(INVALID(instruction)) = false

/* ===== LOGICAL INSTRUCTIONS ===== */

// No memory access, AND the A register with immediate value.
function clause assembly(AND_IMM(op)) = concat_str("AND ", concat_str("#", my_hex_str(op)))
function clause execute(AND_IMM(op)) = {
	let result = reg(name(A)) & op;
	incr_cycles();
	reg(name(A)) = result;
	true
}
// No address calculation needed, zero-page memory access with provided word.
function clause assembly(AND_ZP(op)) = concat_str("AND ", my_hex_str(op))
function clause execute(AND_ZP(op)) = {
	let result = reg(name(A)) & read(op);
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Effective address affects the low byte only (overflow wraps around inside zero-page).
function clause assembly(AND_ZP_X(op)) = concat_str("AND ", concat_str(my_hex_str(op), ",X"))
function clause execute(AND_ZP_X(op)) = {
	let ea = op + reg(name(X));
	let result = reg(name(A)) & read(ea);
	incr_cycles();
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// No address calculation needed, memory access with provided address.
function clause assembly(AND_ABS(op)) = concat_str("AND ", my_hex_str(op))
function clause execute(AND_ABS(op)) = {
	let result = reg(name(A)) & read(op);
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Address calculation may affect the high byte (16 bit address plus X).
function clause assembly(AND_ABS_X(op)) = concat_str("AND ", concat_str(my_hex_str(op), ",X"))
function clause execute(AND_ABS_X(op)) = {
	let ea = op + EXTZ(16, reg(name(X)));
	let result = reg(name(A)) & read(ea);
	if (op[15..8] != ea[15..8]) then {incr_cycles(); print_bits("page boundary crossed, now in page: ", ea[15..8])};
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Address calculation may affect the high byte (16 bit address plus Y).
function clause assembly(AND_ABS_Y(op)) = concat_str("AND ", concat_str(my_hex_str(op), ",Y"))
function clause execute(AND_ABS_Y(op)) = {
	let ea = op + EXTZ(16, reg(name(Y)));
	let result = reg(name(A)) & read(ea);
	if (op[15..8] != ea[15..8]) then {incr_cycles(); print_bits("page boundary crossed, now in page: ", ea[15..8])};
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Address calculation effects the low byte only. Memory at effective address holds a pointer to data (LLHH).
function clause assembly(AND_IND_X(op)) = concat_str("AND ", concat_str(concat_str("(", my_hex_str(op)), ",X)"))
function clause execute(AND_IND_X(op)) = {
	let ea = op + reg(name(X));
	let pointer = read(ea + 1) @ read(ea);
	let result = reg(name(A)) & read(pointer);
	incr_cycles();
	incr_cycles();
	incr_cycles();
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}
// Operand gives location (in zero-page) of pointer to data (LLHH). Address calculation comes AFTER and may affect the high byte.
function clause assembly(AND_IND_Y(op)) = concat_str("AND ", concat_str(concat_str("(", my_hex_str(op)), "),Y"))
function clause execute(AND_IND_Y(op)) = {
	let pointer = read(op + 1) @ read(op);
	let ea = pointer + EXTZ(16, reg(name(Y)));
	if (pointer[15..8] != ea[15..8]) then {incr_cycles(); print_bits("page boundary crossed, now in page: ", ea[15..8])};
	let result = reg(name(A)) & read(ea);
	incr_cycles();
	incr_cycles();
	incr_cycles();
	incr_cycles();
	reg(name(A)) = result;
	true
}