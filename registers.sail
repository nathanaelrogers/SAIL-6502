type regnum = bits(3)

register reg_PC : address
register reg_A  : word
register reg_X  : word
register reg_Y  : word
register reg_SR : flags
register reg_SP : word

enum reg_enum = {
	PC_H,
	PC_L,
	A,
	X,
	Y,
	SR,
	SP
}

// functions for reading and writing to registers
mapping name : reg_enum <-> regnum = {
	PC_H <-> 0b000,
	PC_L <-> 0b001,
	A    <-> 0b010,
	X    <-> 0b011,
	Y    <-> 0b100,
	SR   <-> 0b101,
	SP   <-> 0b110
}

val read_register : regnum -> word
function read_register(r) = {
	match r {
		0b000 => reg_PC[15..8],
		0b001 => reg_PC[7..0],
		0b010 => reg_A,
		0b011 => reg_X,
		0b100 => reg_Y,
		0b101 => reg_SR[all],
		0b110 => reg_SP
	}
}

val write_register : (regnum, word) -> unit
function write_register(r, word) = {
	match r {
		0b000 => reg_PC[15..8] = word,
		0b001 => reg_PC[7..0] = word,
		0b010 => reg_A = word,
		0b011 => reg_X = word,
		0b100 => reg_Y = word,
		0b101 => reg_SR[all] = word,
		0b110 => reg_SP = word
	}
}

overload access = {read_register, write_register}

// Helper function to increment the PC.
val incr_pc : unit -> unit
function incr_pc(unit) = {
	reg_PC = reg_PC + 1;
}

// Helper functions to set individual flags.
function set_flag_n(bit) : bits(1) -> unit = {reg_SR[n] = bit}
function set_flag_v(bit) : bits(1) -> unit = {reg_SR[v] = bit}
function set_flag_b(bit) : bits(1) -> unit = {reg_SR[b] = bit}
function set_flag_d(bit) : bits(1) -> unit = {reg_SR[d] = bit}
function set_flag_i(bit) : bits(1) -> unit = {reg_SR[i] = bit}
function set_flag_z(bit) : bits(1) -> unit = {reg_SR[z] = bit}
function set_flag_c(bit) : bits(1) -> unit = {reg_SR[c] = bit}

// Helper functions to read individual flags.
function flag_n() : unit -> bits(1) = reg_SR[n]
function flag_v() : unit -> bits(1) = reg_SR[v]
function flag_b() : unit -> bits(1) = reg_SR[b]
function flag_d() : unit -> bits(1) = reg_SR[d]
function flag_i() : unit -> bits(1) = reg_SR[i]
function flag_z() : unit -> bits(1) = reg_SR[z]
function flag_c() : unit -> bits(1) = reg_SR[c]