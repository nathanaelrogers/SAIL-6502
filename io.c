#include "sail.h"
#include "io.h"

unit print_char(const sail_int c) {
	printf("%c", (unsigned char) mpz_get_ui(c));
	return UNIT;
}