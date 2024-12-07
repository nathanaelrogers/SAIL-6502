val modify_flags_INX : (word) -> unit
function modify_flags_INX(result) = {
	 // negative
	if (signed(result[7..0]) < 0) then
		set_flag_n(0b1)
	else
		set_flag_n(0b0);

	// zero
	if (unsigned(result[7..0]) == 0) then
		set_flag_z(0b1)
	else
		set_flag_z(0b0);
}

val INX : (unit) -> bool
function INX() = {
	incr_cycles(1);

	let result = reg_X + 1;
	reg_X = result;
	modify_flags_INX(result);

	true
}

function clause execute(INX_IMP()) = INX()