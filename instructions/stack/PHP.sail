function clause execute(PHP_IMP()) = {
	incr_cycles(3);

	reg_SR[unused] = 0b1;
	reg_SR[b] = 0b1;
	let stored_sr = reg_SR[all];
	push(stored_sr);
	reg_SR[unused] = 0b0;
	reg_SR[b] = 0b0;

	true
}