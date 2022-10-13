%{
	#include <bits/stdc++.h>
	#include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include <ctype.h>
	using namespace std;
    /*#include "project.lex.c"*/
    
	extern char* yytext;
    void yyerror(string s);
    int yylex();
    int yywrap();
    void add(char);
    void insert_type();
    int search(string);

    struct dataType {
        string id_name;
        string data_type;
        string type;
        int line_no;
    } symbol_table[10000];		/* see this */

    int Count=0;
    int q;
    string type;
    extern int token_no;
	
	struct node *head;
    struct node {
		struct node *left; 
		struct node *right; 
		string token; 
    };
    void printtree(struct node*);
    void printPreorder(struct node *);
    struct node* mknode(struct node *left, struct node *right, string token);

%}

%union { 
	struct var_name { 
		char name[100]; 
		struct node* nd;
	} nd_obj; 
} 



%token <nd_obj> IDENTIFIER FRAC_CONST DOUBLE_CONST INT_CONST STRING_LITERAL
%token ARROW LE_OP GE_OP EQ_OP NE_OP POW_OP
%token AND_OP OR_OP MUL_ASSIGN ADD_ASSIGN
%token FUN_ST FUN_EN

%token STRING INT LONG BOOL FRAC DOUBLE VOID EOL
%token TRUE FALSE
%token INPUT OUTPUT

%token IF ELSE LOOP CONTINUE BREAK EXIT

%token POINT LINE CONIC LINE_PAIR CIRCLE PARABOLA ELLIPSE HYPERBOLA

%type <nd_obj> translation_unit external_declaration function_definition parameter_list parameters type_specifier 
  compound_statement expression_statement expression assignment_expression
  assignment_operator conditional_expression logical_or_expression logical_and_expression
  equality_expression relational_expression additive_expression multiplicative_expression
  cast_expression unary_expression unary_operator postfix_expression primary_expression
  argument_expression_list statement_list statement declaration_list declaration 
  declaration_specifiers init_declarator_list init_declarator initializer_list declarator
  direct_declarator identifier_list initializer selection_statement iteration_statement jump_statement

%start translation_unit

%%

translation_unit
	: external_declaration { $$.nd = mknode(NULL, $1.nd, "TRANSLATION_UNIT"); head = $$.nd; }
	| translation_unit external_declaration { $2.nd = mknode(NULL, NULL, "TRANSLATION_UNIT"); $$.nd = mknode($1.nd, $2.nd, "TRANSLATION_UNIT"); head = $$.nd; }
	;

external_declaration
	: function_definition { $$.nd = mknode(NULL, $1.nd, "EXTERNAL_DECLR"); }
	| declaration
	;

function_definition
    : IDENTIFIER { add('F'); } parameter_list ARROW type_specifier EOL compound_statement { 
		struct node* tp = mknode($3.nd, $5.nd, "OPTIONS");
		$$.nd = mknode(tp, $7.nd, $1.name); 
		} 
	;

parameter_list
	:
	| ':' parameters { $$.nd = mknode(NULL, $2.nd, "PARAMS_LIST"); }
	;

parameters
	: type_specifier IDENTIFIER { add('V'); 
			struct node* tp = mknode(NULL, NULL, $2.name);
			$$.nd = mknode($1.nd, tp, "PARAMS");
		}
	| parameters ',' type_specifier IDENTIFIER { add('V'); 
			struct node* tp = mknode(NULL, NULL, $4.name);
			struct node* tp2 = mknode($3.nd, tp, "VARIABLES");
			$$.nd = mknode($1.nd, tp2, "PARAMS");
		}
	;

type_specifier
	: VOID		{ insert_type(); }
	| BOOL		{ insert_type(); }
	| STRING	{ insert_type(); }
	| INT		{ insert_type(); }
	| LONG		{ insert_type(); }				
	| DOUBLE	{ insert_type(); }		
	| FRAC		{ insert_type(); }		
	| POINT		{ insert_type(); }		
	| PARABOLA	{ insert_type(); }		
	| ELLIPSE	{ insert_type(); }		
	| HYPERBOLA	{ insert_type(); }		
	| CIRCLE	{ insert_type(); }		
	| CONIC		{ insert_type(); }		
	| LINE		{ insert_type(); }		
	| LINE_PAIR	{ insert_type(); }
	;


compound_statement
	: FUN_ST FUN_EN								{$$.nd = mknode(NULL, NULL, "COMPUND STATEMENT"); }
	| FUN_ST statement_list FUN_EN				{$$.nd = mknode(NULL, $2.nd, "COMPUND STATEMENT"); }
	;

expression_statement
	: EOL
	| expression EOL	{$$.nd = mknode($1.nd, NULL, "EXPR_ST"); }
	;

expression
	: assignment_expression	{ $$.nd = mknode($1.nd, NULL, "EXPR"); }
	| expression ',' assignment_expression { $$.nd = mknode($1.nd, $3.nd, "EXPR"); }
	;

assignment_expression
	: conditional_expression	{ $$.nd = mknode($1.nd, NULL, "ASS_EXPR"); }
	| unary_expression assignment_operator assignment_expression { 
			struct node* tp = mknode($1.nd, $2.nd, "UN_ASSGN");
			$$.nd = mknode(tp, $3.nd, "ASS_EXPR");
		}
	;

assignment_operator
	: '='
	| MUL_ASSIGN
	| ADD_ASSIGN
	;

conditional_expression
	: logical_or_expression { $$.nd = mknode($1.nd, NULL, "COND_EXPR"); }
	;

logical_or_expression
	: logical_and_expression { $$.nd = mknode($1.nd, NULL, "LOGI_OR_EXPR"); }
	| logical_or_expression OR_OP logical_and_expression { $$.nd = mknode($1.nd, $3.nd, "OR"); }
	;

logical_and_expression
	: equality_expression { $$.nd = mknode($1.nd, NULL, "LOGI_AND_EXPR"); }
	| logical_and_expression AND_OP equality_expression { $$.nd = mknode($1.nd, $3.nd, "AND"); }
	;

equality_expression
	: relational_expression { $$.nd = mknode($1.nd, NULL, "EQ_EXPR"); }
	| equality_expression EQ_OP relational_expression { $$.nd = mknode($1.nd, $3.nd, "=="); }
	| equality_expression NE_OP relational_expression { $$.nd = mknode($1.nd, $3.nd, "!="); }
	;

relational_expression
	: additive_expression	{ $$.nd = mknode($1.nd, NULL, "RELATIONAL_EXPR"); }
	| relational_expression '<' additive_expression { $$.nd = mknode($1.nd, $3.nd, "<"); }
	| relational_expression '>' additive_expression { $$.nd = mknode($1.nd, $3.nd, ">"); }
	| relational_expression LE_OP additive_expression { $$.nd = mknode($1.nd, $3.nd, "<="); }
	| relational_expression GE_OP additive_expression { $$.nd = mknode($1.nd, $3.nd, ">="); }
	;

additive_expression
	: multiplicative_expression	{ $$.nd = mknode($1.nd, NULL, "ADDITIVE_EXPR"); }
	| additive_expression '+' multiplicative_expression { $$.nd = mknode($1.nd, $3.nd, "+"); }
	| additive_expression '-' multiplicative_expression { $$.nd = mknode($1.nd, $3.nd, "-"); }
	;

multiplicative_expression
	: cast_expression { $$.nd = mknode($1.nd, NULL, "MUL_EXPR"); }
	| multiplicative_expression '*' cast_expression { $$.nd = mknode($1.nd, $3.nd, "*"); }
	| multiplicative_expression '/' cast_expression { $$.nd = mknode($1.nd, $3.nd, "/"); }
	| multiplicative_expression '%' cast_expression { $$.nd = mknode($1.nd, $3.nd, "%"); }
	;

cast_expression
	: unary_expression { $$.nd = mknode($1.nd, NULL, "CAST_EXPR"); }
	| '(' type_specifier ')' cast_expression { $$.nd = mknode($2.nd, $4.nd, "CAST_EXPR"); }
	;

unary_expression
	: postfix_expression { $$.nd = mknode($1.nd, NULL, "UNARY_EXPR"); }
	| unary_operator cast_expression { $$.nd = mknode($1.nd, $2.nd, "UNARY_EXPR"); }
	;

unary_operator
	: '+'
	| '-'
	| '!'
	;

postfix_expression
	: primary_expression { $$.nd = mknode($1.nd, NULL, "POSTFIX_EXPR"); }
	| postfix_expression '(' ')' { $$.nd = mknode($1.nd, NULL, "POSTFIX_EXPR"); }
	| postfix_expression '(' argument_expression_list ')' { $$.nd = mknode($1.nd, $3.nd, "POSTFIX_EXPR"); }
	;

primary_expression
	: IDENTIFIER		 { add('V'); $$.nd = mknode(NULL, NULL, $1.name); }
	| INT_CONST			 { add('C'); $$.nd = mknode(NULL, NULL, $1.name); }
	| FRAC_CONST		 { add('C'); $$.nd = mknode(NULL, NULL, $1.name); }
	| DOUBLE_CONST		 { add('C'); $$.nd = mknode(NULL, NULL, $1.name); }
	| STRING_LITERAL	 { add('C'); $$.nd = mknode(NULL, NULL, $1.name); }
	| '(' expression ')' { $$.nd = mknode($2.nd, NULL, "PRIM_EXPR"); }
	;

argument_expression_list
	: assignment_expression { $$.nd = mknode($1.nd, NULL, "ARGU_EXPR_LIST"); }
	| argument_expression_list ',' assignment_expression { $$.nd = mknode($1.nd, $3.nd, "ARGU_EXPR_LIST"); }
	;

statement_list
	: statement	{ $$.nd = mknode($1.nd, NULL, "STAT_LIST"); }
	| statement_list statement { $$.nd = mknode($1.nd, $2.nd, "STAT_LIST"); }
	;

statement
	: declaration			{ $$.nd = mknode($1.nd, NULL, "STAT"); }
	| compound_statement	{ $$.nd = mknode($1.nd, NULL, "STAT"); }
	| expression_statement	{ $$.nd = mknode($1.nd, NULL, "STAT"); }
	| selection_statement	{ $$.nd = mknode($1.nd, NULL, "STAT"); }
	| iteration_statement	{ $$.nd = mknode($1.nd, NULL, "STAT"); }
	| jump_statement		{ $$.nd = mknode($1.nd, NULL, "STAT"); }
	;

declaration_list
	: declaration					{ $$.nd = mknode($1.nd, NULL, "DECLR_LIST"); }
	| declaration_list declaration	{ $$.nd = mknode($1.nd, $2.nd, "DECLR_LIST"); }
	;

declaration
	: declaration_specifiers EOL						{ $$.nd = mknode($1.nd, NULL, "DECLR"); }
	| declaration_specifiers init_declarator_list EOL	{ $$.nd = mknode($1.nd, $2.nd, "DECLR"); }
	;

declaration_specifiers
	: type_specifier						{ $$.nd = mknode($1.nd, NULL, "DECLR_SPCIF"); }
	| type_specifier declaration_specifiers	{ $$.nd = mknode($1.nd, $2.nd, "DECLR_SPCIF"); }
	;

init_declarator_list
	: init_declarator							{ $$.nd = mknode($1.nd, NULL, "INIT_DECLR_LIST"); }
	| init_declarator_list ',' init_declarator	{ $$.nd = mknode($1.nd, $3.nd, "INIT_DECLR_LIST"); }
	;

init_declarator
	: declarator						{ $$.nd = mknode($1.nd, NULL, "INIT_DECLR"); }
	| declarator '=' initializer		{ $$.nd = mknode($1.nd, $3.nd, "INIT_DECLR"); }
	| declarator ':' initializer_list 	{ $$.nd = mknode($1.nd, $3.nd, "INIT_DECLR"); }
	;

initializer_list
	: initializer						{ $$.nd = mknode($1.nd, NULL, "INIT_LIST"); }
	| initializer_list ',' initializer	{ $$.nd = mknode($1.nd, $3.nd, "INIT_LIST"); }
	;

declarator
	: direct_declarator					{ $$.nd = mknode($1.nd, NULL, "DECLR"); }
	;

direct_declarator
	: IDENTIFIER	{ add('V'); }				{ $$.nd = mknode(NULL, NULL, $1.name); }
	| '(' declarator ')'						{ $$.nd = mknode($2.nd, NULL, "DIRECT_DECLR"); }
	| direct_declarator '(' parameter_list ')'	{ $$.nd = mknode($1.nd, $3.nd, "DIRECT_DECLR"); }
	| direct_declarator '(' identifier_list ')'	{ $$.nd = mknode($1.nd, $3.nd, "DIRECT_DECLR"); }
	| direct_declarator '(' ')'					{ $$.nd = mknode($1.nd, NULL, "DIRECT_DECLR"); }			/* shift reduce conflict here similar to c lang */
	;

identifier_list
	: IDENTIFIER	{ add('V'); }						{ $$.nd = mknode(NULL, NULL, $1.name); }
	| identifier_list ',' IDENTIFIER	{ add('V'); }	{ $$.nd = mknode($1.nd, NULL, "IDEN_LIST"); }
	;

initializer
	: assignment_expression				{ $$.nd = mknode($1.nd, NULL, "INITIALIZER"); }
	;

selection_statement
	: IF { add('K'); } '(' expression ')' EOL compound_statement					{ $$.nd = mknode($4.nd, $7.nd, "SELECT_STAT"); }
	| IF { add('K'); } '(' expression ')' EOL compound_statement ELSE statement 	{ 
			struct node* tp = mknode($4.nd, $7.nd, "IF_STAT");
			$$.nd = mknode(tp, $9.nd, "IF_ELSE_STAT"); 
		}/* shift reduce conflict here similar to c lang */
	;

iteration_statement
	: LOOP { add('K'); } '(' expression ')' EOL compound_statement	{ $$.nd = mknode($4.nd, $7.nd, "ITER_STAT"); }
	;

jump_statement
	: CONTINUE { add('K'); } EOL 
	| BREAK { add('K'); } EOL
	| EXIT { add('K'); } EOL
	| EXIT { add('K'); } expression EOL
	;
%%

int main(int argc, char* argv[]) 
{
	yyparse();
	cout << "\n\n";
	cout << "\t    SYMBOL TABLE \n\n";
	cout << "\nSYMBOL\t\t\tDATATYPE\t\t\tTYPE\t\t\tLINE_NUMBER \n";
	cout << "___________________________________________________________________________________________\n\n";

	for(int i = 0; i < Count; i++) {
		cout << symbol_table[i].id_name << "\t\t\t" << symbol_table[i].data_type << "\t\t\t\t" << symbol_table[i].type << "\t\t   " << symbol_table[i].line_no << "\n";
	}
	for(int i=0;i<Count;i++) {
		//free(symbol_table[i].id_name);
		//free(symbol_table[i].type);
	}
	cout << "\n\n";
	printtree(head);
}

int search (string type) {
	for (int i = Count - 1; i >= 0; i--) {
		if(symbol_table[i].id_name == type) {
			return -1;
			break;
		}
	}
	return 0;
}

void add (char c) {
  q = search(yytext);
  if(!q) {
    if(c == 'H') {
			symbol_table[Count].id_name = yytext;
			symbol_table[Count].data_type = type;
			symbol_table[Count].line_no = token_no;
			symbol_table[Count].type = "Header";
			Count++;
		}
		else if(c == 'K') {
			symbol_table[Count].id_name = yytext;
			symbol_table[Count].data_type = "N/A";
			symbol_table[Count].line_no = token_no;
			symbol_table[Count].type = "Keyword\t";
			Count++;
		}
		else if(c == 'V') {
			symbol_table[Count].id_name = yytext;
			symbol_table[Count].data_type = type;
			symbol_table[Count].line_no = token_no;
			symbol_table[Count].type = "Variable";
			Count++;
		}
		else if(c == 'C') {
			symbol_table[Count].id_name = yytext;
			symbol_table[Count].data_type = "CONST";
			symbol_table[Count].line_no = token_no;
			symbol_table[Count].type = "Constant";
			Count++;
		}
		else if(c == 'F') {
			symbol_table[Count].id_name = yytext;
			symbol_table[Count].data_type = type;
			symbol_table[Count].line_no = token_no;
			symbol_table[Count].type = "Function";
			Count++;
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
