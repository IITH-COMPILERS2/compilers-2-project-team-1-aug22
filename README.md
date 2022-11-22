# **`CoPro`**
CoPro is a domain specific language which has been designed to help solve complex **conic section problems**.

In this project, every step of the compiler has a separate directory and each step has its own code.

Each directory consists of multiple sections specific to that directory. However, every directory necessarily consists of 
'PPT and Videos', which has a presentation and a couple videos explaining that particular section of compiler and the directory, 'testCases', which contains test cases checking that part of the compiler, and a 'Makefile' which is used to 
run the code.

When you want to run a particular directory files, just move into that directory and execute the `make` command to run that section of our compiler.
## **[`Lexer`](./Lexer/)**
- In the Lexer part of the compiler, other than the files which are common to all the directories, 
we have one other file 'lexer.l' which has the lexer of our compiler. The lex file goes through all of the test case files present in 'testCases', analyzes them and outputs tokens into a text file.
- When this directory is executed using the 'make' command, all of the testcases would run and the output text files would be generated in a new directory.
## **[`Parser`](./Parser/)**
- In the Parser directory, we have two additional files 'project.l' and 'project.y'. 'project.l' is the modified lexical analyzer that send the tokens to the parser and 'project.y' is the parser of our language. The parser of our language generates a basic symbol table and an abstract syntax tree pertaining to the code.
- When this directory is executed using the 'make' command, all of the testcases present in the 'testCases' folder would run and the result would be output onto the terminal itself.
## **[`Semantics`](./Semantics/)** 
- In the semantics directory, we have multiple additional files like 'AST.hpp', 'Errors.hpp', 'Semantics.hpp' and 'SymbolTable.hpp'. 'AST.hpp' contains declarations pertaining to the abstract syntax tree, 'Errors.hpp' contains definitions and formats of error messages, 'Semantics.hpp' contains definitions of functions pertaining to error checks, and 'SymbolTable.hpp' contains all the code related to the updated symbol table built in this phase. 'project.y' contains code of our parser with updated actions related to error checks and building of our latest symbol table.
- When this directory is executed using the 'make' command, all of the testcases present in the 'testCases' folder would undergo semantic checks. All of the utility files generated such as 'project.lex.cpp' etc. are put inside the 'util_files' folder. The .txt output file, containing the printed output of the proper symbol table along with scopes, all the errors generated in the semantics phase, and the pre-order traversal of our AST would be generated and put inside 'SymbolTables_ASTs' folder.

## **[`Code Generation`](./CodeGen/)**
- In the CodeGen directory, a lot more folders are present such as 'AssemblyFiles', 'gccObjects' etc. along with new files such as 'AST.hpp'. The file 'OldAst.hpp' contains the older version of our AST, used until the Semantics phase. The file 'AST.hpp' contains all the code related to building the new AST and code related to code generation.
- When this directory is executed using the 'make' command, all of the testcases present in the 'testCases' folder will first have their respective new AST's built up, saved inside 'SymbolTables_ASTs' file, also their respective llvm outputs (.ll files) are put inside 'llvmOutputs' file. Using this, the corresponding assembly files (.s files) would be created inside 'AssemblyFiles' folder. Using this folder, both gcc object files (.out files) and llvm object files (.bc files) would be generated and put inside 'gccObjects' and 'llvmObjects' folders respectively.
- One could run whichever object file they want.
- To run gcc object files, type in command:

        $ ./gccObjects/filenumber.out
- Similarly if you want to run llvm object files, type in command:

        $ lli /llvmObjects/filenumber.bc