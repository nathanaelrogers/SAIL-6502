val BCC : (word) -> bool
function BCC(op) = {
	if (flag_c() == 0b0) then incr_pc(unsigned(op));
	true
}

function clause execute(BCC_REL(op)) = {
	let word = calc_word(mode(rel), op);
	BCC(word)
}