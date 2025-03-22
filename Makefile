# Compiler and flags
SAIL = sail
GCC = gcc
SAIL_DIR = /home/nathanael/.opam/default/share/sail/lib
CFLAGS = -lgmp -lz -I $(SAIL_DIR)
COVERAGE_FLAGS = $(SAIL_DIR)/coverage/libsail_coverage.a -lpthread -ldl

# Source files
SAIL_SRC = main.sail
LIB_PATH = $(SAIL_DIR)/*.c

SAIL_OUT = out

# Default target
all: $(SAIL_OUT)

# Compile Sail source and C code
$(SAIL_OUT): $(SAIL_SRC)
	$(SAIL) -c $(SAIL_SRC) -o $(SAIL_OUT) -O -c_include mmio.h
	$(GCC) *.c -O3 -g $(LIB_PATH) $(CFLAGS) -o $(SAIL_OUT)

gen-with-coverage:
	$(SAIL) -c -c_coverage all_branches -c_include sail_coverage.h $(SAIL_SRC) -o out -O

compile-with-coverage:
	$(GCC) out.c -O3 -g $(LIB_PATH) $(CFLAGS) $(COVERAGE_FLAGS) -o $(SAIL_OUT)

# Clean up generated files
clean:
	rm -rf out.c $(SAIL_OUT) z3_problems __pycache__ .pytest_cache