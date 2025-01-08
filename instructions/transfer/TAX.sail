val modify_flags_TAX : (word) -> unit
function modify_flags_TAX(result) = {
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

val TAX : (unit) -> bool
function TAX() = {
	incr_cycles(2);
	let op = reg_A;

	modify_flags_TAX(op);
	reg_X = op;
	true
}

function clause execute(TAX_IMP()) = TAX()