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
	if (last_execute == false) then incr_cycles(1);
	let PC : address = access(reg(PC_H)) @ access(reg(PC_L));
	let next_byte : word = read(PC);
	incr_pc();

	decode16(EXTZ(this) << 8 | EXTZ(next_byte));
}

/* ============== 2 byte instructions ============== */

function clause decode16(0x29 @ op : word) = {incr_cycles(1); AND_IMM(op)}
function clause decode16(0x25 @ op : word) = {incr_cycles(1); AND_ZP(op)}
function clause decode16(0x35 @ op : word) = {incr_cycles(1); AND_ZP_X(op)}
function clause decode16(0x21 @ op : word) = {incr_cycles(1); AND_IND_X(op)}
function clause decode16(0x31 @ op : word) = {incr_cycles(1); AND_IND_Y(op)}

function clause decode16(0x49 @ op : word) = {incr_cycles(1); EOR_IMM(op)}
function clause decode16(0x45 @ op : word) = {incr_cycles(1); EOR_ZP(op)}
function clause decode16(0x55 @ op : word) = {incr_cycles(1); EOR_ZP_X(op)}
function clause decode16(0x41 @ op : word) = {incr_cycles(1); EOR_IND_X(op)}
function clause decode16(0x51 @ op : word) = {incr_cycles(1); EOR_IND_Y(op)}

function clause decode16(0x09 @ op : word) = {incr_cycles(1); ORA_IMM(op)}
function clause decode16(0x05 @ op : word) = {incr_cycles(1); ORA_ZP(op)}
function clause decode16(0x15 @ op : word) = {incr_cycles(1); ORA_ZP_X(op)}
function clause decode16(0x01 @ op : word) = {incr_cycles(1); ORA_IND_X(op)}
function clause decode16(0x11 @ op : word) = {incr_cycles(1); ORA_IND_Y(op)}

// If it's not a valid 2 byte instruction, read another byte and try decode.
function clause decode16(this) = {
	incr_cycles(1);
	let PC : address = access(reg(PC_H)) @ access(reg(PC_L));
	let next_byte : word = read(PC);
	incr_pc();

	decode24(EXTZ(this) << 8 | EXTZ(next_byte));
}

/* ============== 3 byte instructions ============== */

function clause decode24(0x2D @ op : address) = {incr_cycles(1); AND_ABS(op)}
function clause decode24(0x3D @ op : address) = {incr_cycles(1); AND_ABS_X(op)}
function clause decode24(0x39 @ op : address) = {incr_cycles(1); AND_ABS_Y(op)}

function clause decode24(0x4D @ op : address) = {incr_cycles(1); EOR_ABS(op)}
function clause decode24(0x5D @ op : address) = {incr_cycles(1); EOR_ABS_X(op)}
function clause decode24(0x59 @ op : address) = {incr_cycles(1); EOR_ABS_Y(op)}

function clause decode24(0x0D @ op : address) = {incr_cycles(1); ORA_ABS(op)}
function clause decode24(0x1D @ op : address) = {incr_cycles(1); ORA_ABS_X(op)}
function clause decode24(0x19 @ op : address) = {incr_cycles(1); ORA_ABS_Y(op)}

// Catch an invalid instruction
union clause ast = INVALID : (bits(24))
function clause decode24(instruction) = {incr_cycles(1); INVALID(instruction)}
function clause execute(INVALID(instruction)) = false