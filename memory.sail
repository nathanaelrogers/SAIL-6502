register main_mem : mem_64KB = vector_init(256, vector_init(256, undefined))

val read : address -> word
function read(addr) = {
	page_index = unsigned(addr[15..8]);
	word_index = unsigned(addr[7..0]);

	main_mem[page_index][word_index];
}

val write : (address, word) -> unit
function write(addr, data) = {
	page_index = unsigned(addr[15..8]);
	word_index = unsigned(addr[7..0]);

	main_mem[page_index][word_index] = data
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
	incr_cycles(1);

	write(0x01 @ reg_SP, data);

	if (unsigned(reg_SP) >= 0) then {
		incr_sp(-1)
	} else {
		reg_SP = 0xFF
	}
}

val pull : unit -> word
function pull() = {
	incr_cycles(1);

	if (unsigned(reg_SP) <= 255) then {
		incr_sp(1)
	} else {
		reg_SP = 0x00
	};

	read(0x01 @ reg_SP);
}