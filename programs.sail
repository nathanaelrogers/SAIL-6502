function setup_program1() : unit -> unit = {
	// Setup A with initial value.
	access(reg(A)) = 0x8A; // 0b1000_1010

	// Write instructions starting at 0x0200.

	// AND #$88
	write(0x0200, 0x29); // opcode
	write(0x0201, 0x88); // operand 0b1000_1000

	// AND #$08
	write(0x0202, 0x29); // opcode
	write(0x0203, 0x08); // operand 0b0000_1000

	// AND #$08
	write(0x0204, 0x29); // opcode
	write(0x0205, 0x08); // operand 0b0000_1000
}

function setup_program2() : unit -> unit = {
	// Setup A with initial value.
	access(reg(A)) = 0xFF; //-1

	// Write instructions starting at 0x0200.

	// ADC #$01
	write(0x0200, 0x69); // opcode
	write(0x0201, 0x01); // operand 1
}
