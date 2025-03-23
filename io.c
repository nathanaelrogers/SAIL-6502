#include "sail.h"
#include "io.h"
#include <stdio.h>

unit print_char(const sail_int c) {
	printf("%c", (unsigned char) mpz_get_ui(c));
	return UNIT;
}

void try_read_char(sail_int *input_buffer, unit u) {
	int ch = 65;

	mpz_set_ui(*input_buffer, ch);

	return;
}