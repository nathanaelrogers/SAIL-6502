register main_mem : mem_64KB = vector_init(256, vector_init(256, undefined))

val read_memory : address -> word
function read_memory(addr) = {
	page_index = unsigned(addr[15..8]);
	word_index = unsigned(addr[7..0]);

	main_mem[page_index][word_index];
}

val write_memory : (address, word) -> unit
function write_memory(addr, data) = {
	page_index = unsigned(addr[15..8]);
	word_index = unsigned(addr[7..0]);

	main_mem[page_index][word_index] = data
}

overload read  = {read_memory}
overload write = {write_memory}

val read_zp : word -> word
function read_zp(addr) = {
	read_memory(0x00 @ addr);
}

val write_zp : (word, word) -> unit
function write_zp(addr, data) = {
	write_memory(0x00 @ addr, data);
}

val read_sp : word -> word
function read_sp(addr) = {
	read_memory(0x01 @ addr);
}

val write_sp : (word, word) -> unit
function write_sp(addr, data) = {
	write_memory(0x01 @ addr, data);
}