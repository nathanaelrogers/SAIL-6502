val modify_flags_TAY : (word) -> unit
function modify_flags_TAY(result) = {
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

val TAY : (unit) -> bool
function TAY() = {
	incr_cycles(2);
	let op = reg_A;

	modify_flags_TAY(op);
	reg_Y = op;
	true
}

function clause execute(TAY_IMP()) = TAY()