function clause execute(RTI()) = {
	incr_cycles(6);

	reg_SR[all] = pull();

	reg_SR[b] = 0b0;
	reg_SR[X] = 0b0;

	let PCL = pull();
	let PCH = pull();
	reg_PC = PCH @ PCL;

	true
}