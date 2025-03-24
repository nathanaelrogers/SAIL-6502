register enable_print_at_interval : bool = false
register enable_print_dump        : bool = false
register enable_break_at_trap     : bool = true
register enable_print_mem         : bool = false
val print_memory : (unit) -> unit
function print_memory() = {
print_endline("");
}

val load_config : (unit) -> unit
function load_config() = {
reg_SR[all] = 0x06;
reg_SP = 0xff;
load_binary("test/sourcefiles/functional/6502_functional_test_no_bcd.bin", unsigned(0x000a));
reg_PC = 0x0400;
}