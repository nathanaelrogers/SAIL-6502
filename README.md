# A Sail Specification For 6502 #

This repository contains my 6502 Sail specification, as well as supporting code and tests

## Repository Structure ##
```
.
├── Makefile
├── README.md
├── as65_142/
├── coverage_data/
├── coverage_results/
├── fake6502
│   ├── driver.c
│   └── fake6502.h
├── gen_cov_results.sh
├── io.c
├── io.h
├── main.sail
├── sail_src/
├── sailcov
└── test
    ├── enhancedbasic
    ├── enhancedbasic.py
    ├── parallel_results/
    ├── sourcefiles/
    ├── test_bcd.py
    ├── test_cyclecount.py
    ├── test_functional.py
    ├── test_parallel.py
    └── util.py

24 directories, 253 files
```
* The `as65_142` directory contains a copy of the `as65` assembler for the 6502, which is used to build the functional test by Klaus Dormann https://github.com/Klaus2m5/6502_65C02_functional_tests (see `test/sourcefiles`)

* The `fake6502` directory contains a copy of a 6502 emulator written in C and iterated on by several people https://github.com/C-Chads/MyLittle6502, along with some driver code I wrote to use it in tests (`driver.c`)

* The `coverage_data` directory contains branch data used by `sailcov` for making specification coverage results. The actual HTML output can be found in the `coverage_results` directory.

* The `test` directory contains lots of bits of source code for tests and programs, some of it mine and some of it not! Other than the functional test I already mentioned, 
shout out to Bruce Clark's BCD test http://www.6502.org/tutorials/decimal_mode.html#B (`test/sourcefiles/BCD`) and the Enhanced BASIC sourcecode I found here https://codeberg.org/calebccff/6502.sh (`test/enhancedbasic/`).

* To have a look at **my code**, take a gander at `main.sail`, `io.c`, and all of the Sail code in `sail_src/`!

* The process used to build and run the specification is a little convoluted but usually involves:
	1. Modifying the Sail source so it's trying to load the correct binary
	2. Generating up to date C code from the modified Sail source
	3. Compiling and running the generated C code.

* There are python scripts to handle all of this for you! Have a look at the requirements section then the demo should work relatively pain free.

## Requirements ##

Before building anything in this project, you'll need to install Sail on your system: https://github.com/rems-project/sail

And then edit the Makefile with the path to the Sail install on your system, which typically looks something like this: `SAIL_DIR = /home/<your_username>/.opam/default/share/sail/lib`

For everything in the project to work, you'll need Sail installed, as well as the following tools: `cc65`, `acme`, `python`, and `pytest`.

## Demonstration ##

I've included a script to load and run the model with the BASIC ROM already compiled. Assuming you have all the requirements set up correctly, simply run `python test/enhancedbasic.py` and it will automatically begin executing the BASIC program using the compiled specification when it is ready. You can use CTRL+R to trigger reset signals and you can type in commands to BASIC as you would expect :)