#include "fake6502.h"

#include <stdlib.h>
#include <stdio.h>

typedef unsigned char *memory;

memory main_mem;

unsigned char read6502(ushort address) {
	return main_mem[address];
}

void write6502(ushort address, unsigned char value) {
	main_mem[address] = value;
	return;
}

int functional_test() {
	// Open the code file
	FILE *code = fopen("test/sourcefiles/functional/6502_functional_test.bin", "rb");
	if (!code) {
		fprintf(stderr, "could not open 6502_functional_test.bin!\n");
		return 1;
	}

	// Read the code into memory
	fread(main_mem + 0x0A, sizeof(unsigned char), (0b1 << 16), code);

	// initialise the processor
	reset6502();
	pc = 0x0400;

	// run
	exec6502_until_trap();
	printf("total cycles: %d, total instructions: %d, pc: %x\n", clockticks6502, instructions, pc);
	return 0;
}

int functional_test_no_bcd() {
	// Open the code file
	FILE *code = fopen("test/sourcefiles/functional/6502_functional_test_no_bcd.bin", "rb");
	if (!code) {
		fprintf(stderr, "could not open 6502_functional_test_no_bcd.bin!\n");
		return 1;
	}

	// Read the code into memory
	fread(main_mem + 0x0A, sizeof(unsigned char), (0b1 << 16), code);

	// initialise the processor
	reset6502();
	pc = 0x0400;

	// run
	exec6502_until_trap();
	printf("cycles: %d, instructions: %d, pc: %x\n", clockticks6502, instructions, pc);
	return 0;
}

int bcd_test() {
	// Open the code file
	FILE *code = fopen("test/sourcefiles/BCD/valid-only.bin", "rb");
	if (!code) {
		fprintf(stderr, "could not open valid-only.bin!\n");
		return 1;
	}

	// Read the code into memory
	fread(main_mem, sizeof(unsigned char), (0b1 << 16), code);

	// initialise the processor
	reset6502();
	pc = 0x0000;

	// run
	exec6502_until_trap();
	printf("result in address 0x08FF: %x\n", main_mem[0x08FF]);
	printf("cycles: %d, instructions: %d, pc: %x\n", clockticks6502, instructions, pc);
	return 0;
}

int main() {
	// Initialise the main memory
	main_mem = (memory) calloc((0b1 << 16), sizeof(unsigned char));

	return functional_test_no_bcd();
}