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

%}



%token IDENTIFIER FRAC_CONST DOUBLE_CONST INT_CONST STRING_LITERAL
%token ARROW LE_OP GE_OP EQ_OP NE_OP POW_OP
%token AND_OP OR_OP MUL_ASSIGN ADD_ASSIGN
%token FUN_ST FUN_EN

%token STRING INT LONG BOOL FRAC DOUBLE VOID
%token TRUE FALSE
%token INPUT OUTPUT

%token IF ELSE LOOP CONTINUE BREAK EXIT

%token POINT LINE CONIC LINE_PAIR CIRCLE PARABOLA ELLIPSE HYPERBOLA

%start translation_unit

%%

translation_unit
	: external_declaration
	| translation_unit external_declaration
	;

external_declaration
	: function_definition
	| declaration
	;

function_definition
    : IDENTIFIER { add('F'); } parameter_list ARROW type_specifier compound_statement 
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
	: FUN_ST FUN_EN
	| FUN_ST statement_list FUN_EN
	| FUN_ST declaration_list FUN_EN
	| FUN_ST declaration_list statement_list FUN_EN
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
	: IDENTIFIER		 { add('V'); }
	| INT_CONST			 { add('C'); }
	| FRAC_CONST		 { add('C'); }
	| DOUBLE_CONST		 { add('C'); }
	| STRING_LITERAL	 { add('C'); }
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
	printf("\t\t\t\t\t\t\t\t PHASE 1: LEXICAL ANALYSIS \n\n");
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