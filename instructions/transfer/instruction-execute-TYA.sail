val modify_flags_TYA : (word) -> unit
function modify_flags_TYA(result) = {
	if (signed(result) < 0)  then set_flag_n(0b1) else set_flag_n(0b0); // negative
	if (signed(result) == 0) then set_flag_z(0b1) else set_flag_z(0b0); // zero
}

val TYA : (unit) -> bool
function TYA() = {
	incr_cycles(2);
	let op = access(reg(Y));

	modify_flags_TYA(op);
	access(reg(A)) = op;
	true
}

function clause execute(TYA_IMP()) = TYA()