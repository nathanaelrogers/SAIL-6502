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

void disableRawMode() {
	tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_termios);
}

void enableRawMode() {
	tcgetattr(STDIN_FILENO, &orig_termios);
	atexit(disableRawMode);

	struct termios raw = orig_termios;
	raw.c_lflag &= ~(ECHO | ICANON);

	tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw);
  }

unit setup_terminal(const unit u) {
	enableRawMode();

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

	timeout.tv_sec = 1;
	timeout.tv_usec = 0; // 100 us enough?

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