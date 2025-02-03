#include "fake6502.c"

#include <stdlib.h>
#include <stdio.h>

typedef uint8_t *memory;

memory main_mem;

uint8_t read6502(uint16_t address) {
	return main_mem[address];
}

void write6502(uint16_t address, uint8_t value) {
	main_mem[address] = value;
	return;
}

int functional_test() {
	// Open the code file
	FILE *code = fopen("test/sourcefiles/functional/6502_functional_test.bin", "rb");
	if (!code) {
		fprintf(stderr, "could not open code.bin!\n");
		return 1;
	}
	// Read the code into memory
	fread(main_mem + 0x0A, sizeof(uint8_t), (0b1 << 16), code);

	// run the code
	reset6502();
	pc = 0x0400;
	status = 0x06;
	while (1) {
		uint16_t saved_pc = pc;

		step6502();

		if (saved_pc == pc) {
			printf("cycles: %d, instructions: %d, pc: %x\n", clockticks6502, instructions, pc);
			return 0;
		}
	}
}

int main() {
	// Initialise the main memory
	main_mem = (memory) calloc((0b1 << 16), sizeof(uint8_t));

	return functional_test();
}