%{
	#include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include <ctype.h>
    /*#include "project.lex.c"*/
    
	extern char* yytext;
    void yyerror(const char *s);
    int yylex();
    int yywrap();
    void add(char);
    void insert_type();
    int search(char *);

    struct dataType {
        char* id_name;
        char* data_type;
        char* type;
        int line_no;
    } symbol_table[10000];		/* see this */

    int count=0;
    int q;
    char type[10];
    extern int token_no;
	
	struct node *head;
    struct node {
		struct node *left; 
		struct node *right; 
		char *token; 
    };
    void printtree(struct node*);
    void printInorder(struct node *);
    struct node* mknode(struct node *left, struct node *right, char *token);

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

%token STRING INT LONG BOOL FRAC DOUBLE VOID
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
	: external_declaration { $$.nd = mknode(NULL, $1.nd, "external_declaration"); head = $$.nd; }
	| translation_unit external_declaration { $2.nd = mknode(NULL, NULL, "external_declaration"); $$.nd = mknode($1.nd, $2.nd, "translation_unit"); head = $$.nd; }
	;

external_declaration
	: function_definition { $$.nd = mknode(NULL, $1.nd, "function_declaration"); }
	| declaration
	;

function_definition
    : IDENTIFIER { add('F'); } parameter_list ARROW type_specifier compound_statement { 
		struct node* tp = mknode($3.nd, $5.nd, "OPTIONS");
		$$.nd = mknode(tp, $6.nd, $1.name); 
		} 
	;

parameter_list
	:
	| ':' parameters
	;

parameters
	: type_specifier IDENTIFIER { add('V'); }
	| parameters ',' type_specifier IDENTIFIER { add('V'); }
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
	: FUN_ST FUN_EN									//{$$.nd = mknode(NULL, NULL, "COMPUND STATEMENT")}
	| FUN_ST statement_list FUN_EN					//{$$.nd = mknode(NULL, $2.nd, "COMPUND STATEMENT")}
	| FUN_ST declaration_list FUN_EN				//{$$.nd = mknode(NULL, $2.nd, "COMPUND STATEMENT")}
	| FUN_ST declaration_list statement_list FUN_EN //{$$.nd = mknode($2.nd, $3.nd, "COMPUND STATEMENT")}
	;

expression_statement
	: ';'
	| expression ';'
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression
	;

assignment_operator
	: '='
	| MUL_ASSIGN
	| ADD_ASSIGN
	;

conditional_expression
	: logical_or_expression
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OR_OP logical_and_expression
	;

logical_and_expression
	: equality_expression
	| logical_and_expression AND_OP equality_expression
	;

equality_expression
	: relational_expression
	| equality_expression EQ_OP relational_expression
	| equality_expression NE_OP relational_expression
	;

relational_expression
	: additive_expression
	| relational_expression '<' additive_expression
	| relational_expression '>' additive_expression
	| relational_expression LE_OP additive_expression
	| relational_expression GE_OP additive_expression
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression
	| additive_expression '-' multiplicative_expression
	;

multiplicative_expression
	: cast_expression
	| multiplicative_expression '*' cast_expression
	| multiplicative_expression '/' cast_expression
	| multiplicative_expression '%' cast_expression
	;

cast_expression
	: unary_expression
	| '(' type_specifier ')' cast_expression
	;

unary_expression
	: postfix_expression
	| unary_operator cast_expression
	;

unary_operator
	: '+'
	| '-'
	| '!'
	;

postfix_expression
	: primary_expression
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')'
	;

primary_expression
	: IDENTIFIER		 { add('V'); /*$$.nd = mknode(NULL, NULL, "IDENTIFIER");*/ }
	| INT_CONST			 { add('C'); /*$$.nd = mknode(NULL, NULL, $1.name);*/ }
	| FRAC_CONST		 { add('C'); /*$$.nd = mknode(NULL, NULL, $1.name);*/ }
	| DOUBLE_CONST		 { add('C'); /*$$.nd = mknode(NULL, NULL, $1.name);*/ }
	| STRING_LITERAL	 { add('C'); /*$$.nd = mknode(NULL, NULL, $1.name);*/ }
	| '(' expression ')'
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;

statement_list
	: statement
	| statement_list statement
	;

statement
	: compound_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	| jump_statement
	;

declaration_list
	: declaration
	| declaration_list declaration
	;

declaration
	: declaration_specifiers ';'
	| declaration_specifiers init_declarator_list ';'
	;

declaration_specifiers
	: type_specifier
	| type_specifier declaration_specifiers
	;

init_declarator_list
	: init_declarator
	| init_declarator_list ',' init_declarator
	;

init_declarator
	: declarator
	| declarator '=' initializer
	| declarator ':' initializer_list 
	;

initializer_list
	: initializer
	| initializer_list ',' initializer
	;

declarator
	: direct_declarator
	;

direct_declarator
	: IDENTIFIER	{ add('V'); }
	| '(' declarator ')'
	| direct_declarator '(' parameter_list ')'
	| direct_declarator '(' identifier_list ')'
	| direct_declarator '(' ')'							/* shift reduce conflict here similar to c lang */
	;

identifier_list
	: IDENTIFIER	{ add('V'); }
	| identifier_list ',' IDENTIFIER	{ add('V'); }
	;

initializer
	: assignment_expression
	;

selection_statement
	: IF '(' expression ')' statement
	| IF '(' expression ')' statement ELSE statement 	/* shift reduce conflict here similar to c lang */
	;

iteration_statement
	: LOOP { add('K'); } '(' expression ')' statement
	;

jump_statement
	: CONTINUE { add('K'); } ';'
	| BREAK { add('K'); } ';'
	| EXIT { add('K'); } ';'
	| EXIT { add('K'); } expression ';'
	;
%%

int main(int argc, char* argv[]) 
{
	yyparse();
  	printf("\n\n");
	printf("\t    SYMBOL TABLE \n\n");
	printf("\nSYMBOL   DATATYPE   TYPE   LINE NUMBER \n");
	printf("_______________________________________\n\n");

	for(int i = 0; i < count; i++) {
		printf("%s\t%s\t%s\t%d\t\n", symbol_table[i].id_name, symbol_table[i].data_type, symbol_table[i].type, symbol_table[i].line_no);
	}
	for(int i=0;i<count;i++) {
		free(symbol_table[i].id_name);
		free(symbol_table[i].type);
	}
	printf("\n\n");
	printtree(head);
}

int search (char *type) {
	for (int i = count - 1; i >= 0; i--) {
		if(strcmp(symbol_table[i].id_name, type) == 0) {
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
			symbol_table[count].id_name = strdup(yytext);
			symbol_table[count].data_type = strdup(type);
			symbol_table[count].line_no = token_no;
			symbol_table[count].type = strdup("Header");
			count++;
		}
		else if(c == 'K') {
			symbol_table[count].id_name = strdup(yytext);
			symbol_table[count].data_type = strdup("N/A");
			symbol_table[count].line_no = token_no;
			symbol_table[count].type = strdup("Keyword\t");
			count++;
		}
		else if(c == 'V') {
			symbol_table[count].id_name = strdup(yytext);
			symbol_table[count].data_type = strdup(type);
			symbol_table[count].line_no = token_no;
			symbol_table[count].type = strdup("Variable");
			count++;
		}
		else if(c == 'C') {
			symbol_table[count].id_name = strdup(yytext);
			symbol_table[count].data_type = strdup("CONST");
			symbol_table[count].line_no = token_no;
			symbol_table[count].type = strdup("Constant");
			count++;
		}
		else if(c == 'F') {
			symbol_table[count].id_name = strdup(yytext);
			symbol_table[count].data_type = strdup(type);
			symbol_table[count].line_no = token_no;
			symbol_table[count].type = strdup("Function");
			count++;
		}
	}
}

void insert_type() {
	strcpy(type, yytext);
}

struct node* mknode(struct node *left, struct node *right, char *token) {	
	struct node *newnode = (struct node *)malloc(sizeof(struct node));
	char *newstr = (char *)malloc(strlen(token)+1);
	strcpy(newstr, token);
	newnode->left = left;
	newnode->right = right;
	newnode->token = newstr;
	return(newnode);
}

void printtree(struct node* tree) {
	printf("\n\n Inorder traversal of the Parse Tree: \n\n");
	printInorder(tree);
	printf("\n\n");
}

void printInorder(struct node *tree) {
	int i;
	if (tree->left) {
		printInorder(tree->left);
	}
	printf("%s, ", tree->token);
	if (tree->right) {
		printInorder(tree->right);
	}
}