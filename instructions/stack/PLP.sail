function clause execute(PLP()) = {
	incr_cycles(4);

	reg_SR[all] = pull();

	reg_SR[b] = 0b0;
	reg_SR[X] = 0b0;

	true
}