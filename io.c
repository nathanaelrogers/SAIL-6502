#include "sail.h"
#include "io.h"

#include <stdlib.h>
#include <unistd.h>
#include <termios.h>
#include <stdio.h>
#include <ctype.h>
#include <sys/time.h>
#include <sys/types.h>

struct termios orig_termios;
unsigned char *memory;

void disableRawMode()
{
	tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_termios);
}

void enableRawMode()
{
	tcgetattr(STDIN_FILENO, &orig_termios);
	atexit(disableRawMode);

	struct termios raw = orig_termios;
	// can use ECHO flag for echoing and ICANON for raw/cooked mode
	raw.c_lflag &= ~(ECHO | ICANON);

	tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw);
}

unit terminal_init(const unit u)
{
	enableRawMode();

	return UNIT;
}

unit memory_init(const unit u)
{
	memory = calloc((0b1 << 16), sizeof(unsigned char));

	return UNIT;
}

unit print_char(const sail_int c)
{
	printf("%c", (unsigned char) mpz_get_ui(c));

	return UNIT;
}

uint64_t try_read_char(const unit u)
{
	char nxt;
	int ready = 0;
	int num_read = 0;
	fd_set input_set;
	struct timeval timeout;

	timeout.tv_sec = 0;
	timeout.tv_usec = 0;

	FD_ZERO(&input_set);
	FD_SET(STDIN_FILENO, &input_set);

	ready = select(1, &input_set, NULL, NULL, &timeout);

	if (ready == -1) {
		return -1;
	}

	if (ready) {
		num_read = read(STDIN_FILENO, &nxt, 1);
		return nxt;
	}

	return 0;
}

uint64_t mem_read(const sail_int addr)
{
	return memory[mpz_get_ui(addr)];
}

unit mem_write(const sail_int addr, const sail_int data)
{
	memory[mpz_get_ui(addr)] = mpz_get_ui(data);

	return UNIT;
}

unit load_binary(const sail_string path, const sail_int start_addr)
{
	FILE *code = fopen(path, "rb");
	if (!code) {
		return 1;
	}
	int read = fread(memory + mpz_get_ui(start_addr), sizeof(unsigned char), (0b1 << 16), code);

	return UNIT;
}