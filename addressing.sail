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

val calc_from_word_to_word : (addrmode, word) -> word
function calc_from_word_to_word(addrmode, op) = {
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

val calc_from_word_to_addr : (bool, addrmode, word) -> address
function calc_from_word_to_addr(page_boundary_check, addrmode, op) = {
	match addrmode {
		mode(ind_x) => {
			incr_cycles(5);
			let ea  = op + reg_X;
			let ptr = read_zp(ea + 1) @ read_zp(ea);
			ptr
		},
		mode(ind_y) => {
			incr_cycles(4);
			let ptr = read_zp(op + 1) @ read_zp(op);
			let ea  = ptr + EXTZ(16, reg_Y);
			// CHECK HOW PAGE BOUNDARY CROSSING WORKS
			if (ptr[15..8] != ea[15..8] & page_boundary_check) then {
				incr_cycles(1);
				// print_bits("page boundary crossed, now in page: ", ea[15..8])
			};
			ptr
		}
	}
}

overload calc_from_word = {calc_from_word_to_word, calc_from_word_to_addr}

val calc_from_addr : (bool, addrmode, address) -> address
function calc_from_addr(page_boundary_check, addrmode, op) = {
	match addrmode {
		mode(abs)   => {
			incr_cycles(2);
			op
		},
		mode(abs_x) => {
			incr_cycles(2);
			let ea = op + EXTZ(16, reg_X);
			// CHECK HOW PAGE BOUNDARY CROSSING WORKS
			if (op[15..8] != ea[15..8] & page_boundary_check) then {
				incr_cycles(1);
				// print_bits("page boundary crossed, now in page: ", ea[15..8])
			};
			ea
		},
		mode(abs_y) => {
			incr_cycles(2);
			let ea = op + EXTZ(16, reg_Y);
			// CHECK HOW PAGE BOUNDARY CROSSING WORKS
			if (op[15..8] != ea[15..8] & page_boundary_check) then {
				incr_cycles(1);
				// print_bits("page boundary crossed, now in page: ", ea[15..8])
			};
			ea
		}
	}
}