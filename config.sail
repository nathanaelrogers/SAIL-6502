register enable_print_at_interval : bool = false
register enable_print_dump        : bool = true
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
write(0x0200, 0x48);
write(0x0201, 0x08);
write(0x0202, 0x68);
write(0x0203, 0x28);
reg_PC = 0x0200;
}