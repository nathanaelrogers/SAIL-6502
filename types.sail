type address_size : Int = 16
type address = bits(address_size)

type word_size : Int = 8
type word = bits(word_size)

type dword_size : Int = 16
type dword = bits(dword_size)

bitfield dreg : dword = {
	lower : 7..0,
	higher : 15..8
}

bitfield flags : word {
	n : 7,
	v : 6,
	b : 4,
	d : 3,
	i : 2,
	z : 1,
	c : 0
}

register PC : address
register reg_A : word
register reg_X : word
register reg_Y : word
register reg_P : flags
register reg_S : word

enum reg_enum = {
	PC,
	A,
	X,
	Y,
	P,
	S
}

register NMI : dword
register RST : dword
register IRQ : dword