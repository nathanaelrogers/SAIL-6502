function clause execute(RTS()) = {
	incr_cycles(6);

	let PCL = pull();
	let PCH = pull();

	reg_PC = PCH @ PCL;
	incr_pc(1);

	true
}