#ifndef IO_H
#define IO_H

#include <stdio.h>
#include "sail.h"

unit terminal_init(const unit u);
unit memory_init(const unit u);

unit print_char(const sail_int c);
uint64_t try_read_char(const unit u);

uint64_t mem_read(const sail_int addr);
unit mem_write(const sail_int addr, const sail_int data);

unit load_binary(const sail_string path, const sail_int start_addr);

#endif