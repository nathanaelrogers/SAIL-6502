val ASL : (word) -> word
function ASL(op) = {
	reg_SR[c] = [op[7]];
	op << 1
}

function clause execute(ASL_ACC()) = {
	reg_A = ASL(reg_A);
	incr_cycles(1);
	true
}
function clause execute(ASL_ZP(op)) = {
	let word = calc_word(mode(zp), op);
	let result = ASL(read_zp(word));
	write_zp(word, result);
	incr_cycles(2);
	true
}
function clause execute(ASL_ZP_X(op)) = {
	let word = calc_word(mode(zp_x), op);
	let result = ASL(read_zp(word));
	write_zp(word, result);
	incr_cycles(2);
	true
}
function clause execute(ASL_ABS(op)) = {
	let addr = calc_addr(mode(abs), op);
	let result = ASL(read(addr));
	write(addr, result);
	incr_cycles(2);
	true
}
function clause execute(ASL_ABS_X(op)) = {
	let addr = calc_addr(mode(abs_x), op);
	let result = ASL(read(addr));
	write(addr, result);
	incr_cycles(4);
	true
}