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
unsigned char buf[2048];
int i = -1;

uint8_t nmi = 1;
uint8_t rst = 1;
uint8_t irq = 1;

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

	switch (loc)
	{
		case 0x8400:
			if (i < 0)
			{
				return 0;
			}
			else
			{
				return buf[i--];
			}
		case 0x8401:
			if (i < 0)
			{
				return 0;
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

unit consume_input(const unit u)
{
	unsigned char nxt = 0;

	do
	{
		nxt = try_read_char();
		if (nxt == 0x0C) // ctrl + L
		{
			nmi = 0;
			break;
		}
		if (nxt == 0x12) // ctrl + R
		{
			rst = 0;
			break;
		}
		if (nxt == 0x14) // ctrl + T
		{
			irq = 0;
			break;
		}
		if (nxt)
		{
			buf[++i] = nxt;
		}
	} while (nxt);
	

	return UNIT;
}

uint8_t get_nmi(const unit u)
{
	if (nmi == 0)
	{
		nmi = 1;
		return 0;
	}
	else
	{
		return nmi;
	}
}

uint8_t get_rst(const unit u)
{
	if (rst == 0)
	{
		rst = 1;
		return 0;
	}
	else
	{
		return rst;
	}
}

uint8_t get_irq(const unit u)
{
	if (irq == 0)
	{
		irq = 1;
		return 0;
	}
	else
	{
		return irq;
	}
}