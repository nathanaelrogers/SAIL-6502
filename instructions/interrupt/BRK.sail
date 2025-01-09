// TODO : inspect precise behaviour of BRK instruction and make sure it is accurate
// TODO : also look at PLP and PHP for same reasons...

function clause execute(BRK()) = {
	/*
		By the time this is executed, reg_PC = instruction PC + 1 (size of BRK instruction).
		So to preserve instruction PC + 2, calculate reg_PC + 1.
	*/
	let stored_pc = reg_PC + 1;
	push(stored_pc[15..8]);
	push(stored_pc[7..0]);

	reg_SR[unused] = 0b1;
	reg_SR[b] = 0b1;
	let stored_sr = reg_SR[all];
	push(stored_sr);
	reg_SR[unused] = 0b0;
	reg_SR[b] = 0b0;

	reg_SR[i] = 0b1;

	let PCH = read(IRQ_vec + 1);
	let PCL = read(IRQ_vec);
	reg_PC = PCH @ PCL;

	incr_cycles(6);
	false
}