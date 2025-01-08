val modify_flags_TYA : (word) -> unit
function modify_flags_TYA(result) = {
	 // negative
	if (signed(result[7..0]) < 0) then
		reg_SR[n] = 0b1
	else
		reg_SR[n] = 0b0;

	// zero
	if (unsigned(result[7..0]) == 0) then
		reg_SR[z] = 0b1
	else
		reg_SR[z] = 0b0;
}

val TYA : (unit) -> bool
function TYA() = {
	incr_cycles(2);
	let op = reg_Y;

	modify_flags_TYA(op);
	reg_A = op;
	true
}

function clause execute(TYA_IMP()) = TYA()