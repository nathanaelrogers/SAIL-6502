type interrupt_line = bits(1)

// interrupt lines initialised to 1 since they are active LOW not high
// TODO : how to model hardware interrupts?
register NMI : interrupt_line = 0b1
let NMI_vec : address = 0xFFFA

register RST : interrupt_line = 0b1
let RST_vec : address = 0xFFFC

register IRQ : interrupt_line = 0b1
let IRQ_vec : address = 0xFFFE