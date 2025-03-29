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
fd_set input_set;
struct timeval timeout;

unsigned char *memory;
unsigned char buf;

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

	timeout.tv_sec = 0;
	timeout.tv_usec = 0;

	return UNIT;
}

unit memory_init(const unit u)
{
	memory = calloc((0b1 << 16), sizeof(unsigned char));

	return UNIT;
}

// Returns 0 (null byte) if it cannot read a character from terminal
uint8_t try_read_char()
{
	unsigned char nxt;
	int ready = 0;
	int num_read = 0;

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

uint8_t mem_read(const sail_int addr)
{
	unsigned char nxt;
	int loc = mpz_get_ui(addr);

	if (buf == 0)
		buf = try_read_char();

	switch (loc)
	{
		case 0x8400:
			if (buf == 0)
			{
				return buf;
			}
			else
			{
				nxt = buf;
				buf = 0;
				return nxt;
			}
		case 0x8401:
			if (buf == 0)
			{
				return buf;
			}
			else
			{
				return 0x08;
			}
		default:
			return memory[loc];
	}
}

unit mem_write(const sail_int addr, const sail_int data)
{
	int loc = mpz_get_ui(addr);
	int ch = mpz_get_ui(data);

	switch (loc)
	{
		case 0x8400:
			printf("%c", ch);
			fflush(stdout);
			break;
		case 0x8401:
			break;
		case 0x8402:
			break;
		case 0x8403:
			break;
		default:
			memory[loc] = ch;
			break;
	}

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