val modify_flags_TXA : (word) -> unit
function modify_flags_TXA(result) = {
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

val TXA : (unit) -> bool
function TXA() = {
	incr_cycles(2);
	let op = reg_X;

	modify_flags_TXA(op);
	reg_A = op;
	true
}

function clause execute(TXA_IMP()) = TXA()