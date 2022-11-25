/* Definitions :  Here we include all the libraries used and declare the functions.*/
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

/* This struct is used for the entries of the symbol table*/

  struct dataType {
        char* id_name;
        char* data_type;
        char* type;
        int line_no;
    } symbol_table[10000];		/* see this */

/* Declare the global variables*/

    int count=0;
    int q;
    char type[10];
    extern int token_no;

/* Declare the struct tree node*/
	
	struct node *head;
    struct node {
		struct node *left; 
		struct node *right; 
		char *token; 
    };
    void printtree(struct node*);
    void printPreorder(struct node *);
    struct node* mknode(struct node *left, struct node *right, char *token);

%}

/* Used in tree creating by storing the variable name and type*/

%union { 
	struct var_name { 
		char name[100]; 
		struct node* nd;
	} nd_obj; 
} 

/* Tokens are declared here*/

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

/* Contains all the source files and header files*/

translation_unit
	: external_declaration { $$.nd = mknode(NULL, $1.nd, "TRANSLATION_UNIT"); head = $$.nd; }
	| translation_unit external_declaration { $2.nd = mknode(NULL, NULL, "TRANSLATION_UNIT"); $$.nd = mknode($1.nd, $2.nd, "TRANSLATION_UNIT"); head = $$.nd; }
	;

/* Variables that are declared externally are handled here*/

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

/* Functions used in the code are defined here */

parameter_list
	:
	| ':' parameters { $$.nd = mknode(NULL, $2.nd, "PARAMS_LIST"); }
	;

/* Contains list of all the parameters used */

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

/*Takes care of identifing each parameter */

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

/* Takes care of the statement which is a combination of two or more statements connected by a condition */

compound_statement
	: FUN_ST FUN_EN								{$$.nd = mknode(NULL, NULL, "COMPUND STATEMENT"); }
	| FUN_ST statement_list FUN_EN				{$$.nd = mknode(NULL, $2.nd, "COMPUND STATEMENT"); }
	;

/* Complete expressionis considered here */

expression_statement
	: EOL
	| expression EOL	{$$.nd = mknode($1.nd, NULL, "EXPR_ST"); }
	;

/* Any part of the regular expression that can produce a value */

expression
	: assignment_expression	{ $$.nd = mknode($1.nd, NULL, "EXPR"); }
	| expression ',' assignment_expression { $$.nd = mknode($1.nd, $3.nd, "EXPR"); }
	;

/* All the assignment operations are handled here */

assignment_expression
	: conditional_expression	{ $$.nd = mknode($1.nd, NULL, "ASS_EXPR"); }
	| unary_expression assignment_operator assignment_expression { 
			struct node* tp = mknode($1.nd, $2.nd, "UN_ASSGN");
			$$.nd = mknode(tp, $3.nd, "ASS_EXPR");
		}
	;

/* List of the assignment operators */

assignment_operator
	: '='
	| MUL_ASSIGN
	| ADD_ASSIGN
	;

/* That makes path based on the logical condition it holds*/

conditional_expression
	: logical_or_expression { $$.nd = mknode($1.nd, NULL, "COND_EXPR"); }
	;

/* Expression that outputs logical true or false depending on the or condition*/

logical_or_expression
	: logical_and_expression { $$.nd = mknode($1.nd, NULL, "LOGI_OR_EXPR"); }
	| logical_or_expression OR_OP logical_and_expression { $$.nd = mknode($1.nd, $3.nd, "OR"); }
	;

/* Expression that outputs logical true or false depending on the and condition*/

logical_and_expression
	: equality_expression { $$.nd = mknode($1.nd, NULL, "LOGI_AND_EXPR"); }
	| logical_and_expression AND_OP equality_expression { $$.nd = mknode($1.nd, $3.nd, "AND"); }
	;

/* Checks the equality of an expression*/

equality_expression
	: relational_expression { $$.nd = mknode($1.nd, NULL, "EQ_EXPR"); }
	| equality_expression EQ_OP relational_expression { $$.nd = mknode($1.nd, $3.nd, "=="); }
	| equality_expression NE_OP relational_expression { $$.nd = mknode($1.nd, $3.nd, "!="); }
	;

/* Checks the relative highness or lowness of the condition */

relational_expression
	: additive_expression	{ $$.nd = mknode($1.nd, NULL, "RELATIONAL_EXPR"); }
	| relational_expression '<' additive_expression { $$.nd = mknode($1.nd, $3.nd, "<"); }
	| relational_expression '>' additive_expression { $$.nd = mknode($1.nd, $3.nd, ">"); }
	| relational_expression LE_OP additive_expression { $$.nd = mknode($1.nd, $3.nd, "<="); }
	| relational_expression GE_OP additive_expression { $$.nd = mknode($1.nd, $3.nd, ">="); }
	;

/* Summation of the values or variables in the expression */

additive_expression
	: multiplicative_expression	{ $$.nd = mknode($1.nd, NULL, "ADDITIVE_EXPR"); }
	| additive_expression '+' multiplicative_expression { $$.nd = mknode($1.nd, $3.nd, "+"); }
	| additive_expression '-' multiplicative_expression { $$.nd = mknode($1.nd, $3.nd, "-"); }
	;

/* Multiplying of the values or variables in the expression */

multiplicative_expression
	: cast_expression { $$.nd = mknode($1.nd, NULL, "MUL_EXPR"); }
	| multiplicative_expression '*' cast_expression { $$.nd = mknode($1.nd, $3.nd, "*"); }
	| multiplicative_expression '/' cast_expression { $$.nd = mknode($1.nd, $3.nd, "/"); }
	| multiplicative_expression '%' cast_expression { $$.nd = mknode($1.nd, $3.nd, "%"); }
	;

/* Converts one data type to another data type */

cast_expression
	: unary_expression { $$.nd = mknode($1.nd, NULL, "CAST_EXPR"); }
	| '(' type_specifier ')' cast_expression { $$.nd = mknode($2.nd, $4.nd, "CAST_EXPR"); }
	;

/* Change the value of a single operand */

unary_expression
	: postfix_expression { $$.nd = mknode($1.nd, NULL, "UNARY_EXPR"); }
	| unary_operator cast_expression { $$.nd = mknode($1.nd, $2.nd, "UNARY_EXPR"); }
	;

/* List of the unary operator*/

unary_operator
	: '+'
	| '-'
	| '!'
	;

/* Operations where the operators come after the operands */

postfix_expression
	: primary_expression { $$.nd = mknode($1.nd, NULL, "POSTFIX_EXPR"); }
	| postfix_expression '(' ')' { $$.nd = mknode($1.nd, NULL, "POSTFIX_EXPR"); }
	| postfix_expression '(' argument_expression_list ')' { $$.nd = mknode($1.nd, $3.nd, "POSTFIX_EXPR"); }
	;

/* Expressions with brackets are primary expressions as they are evaluated at first*/

primary_expression
	: IDENTIFIER		 { add('V'); $$.nd = mknode(NULL, NULL, $1.name); }
	| INT_CONST			 { add('C'); $$.nd = mknode(NULL, NULL, $1.name); }
	| FRAC_CONST		 { add('C'); $$.nd = mknode(NULL, NULL, $1.name); }
	| DOUBLE_CONST		 { add('C'); $$.nd = mknode(NULL, NULL, $1.name); }
	| STRING_LITERAL	 { add('C'); $$.nd = mknode(NULL, NULL, $1.name); }
	| '(' expression ')' { $$.nd = mknode($2.nd, NULL, "PRIM_EXPR"); }
	;

/* List of all the argument expressions */

argument_expression_list
	: assignment_expression { $$.nd = mknode($1.nd, NULL, "ARGU_EXPR_LIST"); }
	| argument_expression_list ',' assignment_expression { $$.nd = mknode($1.nd, $3.nd, "ARGU_EXPR_LIST"); }
	;

/* List of all statements */

statement_list
	: statement	{ $$.nd = mknode($1.nd, NULL, "STAT_LIST"); }
	| statement_list statement { $$.nd = mknode($1.nd, $2.nd, "STAT_LIST"); }
	;

/* A block of code that execute some sort of functionallity */

statement
	: declaration			{ $$.nd = mknode($1.nd, NULL, "STAT"); }
	| compound_statement	{ $$.nd = mknode($1.nd, NULL, "STAT"); }
	| expression_statement	{ $$.nd = mknode($1.nd, NULL, "STAT"); }
	| selection_statement	{ $$.nd = mknode($1.nd, NULL, "STAT"); }
	| iteration_statement	{ $$.nd = mknode($1.nd, NULL, "STAT"); }
	| jump_statement		{ $$.nd = mknode($1.nd, NULL, "STAT"); }
	;

/* List of all declarations */

declaration_list
	: declaration					{ $$.nd = mknode($1.nd, NULL, "DECLR_LIST"); }
	| declaration_list declaration	{ $$.nd = mknode($1.nd, $2.nd, "DECLR_LIST"); }
	;

/* A block of code that declares some value or function etc */

declaration
	: declaration_specifiers EOL						{ $$.nd = mknode($1.nd, NULL, "DECLR"); }
	| declaration_specifiers init_declarator_list EOL	{ $$.nd = mknode($1.nd, $2.nd, "DECLR"); }
	;

/* Specifies the type of the declarations */

declaration_specifiers
	: type_specifier						{ $$.nd = mknode($1.nd, NULL, "DECLR_SPCIF"); }
	| type_specifier declaration_specifiers	{ $$.nd = mknode($1.nd, $2.nd, "DECLR_SPCIF"); }
	;

/* Contains list of all init_declarators */

init_declarator_list
	: init_declarator							{ $$.nd = mknode($1.nd, NULL, "INIT_DECLR_LIST"); }
	| init_declarator_list ',' init_declarator	{ $$.nd = mknode($1.nd, $3.nd, "INIT_DECLR_LIST"); }
	;

/* They are a sequence of declarators separated by commas, each with an optional initializer */

init_declarator
	: declarator						{ $$.nd = mknode($1.nd, NULL, "INIT_DECLR"); }
	| declarator '=' initializer		{ $$.nd = mknode($1.nd, $3.nd, "INIT_DECLR"); }
	| declarator ':' initializer_list 	{ $$.nd = mknode($1.nd, $3.nd, "INIT_DECLR"); }
	;

/* Contains the list of initializers */

initializer_list
	: initializer						{ $$.nd = mknode($1.nd, NULL, "INIT_LIST"); }
	| initializer_list ',' initializer	{ $$.nd = mknode($1.nd, $3.nd, "INIT_LIST"); }
	;

/* Contains particular syntax that specifies whether the variable is pointer or reference array or function etc */

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

/* List of names given to differnet varibales , functions etc */

identifier_list
	: IDENTIFIER	{ add('V'); }						{ $$.nd = mknode(NULL, NULL, $1.name); }
	| identifier_list ',' IDENTIFIER	{ add('V'); }	{ $$.nd = mknode($1.nd, NULL, "IDEN_LIST"); }
	;

/* Used to initialize the data members of a class */

initializer
	: assignment_expression				{ $$.nd = mknode($1.nd, NULL, "INITIALIZER"); }
	;

/* Selects a statement from a number of possible statements for execution */

selection_statement
	: IF { add('K'); } '(' expression ')' EOL compound_statement					{ $$.nd = mknode($4.nd, $7.nd, "SELECT_STAT"); }
	| IF { add('K'); } '(' expression ')' EOL compound_statement ELSE statement 	{ 
			struct node* tp = mknode($4.nd, $7.nd, "IF_STAT");
			$$.nd = mknode(tp, $9.nd, "IF_ELSE_STAT"); 
		}/* shift reduce conflict here similar to c lang */
	;

/* Contains a loop that runs with regard to a condition */

iteration_statement
	: LOOP { add('K'); } '(' expression ')' EOL compound_statement	{ $$.nd = mknode($4.nd, $7.nd, "ITER_STAT"); }
	;

/* Skips some statements with regard to the condition*/

jump_statement
	: CONTINUE { add('K'); } EOL 
	| BREAK { add('K'); } EOL
	| EXIT { add('K'); } EOL
	| EXIT { add('K'); } expression EOL
	;
%%

/* Main takes the argument from the command line opens the respective file and reads from it writes to the output file*/

int main(int argc, char* argv[]) 
{
	yyparse();
  	printf("\n\n");
	printf("\t    SYMBOL TABLE \n\n");
	printf("\nSYMBOL\t\t\tDATATYPE\t\t\tTYPE\t\t\tLINE_NUMBER \n");
	printf("___________________________________________________________________________________________\n\n");

	for(int i = 0; i < count; i++) {
		printf("%s\t\t\t%s\t\t\t\t%s\t\t   %d\n", symbol_table[i].id_name, symbol_table[i].data_type, symbol_table[i].type, symbol_table[i].line_no);
	}
	for(int i=0;i<count;i++) {
		free(symbol_table[i].id_name);
		free(symbol_table[i].type);
	}
	printf("\n\n");
	printtree(head);
}

/* Searchs for the token that resembles or matches the given keyword */

int search (char *type) {
	for (int i = count - 1; i >= 0; i--) {
		if(strcmp(symbol_table[i].id_name, type) == 0) {
			return -1;
			break;
		}
	}
	return 0;
}

/* Adds all the searched tokens untill the end to form a symbol tree */

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

/* Takes the type of the variable */

void insert_type() {
	strcpy(type, yytext);
}

/* Prints the symbol tree */

struct node* mknode(struct node *left, struct node *right, char *token) {	
	struct node *newnode = (struct node *)malloc(sizeof(struct node));
	char *newstr = (char *)malloc(strlen(token)+1);
	strcpy(newstr, token);
	newnode->left = left;
	newnode->right = right;
	newnode->token = newstr;
	return(newnode);
}

/* Prints the symbol tree */

void printtree(struct node* tree) {
	printf("\n\n Preorder traversal of the Parse Tree: \n\n");
	printPreorder(tree);
	printf("\n\n");
}

/* Prints the symbol tree */

void printPreorder(struct node *tree) {
	int i;
	printf("%s, ", tree->token);
	if (tree->left) {
		printPreorder(tree->left);
	}
	if (tree->right) {
		printPreorder(tree->right);
	}
}
