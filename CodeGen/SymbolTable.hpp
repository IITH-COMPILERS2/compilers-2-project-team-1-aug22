#ifndef SYMBOLTABLE
#define SYMBOLTABLE

#include <bits/stdc++.h>
#include "Errors.hpp"

using namespace std;

int q;
string type;
int value = 1;
string ret_type;
int sign = 1;
int is_identifier_sign = 1;
bool is_conic_id = 0;
extern int line_no;
int sem_errors = 0;
extern char* yytext;
string function_name;
map<int, int> scopes;
bool is_function_now = false;
vector<string> function_params;
vector<string> fun_call_params;
vector<pair<string, string>> param_id;
vector<string> errors;
vector<string> keywords = {"void", "int", "bool", "double", "point", "string", "line", "conic", "loop", 
						  "circle", "parabola", "ellipse", "if", "frac", "true", "false", "line_pair",
 						 "hyperbola", "else", "break", "continue"};

struct dataType {
    string data_type;
    string type;
    int line_no;
	vector<string> params;
};
typedef struct dataType dataType;

struct scope_table{
	map<string, int> scope_table_util;
	map<int, dataType*> symbol_info;
	string scope;
	string fun_ret_type;
};
typedef struct scope_table scope_table;

vector<scope_table*> symbol_table;

void add(char);
int search(string);
void insert_type();
void set_value(string, int);
void add_params(string, string);
void newentry(string, int, string, int);

void enter_scope();
void exit_scope();

void ScopeTableGenerator(scope_table*);
void SymbolTableGenerator();


void insert_type() {
	type = yytext;
}

int search (string type) {
	if(symbol_table.back()->symbol_info.find(symbol_table.back()->scope_table_util[type]) == symbol_table.back()->symbol_info.end())
		return 0;
	return -1;
}

void set_value(string yytext, int value) {
	symbol_table.back()->scope_table_util[yytext] = value;
}

void newentry(string data_type, int line_no, string type, int value) {
	dataType* temp = new dataType;
	temp->data_type = data_type;
	temp->line_no = line_no;
	temp->type = type;
	symbol_table.back()->symbol_info[value] = temp;
}

void add (char c) {
  	q = search(yytext);
  	if(!q) {
		if(c == 'H') {
			set_value(yytext, value);
			newentry("", line_no, "Header", value);
		}
		else if(c == 'F') {
			set_value(function_name, value);
			newentry(ret_type, line_no, "Function", value);
		}
		else if(c == 'K') {
			set_value(yytext, value);
			newentry("N/A", line_no, "Keyword", value);
		}
		else if(c == 'V') {
			for (auto x : keywords) {
				string temp = yytext;
				if (x == temp) {
					errors.push_back(ERROR_1(temp, line_no));
					sem_errors++;
					return;
				}
			}
			set_value(yytext, value);
			newentry(type, line_no, "Variable", value);
		}
		else if(c == 'C') {
			set_value(yytext, value);
			newentry("CONST", line_no, "Constant", value); 
		}
		value++;
	}
	else {
		if(c == 'V'){
			if(symbol_table.back()->symbol_info.find(symbol_table.back()->scope_table_util[yytext]) != symbol_table.back()->symbol_info.end()){
				errors.push_back(ERROR_2(yytext, line_no));
				sem_errors++;
				return;
			}
		}
	}
}

void add_params(string type, string id) {
	q = search(id);
  	if(!q) {
		for (auto x : keywords) {
				string temp = id;
				if (x == temp) {
					errors.push_back(ERROR_1(temp, line_no));
					sem_errors++;
					return;
				}
			}
		set_value(id, value);
		newentry(type, line_no, "Variable", value);
		value++;
	}
}

void enter_scope() {
	scope_table* newscope = new scope_table;
	symbol_table.push_back(newscope);
	string scope;
	for(int i = 0; i < symbol_table.size(); ++i) {
		scope += to_string(scopes[i + 1] + 1);
		if(i != symbol_table.size() - 1) {
			scope += '.';
		}
	}
	symbol_table.back()->scope = scope;
}


void exit_scope() {
	ScopeTableGenerator(symbol_table.back());
	scope_table* temp = symbol_table.back();
	scopes[symbol_table.size()]++;
	symbol_table.pop_back();
	free(temp);
}

void ScopeTableGenerator(scope_table* s) {
	cout << right << setw(30) << "SCOPE TABLE " << s->scope << "\n";
	cout << right << setw(40) << "~~~~~~~~~~~~~~~~~~~~~~~\n\n";
	cout << "\t" << left << setw(10) << "SYMBOL" << left << setw(10) << "DATATYPE" 
			<< left << setw(15) << "TYPE" << left << setw(3) << "LINE_NUMBER\n";

	for(auto i : s->symbol_info) {
		string symbol;
		for(auto j : s->scope_table_util)
			if(j.second == i.first)
				symbol = j.first;
		
		cout << "\t" << left << setw(10) << symbol << left << setw(10) << i.second->data_type
				<< left << setw(15) << i.second->type << left << setw(3) << i.second->line_no << "\n";
		// if(i.second->type == "Function") {
		// 	for(auto j : i.second->params) {
		// 		cout << j << " ";
		// 	}
		// }
	}
	cout << "\n";
}

void SymbolTableGenerator() {
	for(auto i : symbol_table) {
		ScopeTableGenerator(i);
	}
}

int print() {
	cout << symbol_table.size() << "\n";
	return 1;
}

#endif