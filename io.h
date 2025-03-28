#ifndef IO_H
#define IO_H

#include <stdio.h>
#include "sail.h"

unit terminal_init(const unit u);
unit memory_init(const unit u);

uint8_t mem_read(const sail_int addr);
unit mem_write(const sail_int addr, const sail_int data);

unit load_binary(const sail_string path, const sail_int start_addr);

#endif