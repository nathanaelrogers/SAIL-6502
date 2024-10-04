val EXTZ : forall 'n 'm, 'm >= 'n. (implicit('m), bits('n)) -> bits('m)
function EXTZ(m, v) = sail_zero_extend(v, m)

val nibble_to_hex_char : bits(4) -> string
function nibble_to_hex_char(bits) = {
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

val hex_str_6502_imm8 : bits(8) -> string
function hex_str_6502_imm8(bits) = {
	concat_str("$", concat_str(nibble_to_hex_char(bits[7..4]), nibble_to_hex_char(bits[3..0])));
}

val hex_str_6502_imm16 : bits(16) -> string
function hex_str_6502_imm16(bits) = {
	concat_str("$", concat_str(concat_str(nibble_to_hex_char(bits[15..12]), nibble_to_hex_char(bits[11..8])), concat_str(nibble_to_hex_char(bits[7..4]), nibble_to_hex_char(bits[3..0]))));
}

overload my_hex_str = {hex_str_6502_imm8, hex_str_6502_imm16}