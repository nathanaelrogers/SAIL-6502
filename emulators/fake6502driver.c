#include "fake6502.c"

#include <stdlib.h>
#include <stdio.h>

typedef uint8_t* mem_page;
typedef mem_page* mem_64K;

mem_64K main_mem;

uint8_t read6502(uint16_t address) {
	return main_mem[address >> 8][address & 0xFF];
}

void write6502(uint16_t address, uint8_t value) {
	main_mem[address >> 8][address & 0xFF] = value;
	return;
}

int main() {
	// Initialise the main memory
	main_mem = calloc(0xFF, sizeof(mem_page));
	for (int i = 0; i < 0xFF; i++) {
		main_mem[i] = calloc(0xFF, sizeof(uint8_t));
	}

	write6502(0x0000, 0x42);
	printf("%x\n", read6502(0x0000));

	push8(0x27);
	printf("%x\n", pull8());

	return 0;
}