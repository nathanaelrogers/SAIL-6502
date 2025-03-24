/*==============================================================================*/
// I/O STUFF

register halt         : bool
register test_assert  : bool
register input_buffer : word
register control_reg  : word

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
function read(addr) = match addr {
	x if (x == 0x8400) => {
		if (input_buffer == 0x00) then {
			0x00;
		} else {
			let next : word = input_buffer;
			input_buffer = 0x00;
			next;
		};
	},
	x if (x == 0x8401) => {
		if (input_buffer == 0x00) then 0x00 else 0x08;
	},
	x => {
		mem_read(unsigned(addr));
	}
}

val write : (address, word) -> unit
function write(addr, data) =  match addr {
	x if (x == 0x8400) => {
		print_char(unsigned(data));
	},
	x if (x == 0x8401 | x == 0x8402 | x == 0x8403) => {
		();
	},
	x if (x == 0x8040) => {
		halt = true;
	},
	x if (x == 0x8010) => {
		test_assert = true;
	},
	x => {
		mem_write(unsigned(addr), unsigned(data));
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