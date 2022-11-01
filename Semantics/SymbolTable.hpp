#include <bits/stdc++.h>

using namespace std;

#define ERROR_1(text, line) "Line " + to_string(line) + ": Variable name \"" + text + "\" is a reserved keyword.\n"
#define ERROR_2(text, line) "Line " + to_string(line) + ": Redeclaration of Variable \"" + text + "\"\n"
#define ERROR_3(text, line) "Line " + to_string(line) + ": Variable \"" + text + "\" undeclared.\n"
#define ERROR_4(line) "Line " + to_string(line) + ": Type mismatch\n"

extern char* yytext;
void add(char);
void insert_type();
int search(string);

void check_declaration(string);
void check_return_type(string);
int check_types(string, string);
string get_type(string);

void SymbolTableGenerator();

struct dataType {
    string data_type;
    string type;
    int line_no;
};
typedef struct dataType dataType;

int value = 1;
struct scope_table{
	map<string, int> scope_table_util;
	map<int, dataType*> symbol_info;
};
typedef struct scope_table scope_table;

vector<scope_table*> symbol_table;

struct node {
    struct node *left; 
    struct node *right; 
    string token; 
};

struct node *head;
void printtree(struct node*);
void printPreorder(struct node *);
struct node* mknode(struct node *left, struct node *right, string token);

string type;
extern int line_no;
int q;

int sem_errors = 0;
int label = 0;
string buff;
// char errors[10][100];
vector<string> errors;
vector<string> keywords = {"void", "int", "bool", "double", "point", "string", "line", "conic", "loop", 
						  "circle", "parabola", "ellipse", "if", "frac", "true", "false", "line_pair",
 						 "hyperbola", "else", "break", "continue"};

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
			// scope_table_util[yytext] = value;
			// symbol_info[value] = newentry();
		}
		else if(c == 'F') {
			set_value(yytext, value);
			newentry("N/A", line_no, "Function", value);
			// scope_table_util[yytext] = value;
			// symbol_info[value] = newentry("N/A", line_no, "Function");
		}
		else if(c == 'K') {
			set_value(yytext, value);
			newentry("N/A", line_no, "Keyword", value);
			// scope_table_util[yytext] = value;
			// symbol_info[value] = newentry("N/A", line_no, "Keyword");
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
			// scope_table_util[yytext] = value;
			// symbol_info[value] = newentry(type, line_no, "Variable");
		}
		else if(c == 'C') {
			set_value(yytext, value);
			newentry("CONST", line_no, "Constant", value); 
			// scope_table_util[yytext] = value;
			// symbol_info[value] = newentry("CONST", line_no, "Constant");
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

void insert_type() {
	type = yytext;
}

void check_declarations(string c) {
	if(!search(c)) {
		errors.push_back(ERROR_3(c, line_no));
		sem_errors++;
	}
}

void check_return_type(string returning_value) {
	string main_dt = get_type("main");
	string return_dt = get_type(returning_value);

	if ((main_dt == "int" && return_dt == "CONST") || (main_dt == return_dt)) {
		return;
	}
	else {
		string tmp = "Line " + to_string(line_no+1) + ": Exit type does not match with the function declaration.\n";
		errors.push_back(tmp);
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

	// if (type1 == "int" && type2 == "double")
	// 	return 1;

	// if (type1 == "double" && type2 == "int")
	// 	return 2;
	
	// if (type1 == "int" && type2 == "bool")
	// 	return 3;
	
	// if (type1 == "bool" && type2 == "int")
	// 	return 4;

	// if (type1 == "conic" && type2 == "line")
	// 	return 5;

	// if (type1 == "conic" && type2 == "line_pair")
	// 	return 6;
	
	// if (type1 == "conic" && type2 == "circle")
	// 	return 7;

	// if (type1 == "conic" && type2 == "parabola")
	// 	return 8;

	// if (type1 == "conic" && type2 == "ellipse")
	// 	return 9;

	// if (type1 == "conic" && type2 == "hyperbola")
	// 	return 10;

	// if (type1 == "line" && type2 == "conic")
	// 	return 11;

	// if (type1 == "line_pair" && type2 == "conic")
	// 	return 12;
	
	// if (type1 == "circle" && type2 == "conic")
	// 	return 13;
	
	// if (type1 == "parabola" && type2 == "conic")
	// 	return 14;
	
	// if (type1 == "ellipse" && type2 == "conic")
	// 	return 15;
	
	// if (type1 == "hyperbola" && type2 == "conic")
	// 	return 16;
	
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

void enter_scope() {
	scope_table* newscope = new scope_table;
	symbol_table.push_back(newscope);
}

void ScopeTableGenerator(scope_table* s) {
	cout << setw(30) << "SCOPE TABLE\n\n";
	cout << "\t" << left << setw(10) << "SYMBOL" << left << setw(10) << "DATATYPE" 
			<< left << setw(15) << "TYPE" << left << setw(3) << "LINE_NUMBER\n";

	for(auto i : s->symbol_info) {
		string symbol;
		for(auto j : s->scope_table_util)
			if(j.second == i.first)
				symbol = j.first;
		
		cout << "\t" << left << setw(10) << symbol << left << setw(10) << i.second->data_type
				<< left << setw(15) << i.second->type << left << setw(3) << i.second->line_no << "\n";
	}
}

void exit_scope() {
	ScopeTableGenerator(symbol_table.back());
	scope_table* temp = symbol_table.back();
	symbol_table.pop_back();
	free(temp);
}

void SymbolTableGenerator() {
	for(auto i : symbol_table) {
		ScopeTableGenerator(i);
	}
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

struct node* mknode(struct node *left, struct node *right, string token) {
	struct node *newnode = (struct node *)malloc(sizeof(struct node));
	string newstr = token;
	newnode->left = left;
	newnode->right = right;
	newnode->token = newstr;
	return(newnode);
}

void printtree(struct node* tree) {
	cout << "\n\n Preorder traversal of the Parse Tree: \n\n";
	printPreorder(tree);
	cout << "\n\n";
}

void printPreorder(struct node *tree) {
	int i;
	cout << tree->token << " ";
	if (tree->left) {
		printPreorder(tree->left);
	}
	if (tree->right) {
		printPreorder(tree->right);
	}
}

int print() {
	cout << symbol_table.size() << "\n";
	return 1;
}