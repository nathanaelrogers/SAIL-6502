val RTS : (unit) -> bool
function RTS() = {
	incr_cycles(3);

	let PCL = pull();
	let PCH = pull();

	reg_PC = PCH @ PCL;
	incr_pc();

	true
}

function clause execute(RTS_IMP()) = RTS()