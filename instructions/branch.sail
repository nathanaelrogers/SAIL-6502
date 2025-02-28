val branch : (word, bool) -> bool
function branch(op, branch_condition) = {
	incr_cycles(2);
	let next_PC = reg_PC;

	let word = calc_word(mode(rel), op);
	let new_PC = next_PC + signed(word);

	if branch_condition then {
		reg_PC = new_PC;

		if (new_PC[15..8] == next_PC[15..8]) then
			incr_cycles(1)
		else
			incr_cycles(2);
	};

	true
}

// ===============================================================

function clause execute(BCC_REL(op)) = branch(op, reg_SR[c] == 0b0)
function clause execute(BCS_REL(op)) = branch(op, reg_SR[c] == 0b1)

function clause execute(BNE_REL(op)) = branch(op, reg_SR[z] == 0b0)
function clause execute(BEQ_REL(op)) = branch(op, reg_SR[z] == 0b1)

function clause execute(BPL_REL(op)) = branch(op, reg_SR[n] == 0b0)
function clause execute(BMI_REL(op)) = branch(op, reg_SR[n] == 0b1)

function clause execute(BVC_REL(op)) = branch(op, reg_SR[v] == 0b0)
function clause execute(BVS_REL(op)) = branch(op, reg_SR[v] == 0b1)