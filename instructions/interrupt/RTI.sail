function clause execute(RTI_IMP()) = {
	incr_cycles(4);

	let stored_sr = pull();
	let PCL = pull();
	let PCH = pull();
	let stored_pc = PCH @ PCL;

	reg_SR[all] = stored_sr;
	reg_SR[b] = 0b0;
	reg_PC = stored_pc;
	incr_pc(2);

	true
}