function clause execute(RTI_IMP()) = {
	incr_cycles(6);

	let stored_sr = pull();
	let PCL = pull();
	let PCH = pull();

	reg_SR[all] = stored_sr;
	reg_SR[b] = 0b0;
	reg_PC = PCH @ PCL;

	true
}