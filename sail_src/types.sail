type word = bits(8)
type address = bits(16)
type mem_64KB = vector(256, vector(256, word))

bitfield flags : word = {
	all : 7..0,
	n : 7,
	v : 6,
	X : 5,
	b : 4,
	d : 3,
	i : 2,
	z : 1,
	c : 0,
}