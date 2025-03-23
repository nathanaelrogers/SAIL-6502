#ifndef IO_H
#define IO_H

#include <stdio.h>
#include "sail.h"

unit print_char(const sail_int c);

void try_read_char(sail_int *input_buffer, const unit u);

#endif