function my_program() : unit -> unit = {
	/* manual program setup */

	// Write PC 0x0200 to reset vector.
	write(RES_vec, 0x00);
	write(RES_vec + 1, 0x02);

	// Setup A with initial value.
	reg(name(A)) = 0x0A; // 0b0000_1010

	// Write instructions starting at 0x0200.

	// AND #$08
	write(0x0200, 0x29); // opcode
	write(0x0201, 0x08); // operand
}