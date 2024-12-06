type addrmode = bits(4)

enum am_enum = {
	acc,
	abs,
	abs_x,
	abs_y,
	imm,
	imp,
	ind,
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
	ind   <-> 0x6,
	ind_x <-> 0x7,
	ind_y <-> 0x8,
	rel   <-> 0x9,
	zp    <-> 0xA,
	zp_x  <-> 0xB,
	zp_y  <-> 0xC
}

val calc_word : (addrmode, word) -> word
function calc_word(addrmode, op) = {
	match addrmode {
		mode(imm)   => {
			incr_cycles(1);
			op
		},
		mode(zp)    => {
			incr_cycles(2);
			op
		},
		mode(zp_x)  => {
			incr_cycles(3);
			op + reg_X
		},
		mode(zp_y)  => {
			incr_cycles(3);
			op + reg_Y
		}
	}
}

val calc_from_word_to_addr : (addrmode, word) -> address
function calc_from_word_to_addr(addrmode, op) = {
	match addrmode {
		mode(ind_x) => {
			incr_cycles(5);
			let ptr  = op + reg_X;
			let ea = read_zp(ptr + 1) @ read_zp(ptr);
			ea
		},
		mode(ind_y) => {
			incr_cycles(4);
			let ptr = read_zp(op + 1) @ read_zp(op);
			let ea  = ptr + EXTZ(16, reg_Y);
			if (ptr[15..8] != ea[15..8]) then incr_cycles(1);
			ea
		}
	}
}

val calc_from_addr_to_addr : (addrmode, address) -> address
function calc_from_addr_to_addr(addrmode, op) = {
	match addrmode {
		mode(abs)   => {
			incr_cycles(2);
			op
		},
		mode(abs_x) => {
			incr_cycles(2);
			let ea = op + EXTZ(16, reg_X);
			ea
		},
		mode(abs_y) => {
			incr_cycles(2);
			let ea = op + EXTZ(16, reg_Y);
			ea
		}
	}
}

overload calc_addr = {calc_from_addr_to_addr, calc_from_word_to_addr}