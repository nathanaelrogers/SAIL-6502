let empty_page : page_256B = [word * page_size_word]
let main_mem : mem_64KB = [empty_page * mem_size_page]

val read_memory : address -> word
// function read_memory(addr) = {}

val write_memory : (address, word) -> unit
// function write_memory(addr, data) = {}

overload memory = {read_memory, write_memory}