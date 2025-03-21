function clause execute(PHP()) = {
	incr_cycles(3);

	reg_SR[X] = 0b1;
	reg_SR[b] = 0b1;
	push(reg_SR[all]);

	reg_SR[X] = 0b0;
	reg_SR[b] = 0b0;

	true
}