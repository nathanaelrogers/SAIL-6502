register main_mem : mem_64KB = vector_init(256, vector_init(256, 0x00))

// TODO : what's the behaviour when FAIL to read/write to stack (page 1)? is it protected or not?
// TODO : include timing behaviour for memory accesses
// TODO : add push/pop methods

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

	if (page_index != 1) then {
		main_mem[page_index][word_index] = data
	}
}

val read_memory_zp : word -> word
function read_memory_zp(addr) = {
	read_memory(0x00 @ addr);
}

val write_memory_zp : (word, word) -> unit
function write_memory_zp(addr, data) = {
	write_memory(0x00 @ addr, data);
}

overload read =  {read_memory, read_memory_zp}
overload write = {write_memory, write_memory_zp}