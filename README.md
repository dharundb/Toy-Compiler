
# Toy Compiler for Binary to Decimal Converter

The toy compiler designed here covers the first 2 phases of compilers.
It takes the input as a C program, produces tokens, checks whether the 
program is syntactically correct or not and also constructs a symbol table.
- Lexical Analyser
- Syntax Analyser

## Lexical Analyser

Lexical Analyser - Takes in the C program and produces tokens based on 
the input, which will be given as the input to syntax Analyser.

## Tool Used

![Logo](https://cdn.ecommercedns.uk/files/4/228344/5/6538365/lex-logo-w300.jpg)

## Syntax Analyser 

Syntax Analyser - Takes in the input from lexical Analyser and checks
whether the program is syntactically correct or not with predefined
grammar rules and productions.

## Tool Used 

![Logo](https://static.javatpoint.com/compiler/images/yacc1.png)

## Commands to Run the project

```bash
$ lex filename.l
```
```bash
$ yacc filename.y
```
```bash
$ gcc y.tab.c -lfl -lm
```
```bash
$ ./a.out < input_c_file.c
```

