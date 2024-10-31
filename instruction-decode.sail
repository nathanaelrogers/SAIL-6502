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



/* =============== ABSTRACT SYNTAX TREE ============ */
/*                                                   */
/*                                                   */
/*                                                   */
/* ================================================= */

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
$include "./instructions/logical/AND.sail"


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
// $include "./instructions/logical/EOR.sail"

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
// $include "./instructions/logical/ORA.sail"

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


/* ===================== DECODE ==================== */
/*                                                   */
/*                                                   */
/*                                                   */
/* ================================================= */


/* ============== 1 byte instructions ============== */

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
	let PC : address = access(name(PC_H)) @ access(name(PC_L));
	let next_byte : word = read(PC);
	incr_pc();

	decode16(EXTZ(this) << 8 | EXTZ(next_byte));
}

/* ============== 2 byte instructions ============== */

function clause decode16(0x29 @ op : word) = {incr_cycles(); AND_IMM(op)}
function clause decode16(0x25 @ op : word) = {incr_cycles(); AND_ZP(op)}
function clause decode16(0x35 @ op : word) = {incr_cycles(); AND_ZP_X(op)}
function clause decode16(0x21 @ op : word) = {incr_cycles(); AND_IND_X(op)}
function clause decode16(0x31 @ op : word) = {incr_cycles(); AND_IND_Y(op)}

function clause decode16(0x49 @ op : word) = {incr_cycles(); EOR_IMM(op)}
function clause decode16(0x45 @ op : word) = {incr_cycles(); EOR_ZP(op)}
function clause decode16(0x55 @ op : word) = {incr_cycles(); EOR_ZP_X(op)}
function clause decode16(0x41 @ op : word) = {incr_cycles(); EOR_IND_X(op)}
function clause decode16(0x51 @ op : word) = {incr_cycles(); EOR_IND_Y(op)}

function clause decode16(0x09 @ op : word) = {incr_cycles(); ORA_IMM(op)}
function clause decode16(0x05 @ op : word) = {incr_cycles(); ORA_ZP(op)}
function clause decode16(0x15 @ op : word) = {incr_cycles(); ORA_ZP_X(op)}
function clause decode16(0x01 @ op : word) = {incr_cycles(); ORA_IND_X(op)}
function clause decode16(0x11 @ op : word) = {incr_cycles(); ORA_IND_Y(op)}

// If it's not a valid 2 byte instruction, read another byte and try decode.
function clause decode16(this) = {
	incr_cycles();
	let PC : address = access(name(PC_H)) @ access(name(PC_L));
	let next_byte : word = read(PC);
	incr_pc();

	decode24(EXTZ(this) << 8 | EXTZ(next_byte));
}

/* ============== 3 byte instructions ============== */

function clause decode24(0x2D @ op : address) = {incr_cycles(); AND_ABS(op)}
function clause decode24(0x3D @ op : address) = {incr_cycles(); AND_ABS_X(op)}
function clause decode24(0x39 @ op : address) = {incr_cycles(); AND_ABS_Y(op)}

function clause decode24(0x4D @ op : address) = {incr_cycles(); EOR_ABS(op)}
function clause decode24(0x5D @ op : address) = {incr_cycles(); EOR_ABS_X(op)}
function clause decode24(0x59 @ op : address) = {incr_cycles(); EOR_ABS_Y(op)}

function clause decode24(0x0D @ op : address) = {incr_cycles(); ORA_ABS(op)}
function clause decode24(0x1D @ op : address) = {incr_cycles(); ORA_ABS_X(op)}
function clause decode24(0x19 @ op : address) = {incr_cycles(); ORA_ABS_Y(op)}

// Catch an invalid instruction
union clause ast = INVALID : (bits(24))
function clause decode24(instruction) = {incr_cycles(); INVALID(instruction)}
function clause execute(INVALID(instruction)) = false