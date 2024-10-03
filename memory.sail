let empty_word : word = 0x00
let main_mem : mem_64KB = vector_init(256, vector_init(256, empty_word))

val read_memory : address -> word
// function read_memory(addr) = {}

val write_memory : (address, word) -> unit
// function write_memory(addr, data) = {}

val read_memory_zero_page : word -> word
function read_memory_zero_page(word) = {
	read_memory(0x00 @ word);
}

overload memory = {read_memory, write_memory, read_memory_zero_page}