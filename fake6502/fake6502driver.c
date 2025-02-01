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

int main() {
	// Initialise the main memory
	main_mem = (memory) calloc((0b1 << 16), sizeof(uint8_t));

	// Open the code file
	FILE *code = fopen("../code.bin", "rb");
	if (!code) {
		fprintf(stderr, "could not open code.bin!\n");
		return 1;
	}
	// Read the code into memory
	fread(main_mem, sizeof(uint8_t), (0b1 << 16), code);

	return 0;
}