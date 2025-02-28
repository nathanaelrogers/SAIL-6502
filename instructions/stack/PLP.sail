function clause execute(PLP()) = {
	incr_cycles(4);

	let stored_sr = pull();
	reg_SR[all] = stored_sr;
	reg_SR[b] = 0b0;

	true
}