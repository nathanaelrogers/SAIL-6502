function clause execute(CLC()) = {reg_SR[c] = 0b0; incr_cycles(2); true}
function clause execute(CLD()) = {reg_SR[d] = 0b0; incr_cycles(2); true}
function clause execute(CLI()) = {reg_SR[i] = 0b0; incr_cycles(2); true}
function clause execute(CLV()) = {reg_SR[v] = 0b0; incr_cycles(2); true}
function clause execute(SEC()) = {reg_SR[c] = 0b1; incr_cycles(2); true}
function clause execute(SED()) = {reg_SR[d] = 0b1; incr_cycles(2); true}
function clause execute(SEI()) = {reg_SR[i] = 0b1; incr_cycles(2); true}