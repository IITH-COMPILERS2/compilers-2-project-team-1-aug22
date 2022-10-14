#include <bits/stdc++.h>

using namespace std;

extern char* yytext;
void add(char);
void insert_type();
int search(string);
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
extern int token_no;
int q;

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

void add (char c) {
  	q = search(yytext);
  	if(!q) {
		if(c == 'H') {
			symbol_table.insert(symbol_table.end(), {yytext, newentry("", token_no, "Header")});
		}
		else if(c == 'F') {
			symbol_table.insert(symbol_table.end(), {yytext, newentry("N/A", token_no, "Function")});
		}
		else if(c == 'K') {
			symbol_table.insert(symbol_table.end(), {yytext, newentry("N/A", token_no, "Keyword")});
		}
		else if(c == 'V') {
			symbol_table.insert(symbol_table.end(), {yytext, newentry(type, token_no, "Variable")});
		}
		else if(c == 'C') {
			symbol_table.insert(symbol_table.end(), {yytext, newentry("CONST", token_no, "Constant")});
		}
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