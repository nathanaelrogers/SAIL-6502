register reg_PC : address
register reg_A  : word
register reg_X  : word
register reg_Y  : word
register reg_SR : flags
register reg_SP : word

// Helper function to increment the PC.
val incr_pc : unit -> unit
function incr_pc() = {
	reg_PC = reg_PC + 1
}

val incr_sp : unit -> unit
function incr_sp() = {
	reg_SP = reg_SP + 1
}

val decr_sp : unit -> unit
function decr_sp() = {
	reg_SP = reg_SP + (-1)
}

// Helper functions to set individual flags.
function set_flag_n(bit) : bits(1) -> unit = {reg_SR[n] = bit}
function set_flag_v(bit) : bits(1) -> unit = {reg_SR[v] = bit}
function set_flag_b(bit) : bits(1) -> unit = {reg_SR[b] = bit}
function set_flag_d(bit) : bits(1) -> unit = {reg_SR[d] = bit}
function set_flag_i(bit) : bits(1) -> unit = {reg_SR[i] = bit}
function set_flag_z(bit) : bits(1) -> unit = {reg_SR[z] = bit}
function set_flag_c(bit) : bits(1) -> unit = {reg_SR[c] = bit}

// Helper functions to read individual flags.
function flag_n() : unit -> bits(1) = reg_SR[n]
function flag_v() : unit -> bits(1) = reg_SR[v]
function flag_b() : unit -> bits(1) = reg_SR[b]
function flag_d() : unit -> bits(1) = reg_SR[d]
function flag_i() : unit -> bits(1) = reg_SR[i]
function flag_z() : unit -> bits(1) = reg_SR[z]
function flag_c() : unit -> bits(1) = reg_SR[c]