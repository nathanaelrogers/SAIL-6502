val nibble_to_int : bits(4) -> int
function nibble_to_int(nibble) = {
	match nibble {
		0x0 => 0,
		0x1 => 1,
		0x2 => 2,
		0x3 => 3,
		0x4 => 4,
		0x5 => 5,
		0x6 => 6,
		0x7 => 7,
		0x8 => 8,
		0x9 => 9,
		_   => undefined
	}
}

val int_to_nibble : int -> bits(4)
function int_to_nibble(n) = {
	match n {
		0 => 0x0,
		1 => 0x1,
		2 => 0x2,
		3 => 0x3,
		4 => 0x4,
		5 => 0x5,
		6 => 0x6,
		7 => 0x7,
		8 => 0x8,
		9 => 0x9,
		_ => undefined
	}
}

val word_to_decimal : word -> int
function word_to_decimal(word) = {
	(nibble_to_int(word[7..4]) * 10) + nibble_to_int(word[3..0])
}

val decimal_to_word : int -> word
function decimal_to_word(op) = {
	let n : int = if (n > 99) then op % 100 else op;
 int_to_nibble(n / 10) @ int_to_nibble(n % 10)
}

val decimal_add : (word, word) -> int
function decimal_add(op1, op2) = {
	word_to_decimal(op1) + word_to_decimal(op2)
}
