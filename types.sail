type word_size : Int = 8
type word = bits(word_size)

type address_size : Int = 16
type address = bits(address_size)

type interrupt_line = bits(1)

type page_size_word : Int = 256
type page_256B = vector(page_size_word, word)

type mem_size_page : Int = 256
type mem_64KB = vector(mem_size_page, page_256B)

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