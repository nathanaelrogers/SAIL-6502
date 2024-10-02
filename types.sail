type word_size : Int = 8
type word = bits(word_size)

type dword_size : Int = 16
type dword = bits(dword_size)

type interrupt_line : bits(1)

type address_size : Int = 16
type address = bits(address_size)

bitfield flags : word = {
	n : 7,
	v : 6,
	b : 4,
	d : 3,
	i : 2,
	z : 1,
	c : 0
}

bitfield dreg: dword = {
	lower: 7..0,
	higher: 15..8
}

// Separate programmer accessible registers and non-accessible?
register PC : dword
register reg_A : word
register reg_X : word
register reg_Y : word
register reg_SR : flags
register reg_SP : word


val NMI : interrupt_line
val NMI_vec : address = 0xFFFA

val RES : interrupt_line
val RES_vec : address = 0xFFFC

val IRQ : interrupt_line
val IRQ_vec: address = 0xFFFE