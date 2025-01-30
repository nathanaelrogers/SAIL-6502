function clause execute(RTS_IMP()) = {
	incr_cycles(5);

	let PCL = pull();
	let PCH = pull();

	reg_PC = PCH @ PCL;
	incr_pc(1);

	true
}