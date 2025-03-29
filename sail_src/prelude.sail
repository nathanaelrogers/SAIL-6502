// Use Sail backend zero extension and sign extension
val EXTZ : forall 'n 'm, 'm >= 'n. (implicit('m), bits('n)) -> bits('m)
function EXTZ(m, v) = sail_zero_extend(v, m)

val EXTS : forall 'n 'm, 'm >= 'n. (implicit('m), bits('n)) -> bits('m)
function EXTS(m, v) = sail_sign_extend(v, m)

infix 7 >>
infix 7 <<
infix 7 >>>

// Use sail backend for operators
overload operator <<  = {sail_shiftleft}
overload operator >>  = {sail_shiftright}
overload operator >>> = {sail_arith_shiftright}
overload operator ^   = {xor_vec}
overload operator /   = {fdiv_int}
overload operator %   = {fmod_int}
overload operator -   = {sub_bits}


/* some functions for converting hex numbers into the $-prefix string style of 6502 assembly language */
val hex_char_from_bits : bits(4) -> string
function hex_char_from_bits(bits) = {
	match bits {
		0x0 => "0",
		0x1 => "1",
		0x2 => "2",
		0x3 => "3",
		0x4 => "4",
		0x5 => "5",
		0x6 => "6",
		0x7 => "7",
		0x8 => "8",
		0x9 => "9",
		0xA => "A",
		0xB => "B",
		0xC => "C",
		0xD => "D",
		0xE => "E",
		0xF => "F"
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

/* External C Functions */

val terminal_init = pure {
	c : "terminal_init"
} : (unit) -> unit

val memory_init = pure {
	c : "memory_init"
} : (unit) -> unit

val mem_read = pure {
	c : "mem_read"
} : (int) -> word

val mem_write = pure {
	c : "mem_write"
} : (int, int) -> unit

val load_binary = pure {
	c : "load_binary"
} : (string, int) -> unit

val consume_input = pure {
	c : "consume_input"
} : (unit) -> unit

val get_nmi = pure {
	c : "get_nmi"
} : (unit) -> bits(1)

val get_rst = pure {
	c : "get_rst"
} : (unit) -> bits(1)

val get_irq = pure {
	c : "get_irq"
} : (unit) -> bits(1)
