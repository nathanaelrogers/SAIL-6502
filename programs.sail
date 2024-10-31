function setup_program1() : unit -> unit = {
	/* manual program setup */

	// Write PC 0x0200 to reset vector.
	write(RES_vec, 0x00);
	write(RES_vec + 1, 0x02);

	// Setup A with initial value.
	access(name(A)) = 0x8A; // 0b1000_1010

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