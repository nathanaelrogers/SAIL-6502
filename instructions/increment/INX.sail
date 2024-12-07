val INX : (unit) -> bool
function INX() = {
	incr_cycles(1);
	reg_X = reg_X + 1;
	true
}

function clause execute(INX_IMP()) = INX()