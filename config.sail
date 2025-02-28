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
write(0x0000, 0xa9);
write(0x0001, 0x00);
write(0x0002, 0x8d);
write(0x0003, 0xff);
write(0x0004, 0xff);
write(0x0005, 0xa9);
write(0x0006, 0x11);
write(0x0007, 0x8d);
write(0x0008, 0xfe);
write(0x0009, 0xff);
write(0x000a, 0x00);
write(0x000b, 0xea);
write(0x000c, 0xa9);
write(0x000d, 0xff);
write(0x000e, 0x4c);
write(0x000f, 0x0e);
write(0x0010, 0x00);
write(0x0011, 0x40);
reg_PC[15..8] = read(RST_vec + 1);
reg_PC[7..0]  = read(RST_vec);
}