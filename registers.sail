type regnum = bits(3)

register reg_PC : address
register reg_A  : word
register reg_X  : word
register reg_Y  : word
register reg_SR : flags
register reg_SP : word

enum reg_enum = {
	PCH,
	PCL,
	A,
	X,
	Y,
	SR,
	SP
}

// functions for reading and writing to registers
mapping reg : reg_enum <-> regnum = {
	PCH  <-> 0b000,
	PCL  <-> 0b001,
	A    <-> 0b010,
	X    <-> 0b011,
	Y    <-> 0b100,
	SR   <-> 0b101,
	SP   <-> 0b110
}

val read_register : regnum -> word
function read_register(regnum) = {
	match regnum {
		reg(PCH)  => reg_PC[15..8],
		reg(PCL)  => reg_PC[7..0],
		reg(A)    => reg_A,
		reg(X)    => reg_X,
		reg(Y)    => reg_Y,
		reg(SR)   => reg_SR[all],
		reg(SP)   => reg_SP
	}
}

val write_register : (regnum, word) -> unit
function write_register(regnum, word) = {
	match regnum {
		reg(PCH)  => reg_PC[15..8] = word,
		reg(PCL)  => reg_PC[7..0] = word,
		reg(A)    => reg_A = word,
		reg(X)    => reg_X = word,
		reg(Y)    => reg_Y = word,
		reg(SR)   => reg_SR[all] = word,
		reg(SP)   => reg_SP = word
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