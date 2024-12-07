val BCC : (word) -> bool
function BCC(op) = {
	let new_pc = reg_PC + unsigned(op);

	if (new_pc[15..8] == reg_PC[15..8]) then
		incr_cycles(1)
	else
		incr_cycles(2);

	if (flag_c() == 0b0) then
		reg_PC = new_pc;

	true
}

function clause execute(BCC_REL(op)) = {
	let word = calc_word(mode(rel), op);
	BCC(word)
}