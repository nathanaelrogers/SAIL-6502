val modify_flags_DEY : (word) -> unit
function modify_flags_DEY(result) = {
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

val DEY : (unit) -> bool
function DEY() = {
	incr_cycles(1);

	let result = reg_Y + (-1);
	reg_Y = result;
	modify_flags_DEY(result);

	true
}

function clause execute(DEY_IMP()) = DEY()