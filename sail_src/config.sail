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
main_mem[0][0] = 0xad;
main_mem[0][1] = 0x01;
main_mem[0][2] = 0x84;
main_mem[0][3] = 0x29;
main_mem[0][4] = 0x08;
main_mem[0][5] = 0xc9;
main_mem[0][6] = 0x08;
main_mem[0][7] = 0xf0;
main_mem[0][8] = 0x03;
main_mem[0][9] = 0x4c;
main_mem[0][10] = 0x00;
main_mem[0][11] = 0x00;
main_mem[0][12] = 0xad;
main_mem[0][13] = 0x00;
main_mem[0][14] = 0x84;
main_mem[0][15] = 0x8d;
main_mem[0][16] = 0x00;
main_mem[0][17] = 0x84;
main_mem[0][18] = 0xa5;
main_mem[0][19] = 0x0d;
main_mem[0][20] = 0x85;
main_mem[0][21] = 0x0d;
main_mem[0][22] = 0xa5;
main_mem[0][23] = 0x0a;
main_mem[0][24] = 0x85;
main_mem[0][25] = 0x0a;
main_mem[0][26] = 0xad;
main_mem[0][27] = 0x01;
main_mem[0][28] = 0x84;
main_mem[0][29] = 0x29;
main_mem[0][30] = 0xf7;
main_mem[0][31] = 0x8d;
main_mem[0][32] = 0x01;
main_mem[0][33] = 0x84;
main_mem[0][34] = 0x4c;
main_mem[0][35] = 0x00;
main_mem[0][36] = 0x00;
}