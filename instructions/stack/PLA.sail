function clause execute(PLA()) = {
	incr_cycles(3);
	let result = pull();

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

	reg_A = result;
	true
}
