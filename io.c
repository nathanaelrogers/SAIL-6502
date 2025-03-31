#include "sail.h"
#include "io.h"

#include <stdlib.h>
#include <unistd.h>
#include <termios.h>
#include <stdio.h>
#include <ctype.h>
#include <sys/time.h>
#include <sys/types.h>

#define MAX_QUEUE_SIZE 2048
#define SERIAL_PORT_ENB

struct termios orig_termios;
fd_set input_set;
struct timeval timeout;

unsigned char *memory;

uint8_t nmi = 1;
uint8_t rst = 1;
uint8_t irq = 1;

/*
================================================================================
Type definition and methods for a ring buffer to hold terminal input before the
specification actually tries to read from the serial port. This should probably
be made "safer" in future since right now there are no protections against
overflow but I'm pretty sure no one is able to input >2K chars before BASIC
reads some...
================================================================================
*/

typedef struct {
	unsigned char buf[MAX_QUEUE_SIZE];
	int tail;
	int head;
} Queue;
Queue inp_buffer = {.head = -1, .tail = 0};

void enqueue(unsigned char ch)
{
	inp_buffer.buf[inp_buffer.tail] = ch;
	inp_buffer.tail = (inp_buffer.tail + 1) % MAX_QUEUE_SIZE;
}

unsigned char dequeue()
{
	inp_buffer.head = (inp_buffer.head + 1) % MAX_QUEUE_SIZE;
	return inp_buffer.buf[inp_buffer.head];
}

int inp_buffer_empty()
{
	if (inp_buffer.tail - inp_buffer.head == 1)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

/*
================================================================================
Helper methods for initialising the terminal into "raw" mode. This is required
for disabling buffered input and terminal echoing so that the specification can
munch chars off of the stdin whenever they are made available (ie. when the key
gets pressed) rather than waiting for a newline
================================================================================
*/

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

/*
================================================================================
Helper methods for polling for user input from the terminal. try_read_char gets
a single char from stdin and returns a null (0) when it can't find anything.
consume_input loops getting chars using try_read_char until there's nothing left
to read and stores characters in the input buffer.
================================================================================
*/

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
		#ifdef SERIAL_PORT_ENB
			// convert '\n' chars to carriage returns
			if (nxt == 0xA)
				nxt = 0xD;

			// convert backspaces
			if (nxt == 0x7F)
				nxt = 0x08;
		#endif
			enqueue(nxt);
		}
	} while (nxt);
	

	return UNIT;
}

/*
================================================================================
Memory methods for the specification to use, does pretty much what it says on
the tin. memory_init is just a memory allocation that initializes to zero,
mem_read and mem_write do what they're meant to and load_binary is a helper
to read bytes from a file into the "memory" data structure.
================================================================================
*/


unit memory_init(const unit u)
{
	memory = calloc((0b1 << 16), sizeof(unsigned char));

	return UNIT;
}

uint8_t mem_read(const sail_int addr)
{
	unsigned char nxt;
	int loc = mpz_get_ui(addr);

	switch (loc)
	{
	#ifdef SERIAL_PORT_ENB
		case 0x8400:
			if (inp_buffer_empty())
			{
				return 0;
			}
			else
			{
				return dequeue();
			}
		case 0x8401:
			if (inp_buffer_empty())
			{
				return 0;
			}
			else
			{
				return 0x08;
			}
	#endif
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
	#ifdef SERIAL_PORT_ENB
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
	#endif
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

/*
================================================================================
Helpers to get (and accordingly reset) the nmi, rst, and irq variables
================================================================================
*/

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