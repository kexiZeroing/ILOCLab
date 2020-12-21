Generating ILOC from DEMO

# About source code
- myscanner.l: Specification input file for Flex
- myparser.y: Specification input file for Bison
- symbolTable.c: The entry in symbolTable, non-terminal's type structure, and useful functions in hash table are defined here
- myiloc.c: All the opcode, iloc emit format are defined here
- main.c: Driver that parses command line arguments and invokes the parser
- Makefile: List of rules how to (re)compile the source code
- test/: Including test cases that professor give us on clear
- test1.demo to test7.demo are my own test cases.


# How to build: make command
Use Make (rules in Makefile) to build the scanner and parser.
Make clean to delete the demo and all of the iloc files.

# How to execute
    ./demo -h
        see the help menu.
    ./demo [filename]
        compile the file.
        if the filename is missing, the parser will read from stdin (twice ctrl+d means EOF)
	    if the filename is invalid, it will print an error.
        generate the [filename].i file if parsing succeeds. And use this file as the input to simulater to get the result.
    ./demo -s [filename]
        print the symbol table including information about name, type, address, dimension, etc.
