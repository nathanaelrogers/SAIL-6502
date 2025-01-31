# Compiler and flags
SAIL = sail
GCC = gcc
CFLAGS = -lgmp -lz -I /home/nathanael/.opam/default/.opam-switch/sources/sail.0.18/lib/

# Source files
SAIL_SRC = main.sail
LIB_PATH = /home/nathanael/.opam/default/.opam-switch/sources/sail.0.18/lib/*.c

# Output files
SAIL_OUT = out

# Default target
all: $(SAIL_OUT)

# Compile Sail source and C code
$(SAIL_OUT): $(SAIL_SRC)
	$(SAIL) -c $(SAIL_SRC) -o out -O
	$(GCC) out.c -O3 -g $(LIB_PATH) $(CFLAGS) -o $(SAIL_OUT)


# Clean up generated files
clean:
	rm -f *.txt
	rm -f out.c $(SAIL_OUT)
	rm -f z3_problems