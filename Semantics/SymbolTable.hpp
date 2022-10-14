#include <bits/stdc++.h>

using namespace std;

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

map<string, struct dataType*> symbol_table;

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
	if(symbol_table.find(type) == symbol_table.end())
		return 0;
	else return -1;
}

struct dataType* newentry(string data_type, int line_no, string type) {
	struct dataType* temp = new struct dataType;
	temp->data_type = data_type;
	temp->line_no = line_no;
	temp->type = type;
	return temp;
}

void add (char c) 
{
	if (c == 'V')
	{
		for (auto x: keywords)
		{
			if (x == yytext)
			{
				string tmp = "Line " + to_string(line_no+1) + ": Variable name " + yytext + " is a reserved keyword.\n";
				errors.push_back(tmp);
				sem_errors++;
				return;
			}
		}
	}
  	q = search(yytext);
  	if(!q) {
		if(c == 'H') {
			symbol_table.insert(symbol_table.end(), {yytext, newentry("", line_no, "Header")});
		}
		else if(c == 'F') {
			symbol_table.insert(symbol_table.end(), {yytext, newentry("N/A", line_no, "Function")});
		}
		else if(c == 'K') {
			symbol_table.insert(symbol_table.end(), {yytext, newentry("N/A", line_no, "Keyword")});
		}
		else if(c == 'V') {
			symbol_table.insert(symbol_table.end(), {yytext, newentry(type, line_no, "Variable")});
		}
		else if(c == 'C') {
			symbol_table.insert(symbol_table.end(), {yytext, newentry("CONST", line_no, "Constant")});
		}
	
	}
	else if (c=='V' && q)
	{
		string tmp = "Line " + to_string(line_no+1) + ": Multiple declarations of " + yytext + " not allowed.\n";
		errors.push_back(tmp);
		sem_errors++;
	}
}

void insert_type() {
	type = yytext;
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

void SymbolTableGenerator() {
	cout << setw(30) << "SYMBOL TABLE\n\n";
	cout << "\t" << left << setw(10) << "SYMBOL" << left << setw(10) << "DATATYPE" 
			<< left << setw(15) << "TYPE" << left << setw(3) << "LINE_NUMBER\n";

	for(auto i = symbol_table.begin(); i != symbol_table.end(); ++i) {
		cout << "\t" << left << setw(10) << i->first << left << setw(10) << i->second->data_type
				<< left << setw(15) << i->second->type << left << setw(3) << i->second->line_no << "\n";
	}
	// for(auto i : symbol_table){
	// 	free(i.second);
	// }
	cout << "\n\n";
}


void check_declarations(string c) 
{
	if(!search(c))
	{	
		string tmp = "Line " + to_string(line_no+1) + ": Variable \"" + c + "\" undeclared.\n";
		errors.push_back(tmp);
		sem_errors++;
	}
}

void check_return_type(string value)
{
	string main_dt = get_type("main");
	string return_dt = get_type(value);

	if ((main_dt == "int" && return_dt == "CONST") || (main_dt == return_dt))
	{
		return;
	}
	else
	{
		string tmp = "Line " + to_string(line_no+1) + ": Exit type does not match with the function declaration.\n";
		errors.push_back(tmp);
		sem_errors++;
	}
}

int check_types(string type1, string type2)
{
	if (type2 == "null")
		return -1;
	
	if (type1 == type2)
		return 0;

	return 1;

}

string get_type(string var)
{
  	auto itr = symbol_table.find(var);
  	if(itr != symbol_table.end())
	{
	 	return itr->second->data_type;
	}
}


