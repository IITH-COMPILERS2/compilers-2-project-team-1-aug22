# **`CoPro`**
Domain specific language designed to solve complex **conic section problems**.

In this project every section has sepearte directory and each section has its own code.

Every directory has 'PPT and videos', ppt's directory which has our explanations, 'testCases' directory which has test cases and a Makefile for executing the programs.

For running a particular directory files just change directory to that one and execute `make` command
## **[`Lexer`](./Lexer/)**
- In lexer part we have only one lex file which just return tokens to a text file.
- When folder is executed testcases will be runned and output files are created in a new directory.
## **[`Parser`](./Parser/)**
- In parser we have added basic symbol table and abstract syntax tree.
- When folder is executed testcases will be exectued and output will be generated in the termial itself.
## **[`Semantics`](./Semantics/)**