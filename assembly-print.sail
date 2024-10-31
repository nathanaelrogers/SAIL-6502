val assembly : ast -> string
scattered function assembly

function clause assembly(AND_IMM(op)) = concat_str("AND ", concat_str("#", my_hex_str(op)))
function clause assembly(AND_ZP(op)) = concat_str("AND ", my_hex_str(op))
function clause assembly(AND_ZP_X(op)) = concat_str("AND ", concat_str(my_hex_str(op), ",X"))
function clause assembly(AND_ABS(op)) = concat_str("AND ", my_hex_str(op))
function clause assembly(AND_ABS_X(op)) = concat_str("AND ", concat_str(my_hex_str(op), ",X"))
function clause assembly(AND_ABS_Y(op)) = concat_str("AND ", concat_str(my_hex_str(op), ",Y"))
function clause assembly(AND_IND_X(op)) = concat_str("AND ", concat_str(concat_str("(", my_hex_str(op)), ",X)"))
function clause assembly(AND_IND_Y(op)) = concat_str("AND ", concat_str(concat_str("(", my_hex_str(op)), "),Y"))

function clause assembly(INVALID(instruction)) = concat_str("Invalid instruction: ", bits_str(instruction))