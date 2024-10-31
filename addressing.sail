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