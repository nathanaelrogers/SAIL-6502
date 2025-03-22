mapping bcd_pack : int <-> bits(4) = {
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

val nibble_to_int : (bits(4)) -> int
function nibble_to_int(nibble) = match unsigned(nibble) {
	x if ((x >= 0) & (x <= 9)) => bcd_pack(nibble),
	x                          => undefined
}

val int_to_nibble : (int) -> bits(4)
function int_to_nibble(num) = match num {
	x if ((x >= 0) & (x <= 9)) => bcd_pack(num),
	x                          => undefined
}

val word_to_dec : word -> int
function word_to_dec(word) = {
	(nibble_to_int(word[7..4]) * 10) + nibble_to_int(word[3..0])
}

val dec_to_word : int -> word
function dec_to_word(op) = {
	int_to_nibble((op % 100) / 10) @ int_to_nibble(op % 10)
}

val dec_sub : (int, int, int) -> int
function dec_sub(op1, op2, op3)	 = {
	op1 - op2 - op3
}

val dec_add : (int, int, int) -> int
function dec_add(op1, op2, op3)	 = {
	op1 + op2 + op3
}