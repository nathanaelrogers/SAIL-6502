val EXTZ : forall 'n 'm, 'm >= 'n. (implicit('m), bits('n)) -> bits('m)
function EXTZ(m, v) = sail_zero_extend(v, m)

infix 7 >>
infix 7 <<
infix 7 >>>

overload operator <<  = {sail_shiftleft}
overload operator >>  = {sail_shiftright}
overload operator >>> = {sail_arith_shiftright}
overload operator ^   = {xor_vec}


/* some functions for converting hex numbers into the $-prefix string style of 6502 assembly language */

val hex_char_from_bits : bits(4) -> string
function hex_char_from_bits(bits) = {
	match bits {
		0b0000 => "0",
		0b0001 => "1",
		0b0010 => "2",
		0b0011 => "3",
		0b0100 => "4",
		0b0101 => "5",
		0b0110 => "6",
		0b0111 => "7",
		0b1000 => "8",
		0b1001 => "9",
		0b1010 => "A",
		0b1011 => "B",
		0b1100 => "C",
		0b1101 => "D",
		0b1110 => "E",
		0b1111 => "F"
	}
}

val my_hex_str_imm8 : bits(8) -> string
function my_hex_str_imm8(bits) = {
	concat_str("$", concat_str(hex_char_from_bits(bits[7..4]), hex_char_from_bits(bits[3..0])));
}

val my_hex_str_imm16 : bits(16) -> string
function my_hex_str_imm16(bits) = {
	concat_str("$", concat_str(concat_str(hex_char_from_bits(bits[15..12]), hex_char_from_bits(bits[11..8])), concat_str(hex_char_from_bits(bits[7..4]), hex_char_from_bits(bits[3..0]))));
}

overload my_hex_str = {my_hex_str_imm8, my_hex_str_imm16}