#ifndef SEMANTICS
#define SEMANTICS

#include "SymbolTable.hpp"


void check_declaration(string);
void check_return_types(char type1[], char type2[]);
int check_types(string, string);
string get_type(string);
void SemanticErrors();

void check_declarations(string c) {
	if(!search(c)) {
		errors.push_back(ERROR_3(c, line_no));
		sem_errors++;
	}
}

void check_return_types(char type1[], char type2[]) {
	if(strcmp(type1, type2) != 0) {
		errors.push_back(ERROR_5(line_no - 1));
		sem_errors++;
	}
}

int check_types(char type1[], char type2[]) {
	if (strcmp(type2, "null") == 0){
		errors.push_back(ERROR_4(line_no - 1));
		return -1;
	}
	
	if (strcmp(type1, type2) == 0)
		return 0;
	
	errors.push_back(ERROR_4(line_no - 1));
	sem_errors++;
	return 1;
}

string get_type(string var) {
  	auto itr = symbol_table.back()->symbol_info.find(symbol_table.back()->scope_table_util[var]);
  	if(itr != symbol_table.back()->symbol_info.end()) {
	 	return itr->second->data_type;
	}
	return "Incorrect type";
}

void SemanticErrors() {
	cout << "\n\n";
	if (sem_errors > 0) {
		cout << "Semantic analysis completed with " << sem_errors << " errors\n\n";
		for (int i=0; i < sem_errors; i++)
			cout << "Error " << i + 1 << ": " << errors[i];
	}
	else {
		cout << "Semantic analysis completed with no errors" << endl;
	}
	cout << "\n\n";
}


#endif