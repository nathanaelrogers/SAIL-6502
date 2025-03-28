/*==============================================================================*/
// PROCESSOR REGISTERS

register reg_PC : address
register reg_A  : word
register reg_X  : word
register reg_Y  : word
register reg_SR : flags
register reg_SP : word

val incr_pc : int -> unit
function incr_pc(n) = {
	reg_PC = reg_PC + n
}

val incr_sp : int -> unit
function incr_sp(n) = {
	reg_SP = reg_SP + n
}

/*==============================================================================*/
// MAIN MEMORY

val read : (address) -> word
function read(addr) = {
	mem_read(unsigned(addr));
}

val write : (address, word) -> unit
function write(addr, data) = {
	mem_write(unsigned(addr), unsigned(data));
}

val read_zp : word -> word
function read_zp(addr) = {
	read(0x00 @ addr);
}

val write_zp : (word, word) -> unit
function write_zp(addr, data) = {
	write(0x00 @ addr, data);
}

val push : word -> unit
function push(data) = {
	write(0x01 @ reg_SP, data);
	incr_sp(-1);

}

val pull : unit -> word
function pull() = {
	incr_sp(1);
	read(0x01 @ reg_SP);
}

/*==============================================================================*/
// CYCLE AND INSTRUCTION COUNT

register cycles : int
register instructions_done : int

val incr_cycles : int -> unit
function incr_cycles(n) = {
	cycles = cycles + n;
}