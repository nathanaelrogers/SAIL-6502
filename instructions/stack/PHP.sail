function clause execute(PHP_IMP()) = {
	incr_cycles(2);

	reg_SR[X] = 0b1;
	reg_SR[b] = 0b1;
	let stored_sr = reg_SR[all];
	push(stored_sr);
	reg_SR[X] = 0b0;
	reg_SR[b] = 0b0;

	true
}