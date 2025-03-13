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

int check_trap(uint16_t saved_pc, uint16_t pc) {
	if (saved_pc == pc) {
		printf("cycles: %d, instructions: %d, pc: %x\n", clockticks6502, instructions, pc);
		return 1;
	} else {
		return 0;
	}
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

		if (check_trap(saved_pc, pc))
			return 0;
	}
}

int bcd_test() {
	// Open the code file
	FILE *code = fopen("test/sourcefiles/BCD/valid-only.bin", "rb");
	if (!code) {
		fprintf(stderr, "could not open valid-only.bin!\n");
		return 1;
	}
	// Read the code into memory
	fread(main_mem, sizeof(uint8_t), (0b1 << 16), code);

	// run the code
	reset6502();
	pc = 0x0000;
	status = 0x06;
	while (1) {
		uint16_t saved_pc = pc;

		step6502();

		if (check_trap(saved_pc, pc)) {
			printf("contents of 0x08FF: %x\n", main_mem[0x08FF]);
			return 0;
		}
	}
}

int tiny_bcd_test() {
	main_mem[0x0000] = 0xF8;
	main_mem[0x0001] = 0xA9;
	main_mem[0x0002] = 0x10;
	main_mem[0x0003] = 0xE9;
	main_mem[0x0004] = 0x03;

	// run the code
	reset6502();
	pc = 0x0000;
	status = 0x06;
	while (1) {
		uint16_t saved_pc = pc;

		step6502();

		if (saved_pc == 0x0005) {
			printf("contents of accumulator: 0x%x\n", a);
			return 0;
		}
	}
}

int main() {
	// Initialise the main memory
	main_mem = (memory) calloc((0b1 << 16), sizeof(uint8_t));

	return bcd_test();
}