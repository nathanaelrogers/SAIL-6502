val modify_flags_TAX : (word) -> unit
function modify_flags_TAX(result) = {
	if (signed(result) < 0)  then set_flag_n(0b1) else set_flag_n(0b0); // negative
	if (signed(result) == 0) then set_flag_z(0b1) else set_flag_z(0b0); // zero
}

val TAX : (unit) -> bool
function TAX() = {
	incr_cycles(2);
	let op = access(reg(A));

	modify_flags_TAX(op);
	access(reg(X)) = op;
	true
}

function clause execute(TAX_IMP()) = TAX()