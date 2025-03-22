function clause execute(BRK()) = {
	incr_cycles(7);
	/*
		By the time this is executed, reg_PC = instruction PC + 1 (size of BRK instruction).
		So to preserve instruction PC + 2, calculate reg_PC + 1.
	*/
	let stored_pc = reg_PC + 1;
	push(stored_pc[15..8]);
	push(stored_pc[7..0]);

	/* The manual specifies that b flag is set, but the unused flag and i flag
	behaviour for this instruction came from emulators and tests not the manual
	so it is worth mentioning in the report for sure... */
	reg_SR[X] = 0b1;
	reg_SR[b] = 0b1;

	push(reg_SR[all]);

	reg_SR[X] = 0b0;
	reg_SR[b] = 0b0;
	reg_SR[i] = 0b1;

	let PCH = read(IRQ_vec + 1);
	let PCL = read(IRQ_vec);
	reg_PC = PCH @ PCL;

	true
}