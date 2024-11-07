val modify_flags_TXA : (word) -> unit
function modify_flags_TXA(result) = {
	if (signed(result) < 0)  then set_flag_n(0b1) else set_flag_n(0b0); // negative
	if (signed(result) == 0) then set_flag_z(0b1) else set_flag_z(0b0); // zero
}

val TXA : (unit) -> bool
function TXA() = {
	incr_cycles(2);
	let op = access(reg(X));

	modify_flags_TXA(op);
	access(reg(A)) = op;
	true
}

function clause execute(TXA_IMP()) = TXA()