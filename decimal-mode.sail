mapping nibbleint : int <-> bits(4) = {
	0 <-> 0x0,
	1 <-> 0x1,
	2 <-> 0x2,
	3 <-> 0x3,
	4 <-> 0x4,
	5 <-> 0x5,
	6 <-> 0x6,
	7 <-> 0x7,
	8 <-> 0x8,
	9 <-> 0x9
}

val word_to_dec : word -> int
function word_to_dec(word) = {
	(nibbleint(word[7..4]) * 10) + nibbleint(word[3..0])
}

val dec_to_word : int -> word
function dec_to_word(op) = {
	nibbleint((op % 100) / 10) @ nibbleint(op % 10)
}

val dec_sub : (int, int, int) -> int
function dec_sub(op1, op2, op3)	 = {
	op1 - op2 - op3
}

val dec_add : (int, int, int) -> int
function dec_add(op1, op2, op3)	 = {
	op1 + op2 + op3
}