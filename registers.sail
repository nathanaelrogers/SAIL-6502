type regnum = bits(3)

register reg_PC : address
register reg_A  : word
register reg_X  : word
register reg_Y  : word
register reg_SR : flags
register reg_SP : word

enum reg_enum = {
	PC_H,
	PC_L,
	A,
	X,
	Y,
	SR,
	SP
}

// functions for reading and writing to registers
mapping name : reg_enum <-> regnum = {
	PC_H <-> 0b000,
	PC_L <-> 0b001,
	A    <-> 0b010,
	X    <-> 0b011,
	Y    <-> 0b100,
	SR   <-> 0b101,
	SP   <-> 0b110
}

val read_register : regnum -> word
function read_register(r) = {
	match r {
		0b000 => reg_PC[15..8],
		0b001 => reg_PC[7..0],
		0b010 => reg_A,
		0b011 => reg_X,
		0b100 => reg_Y,
		0b101 => reg_SR[all],
		0b110 => reg_SP
	}
}

val write_register : (regnum, word) -> unit
function write_register(r, word) = {
	match r {
		0b000 => reg_PC[15..8] = word,
		0b001 => reg_PC[7..0] = word,
		0b010 => reg_A = word,
		0b011 => reg_X = word,
		0b100 => reg_Y = word,
		0b101 => reg_SR[all] = word,
		0b110 => reg_SP = word
	}
}

overload reg = {read_register, write_register}

// interrupt lines initialised to 1 since they are active LOW not high
// register NMI : interrupt_line = 0b1
// let NMI_vec : address = 0xFFFA

// register RES : interrupt_line = 0b1
// let RES_vec : address = 0xFFFC

// register IRQ : interrupt_line = 0b1
// let IRQ_vec : address = 0xFFFE