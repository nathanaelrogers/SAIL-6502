function setup_program_adc_test() : unit -> unit = {
	access(reg(A)) = 0xBE;
	write(0x0200, 0x69); // opcode for ADC imm
	write(0x0201, 0x75);

}
