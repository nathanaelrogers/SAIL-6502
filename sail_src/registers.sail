/*==============================================================================*/
// I/O STUFF

register input_buffer : word

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

register main_mem : mem_64KB

val read : (address) -> word
function read(addr) = match addr {
	x if (x == 0x8400) => {
		input_buffer;
	},
	x => {
		page_index = unsigned(addr[15..8]);
		word_index = unsigned(addr[7..0]);

		main_mem[page_index][word_index];
	}
}

val write : (address, word) -> unit
function write(addr, data) =  match addr {
	x if (x == 0x8400) => {
		print_char(unsigned(data));
	},
	x => {
		page_index = unsigned(addr[15..8]);
		word_index = unsigned(addr[7..0]);

		main_mem[page_index][word_index] = data;
	}
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

	if (unsigned(reg_SP) >= 0) then {
		incr_sp(-1)
	} else {
		reg_SP = 0xFF
	}
}

val pull : unit -> word
function pull() = {
	if (unsigned(reg_SP) <= 255) then {
		incr_sp(1)
	} else {
		reg_SP = 0x00
	};

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