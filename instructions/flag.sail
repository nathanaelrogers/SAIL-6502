val ret_from_flag_modify : (unit) -> bool
function ret_from_flag_modify() = {
	incr_cycles(1);
	true
}

function clause execute(CLC_IMP()) = {reg_SR[c] = 0b0; ret_from_flag_modify()}
function clause execute(CLD_IMP()) = {reg_SR[d] = 0b0; ret_from_flag_modify()}
function clause execute(CLI_IMP()) = {reg_SR[i] = 0b0; ret_from_flag_modify()}
function clause execute(CLV_IMP()) = {reg_SR[v] = 0b0; ret_from_flag_modify()}
function clause execute(SEC_IMP()) = {reg_SR[c] = 0b1; ret_from_flag_modify()}
function clause execute(SED_IMP()) = {reg_SR[d] = 0b1; ret_from_flag_modify()}
function clause execute(SEI_IMP()) = {reg_SR[i] = 0b1; ret_from_flag_modify()}