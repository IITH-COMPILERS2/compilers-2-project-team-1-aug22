#ifndef ERRORS
#define ERRORS

#define ERROR_1(text, line) "Line " + to_string(line) + ": Variable name \"" + text + "\" is a reserved keyword.\n"
#define ERROR_2(text, line) "Line " + to_string(line) + ": Redeclaration of Variable \"" + text + "\"\n"
#define ERROR_3(text, line) "Line " + to_string(line) + ": Variable \"" + text + "\" undeclared.\n"
#define ERROR_4(line) "Line " + to_string(line) + ": Type mismatch\n"
#define ERROR_5(line) "Line " + to_string(line) + ": ReturnType mismatch\n"

#endif