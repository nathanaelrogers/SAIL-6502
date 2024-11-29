val modify_flags_TSX : (word) -> unit
function modify_flags_TSX(result) = {
	if (signed(result) < 0)  then set_flag_n(0b1) else set_flag_n(0b0); // negative
	if (signed(result) == 0) then set_flag_z(0b1) else set_flag_z(0b0); // zero
}

val TSX : (unit) -> bool
function TSX() = {
	incr_cycles(2);
	let op = reg_SP;

	modify_flags_TSX(op);
	reg_X = op;
	true
}

function clause execute(TSX_IMP()) = TSX()