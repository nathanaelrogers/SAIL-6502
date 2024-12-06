val JSR : (address) -> bool
function JSR(address) = {
	/*
		By the time we execute this, reg_PC = instruction PC + 3 (size of JSR instruction).
		So to preserve instruction PC + 2 on the stack, we calculate reg_PC - 1.
	*/
	let stored_pc = reg_PC + (-1);
	push(stored_pc[15..8]);
	push(stored_pc[7..0]);

	reg_PC = address;

	true
}

function clause execute(JSR_ABS(op)) = {
	let addr = calc_addr(mode(abs), op);
	JSR(addr)
}