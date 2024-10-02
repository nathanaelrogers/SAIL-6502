type word_size : Int = 8
type word = bits(word_size)

type dword_size : Int = 16
type dword = bits(dword_size)

type interrupt_line = bits(1)

type address_size : Int = 16
type address = bits(address_size)

bitfield flags : word = {
	all : 7..0,
	n : 7,
	v : 6,
	b : 4,
	d : 3,
	i : 2,
	z : 1,
	c : 0,
}

bitfield large_reg : dword = {
	higher: 15..8,
	lower: 7..0
}

// Separate programmer accessible registers and non-accessible?
register reg_PC : large_reg
register reg_A : word
register reg_X : word
register reg_Y : word
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

let NMI : interrupt_line = 0b0
let NMI_vec : address = 0xFFFA

let RES : interrupt_line = 0b0
let RES_vec : address = 0xFFFC

let IRQ : interrupt_line = 0b0
let IRQ_vec : address = 0xFFFE