val assembly : ast -> string
scattered function assembly

val make_str : (addrmode, string, string) -> string
function make_str(addrmode, name, op) = {
	match addrmode {
		mode(abs)   => concat_str(name, op),
		mode(abs_x) => concat_str(name, concat_str(op, ",X")),
		mode(abs_y) => concat_str(name, concat_str(op, ",Y")),
		mode(imm)   => concat_str(name, concat_str("#", op)),
		mode(ind_x) => concat_str(name, concat_str(concat_str("(", op), ",X)")),
		mode(ind_y) => concat_str(name, concat_str(concat_str("(", op), "),Y")),
		mode(zp)    => concat_str(name, op),
		mode(zp_x)  => concat_str(name, concat_str(op, ",X"))
	}
}

function clause assembly(ADC_IMM(op))   = make_str(mode(imm),   "ADC ", my_hex_str(op))
function clause assembly(ADC_ZP(op))    = make_str(mode(zp),    "ADC ", my_hex_str(op))
function clause assembly(ADC_ZP_X(op))  = make_str(mode(zp_x),  "ADC ", my_hex_str(op))
function clause assembly(ADC_ABS(op))   = make_str(mode(abs),   "ADC ", my_hex_str(op))
function clause assembly(ADC_ABS_X(op)) = make_str(mode(abs_x), "ADC ", my_hex_str(op))
function clause assembly(ADC_ABS_Y(op)) = make_str(mode(abs_y), "ADC ", my_hex_str(op))
function clause assembly(ADC_IND_X(op)) = make_str(mode(ind_x), "ADC ", my_hex_str(op))
function clause assembly(ADC_IND_Y(op)) = make_str(mode(ind_y), "ADC ", my_hex_str(op))

function clause assembly(AND_IMM(op))   = make_str(mode(imm),   "AND ", my_hex_str(op))
function clause assembly(AND_ZP(op))    = make_str(mode(zp),    "AND ", my_hex_str(op))
function clause assembly(AND_ZP_X(op))  = make_str(mode(zp_x),  "AND ", my_hex_str(op))
function clause assembly(AND_ABS(op))   = make_str(mode(abs),   "AND ", my_hex_str(op))
function clause assembly(AND_ABS_X(op)) = make_str(mode(abs_x), "AND ", my_hex_str(op))
function clause assembly(AND_ABS_Y(op)) = make_str(mode(abs_y), "AND ", my_hex_str(op))
function clause assembly(AND_IND_X(op)) = make_str(mode(ind_x), "AND ", my_hex_str(op))
function clause assembly(AND_IND_Y(op)) = make_str(mode(ind_y), "AND ", my_hex_str(op))

function clause assembly(EOR_IMM(op))   = make_str(mode(imm),   "EOR ", my_hex_str(op))
function clause assembly(EOR_ZP(op))    = make_str(mode(zp),    "EOR ", my_hex_str(op))
function clause assembly(EOR_ZP_X(op))  = make_str(mode(zp_x),  "EOR ", my_hex_str(op))
function clause assembly(EOR_ABS(op))   = make_str(mode(abs),   "EOR ", my_hex_str(op))
function clause assembly(EOR_ABS_X(op)) = make_str(mode(abs_x), "EOR ", my_hex_str(op))
function clause assembly(EOR_ABS_Y(op)) = make_str(mode(abs_y), "EOR ", my_hex_str(op))
function clause assembly(EOR_IND_X(op)) = make_str(mode(ind_x), "EOR ", my_hex_str(op))
function clause assembly(EOR_IND_Y(op)) = make_str(mode(ind_y), "EOR ", my_hex_str(op))

function clause assembly(ORA_IMM(op))   = make_str(mode(imm),   "ORA ", my_hex_str(op))
function clause assembly(ORA_ZP(op))    = make_str(mode(zp),    "ORA ", my_hex_str(op))
function clause assembly(ORA_ZP_X(op))  = make_str(mode(zp_x),  "ORA ", my_hex_str(op))
function clause assembly(ORA_ABS(op))   = make_str(mode(abs),   "ORA ", my_hex_str(op))
function clause assembly(ORA_ABS_X(op)) = make_str(mode(abs_x), "ORA ", my_hex_str(op))
function clause assembly(ORA_ABS_Y(op)) = make_str(mode(abs_y), "ORA ", my_hex_str(op))
function clause assembly(ORA_IND_X(op)) = make_str(mode(ind_x), "ORA ", my_hex_str(op))
function clause assembly(ORA_IND_Y(op)) = make_str(mode(ind_y), "ORA ", my_hex_str(op))

function clause assembly(SBC_IMM(op))   = make_str(mode(imm),   "SBC ", my_hex_str(op))
function clause assembly(SBC_ZP(op))    = make_str(mode(zp),    "SBC ", my_hex_str(op))
function clause assembly(SBC_ZP_X(op))  = make_str(mode(zp_x),  "SBC ", my_hex_str(op))
function clause assembly(SBC_ABS(op))   = make_str(mode(abs),   "SBC ", my_hex_str(op))
function clause assembly(SBC_ABS_X(op)) = make_str(mode(abs_x), "SBC ", my_hex_str(op))
function clause assembly(SBC_ABS_Y(op)) = make_str(mode(abs_y), "SBC ", my_hex_str(op))
function clause assembly(SBC_IND_X(op)) = make_str(mode(ind_x), "SBC ", my_hex_str(op))
function clause assembly(SBC_IND_Y(op)) = make_str(mode(ind_y), "SBC ", my_hex_str(op))

function clause assembly(INVALID(instruction)) = concat_str("Invalid instruction: ", bits_str(instruction))