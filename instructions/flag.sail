function clause execute(CLC_IMP()) = {reg_SR[c] = 0b0; incr_cycles(2); true}
function clause execute(CLD_IMP()) = {reg_SR[d] = 0b0; incr_cycles(2); true}
function clause execute(CLI_IMP()) = {reg_SR[i] = 0b0; incr_cycles(2); true}
function clause execute(CLV_IMP()) = {reg_SR[v] = 0b0; incr_cycles(2); true}
function clause execute(SEC_IMP()) = {reg_SR[c] = 0b1; incr_cycles(2); true}
function clause execute(SED_IMP()) = {reg_SR[d] = 0b1; incr_cycles(2); true}
function clause execute(SEI_IMP()) = {reg_SR[i] = 0b1; incr_cycles(2); true}