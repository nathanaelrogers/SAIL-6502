val modify_flags_INY : (word) -> unit
function modify_flags_INY(result) = {
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

val INY : (unit) -> bool
function INY() = {
	incr_cycles(1);

	let result = reg_Y + 1;
	reg_Y = result;
	modify_flags_INY(result);

	true
}

function clause execute(INY_IMP()) = INY()