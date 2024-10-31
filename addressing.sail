type addrmode = bits(4)

enum am_enum = {
	acc,
	abs,
	abs_x,
	abs_y,
	imm,
	imp,
	ind_x,
	ind_y,
	rel,
	zp,
	zp_x,
	zp_y
}

mapping mode : am_enum <-> addrmode = {
	acc   <-> 0x0,
	abs   <-> 0x1,
	abs_x <-> 0x2,
	abs_y <-> 0x3,
	imm   <-> 0x4,
	imp   <-> 0x5,
	ind_x <-> 0x6,
	ind_y <-> 0x7,
	rel   <-> 0x9,
	zp    <-> 0xA,
	zp_x  <-> 0xB,
	zp_y  <-> 0xC
}

val calculate_op_word : (addrmode, word) -> word
function calculate_op_word(addrmode, op) = {
	match addrmode {
		mode(imm)   => op,
		mode(ind_x) => {
			let ea  = op + access(reg(X));
			let ptr = read(ea + 1) @ read(ea);
			read(ptr)
		},
		mode(ind_y) => {
			let ptr = read(op + 1) @ read(op);
			let ea  = ptr + EXTZ(16, access(reg(Y)));
			if (ptr[15..8] != ea[15..8]) then {
				incr_cycles();
				print_bits("page boundary crossed, now in page: ", ea[15..8])
			};
			read(ptr)
		},
		mode(zp)    => read(op),
		mode(zp_x)  => read(op + access(reg(X)))
	}
}

val calculate_op_address : (addrmode, address) -> word
function calculate_op_address(addrmode, op) = {
	match addrmode {
		mode(abs)   => read(op),
		mode(abs_x) => {
			let ea = op + EXTZ(16, access(reg(X)));
			if (op[15..8] != ea[15..8]) then {
				incr_cycles();
				print_bits("page boundary crossed, now in page: ", ea[15..8])
			};
			read(ea)
		},
		mode(abs_y) => {
			let ea = op + EXTZ(16, access(reg(Y)));
			if (op[15..8] != ea[15..8]) then {
				incr_cycles();
				print_bits("page boundary crossed, now in page: ", ea[15..8])
			};
			read(ea)
		}
	}
}

overload calculate_op = {calculate_op_address, calculate_op_word}