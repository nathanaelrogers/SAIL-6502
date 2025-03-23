#ifndef IO_H
#define IO_H

#include <stdio.h>
#include "sail.h"

unit setup_terminal(const unit u);
unit print_char(const sail_int c);
uint64_t try_read_char(const unit u);

#endif