%{
	#include "SymbolTable.hpp"
    void yyerror(string s);
    int yylex();
    int yywrap();
%}

%union {
	struct var_name {
		char name[1000];
		struct node* nd;
		char type[1000];
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

%type <nd_obj> translation_unit external_declaration function_definition parameter_list parameters type_specifier in_out_specifier
  compound_statement expression_statement expression assignment_expression
  assignment_operator conditional_expression logical_or_expression logical_and_expression
  equality_expression relational_expression additive_expression multiplicative_expression
  cast_expression unary_expression unary_operator postfix_expression primary_expression
  argument_expression_list statement_list statement declaration_list declaration 
  mulendoflines init_declarator_list init_declarator initializer_list declarator
  direct_declarator identifier_list initializer selection_statement iteration_statement jump_statement exit in_out_statement

%start translation_unit

%%

translation_unit
	: external_declaration { $$.nd = mknode(NULL, $1.nd, "TRANSLATION_UNIT"); head = $$.nd; }
	| translation_unit external_declaration { $2.nd = mknode(NULL, NULL, "TRANSLATION_UNIT"); $$.nd = mknode($1.nd, $2.nd, "TRANSLATION_UNIT"); head = $$.nd; }
	;

external_declaration
	: mulendoflines
	| function_definition { $$.nd = mknode(NULL, $1.nd, "EXTERNAL_DECLR"); }
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

in_out_specifier
	: INPUT		{ insert_type(); }
	| OUTPUT	{ insert_type(); }
	;

compound_statement
	: FUN_ST FUN_EN								{$$.nd = mknode(NULL, NULL, "COMPOUND_STATEMENT"); }
	| FUN_ST statement_list FUN_EN				{$$.nd = mknode(NULL, $2.nd, "COMPOUND_STATEMENT"); }
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
	: conditional_expression	{ $$.nd = mknode($1.nd, NULL, "ASS_EXPR"); strcpy($$.type, $1.type); }
	| unary_expression assignment_operator assignment_expression { 
			struct node* tp = mknode($1.nd, $2.nd, "UN_ASSGN");
			$$.nd = mknode(tp, $3.nd, "ASS_EXPR");
			if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
				if(/*print("1") &&*/ check_types($1.type, $3.type) == 0){
					strcpy($$.type, $1.type); 
				}
				else{
					strcpy($$.type, "undefined");
				}
			}
		}
	;

assignment_operator
	: '='
	| MUL_ASSIGN
	| ADD_ASSIGN
	;

conditional_expression
	: logical_or_expression { $$.nd = mknode($1.nd, NULL, "COND_EXPR"); strcpy($$.type, $1.type);  }
	;

logical_or_expression
	: logical_and_expression { $$.nd = mknode($1.nd, NULL, "LOGI_OR_EXPR"); strcpy($$.type, $1.type);  }
	| logical_or_expression OR_OP logical_and_expression { $$.nd = mknode($1.nd, $3.nd, "OR"); 
		if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
			if(/*print("2") && */check_types($1.type, $3.type) == 0){
				strcpy($$.type, $1.type); 
			}
			else{
				strcpy($$.type, "undefined");
			}
		}
	}
	;

logical_and_expression
	: equality_expression { $$.nd = mknode($1.nd, NULL, "LOGI_AND_EXPR"); strcpy($$.type, $1.type);  }
	| logical_and_expression AND_OP equality_expression { $$.nd = mknode($1.nd, $3.nd, "AND"); 
		if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
			if(/*print("3") &&*/ check_types($1.type, $3.type) == 0){
				strcpy($$.type, $1.type); 
			}
			else{
				strcpy($$.type, "undefined");
			}
		}
	}
	;

equality_expression
	: relational_expression { $$.nd = mknode($1.nd, NULL, "EQ_EXPR"); strcpy($$.type, $1.type);  }
	| equality_expression EQ_OP relational_expression { $$.nd = mknode($1.nd, $3.nd, "=="); 
		if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
			if(/*print("4") &&*/ check_types($1.type, $3.type) == 0){
				strcpy($$.type, $1.type); 
			}
			else{
				strcpy($$.type, "undefined");
			}
		}
	}
	| equality_expression NE_OP relational_expression { $$.nd = mknode($1.nd, $3.nd, "!="); 
		if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
			if(/*print("5") && */check_types($1.type, $3.type) == 0){
				strcpy($$.type, $1.type); 
			}
			else{
				strcpy($$.type, "undefined");
			}
		}
	}
	;

relational_expression
	: additive_expression	{ $$.nd = mknode($1.nd, NULL, "RELATIONAL_EXPR"); strcpy($$.type, $1.type);  }
	| relational_expression '<' additive_expression { $$.nd = mknode($1.nd, $3.nd, "<"); 
		if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
			if(/*print("6") &&*/ check_types($1.type, $3.type) == 0){
				strcpy($$.type, $1.type); 
			}
			else{
				strcpy($$.type, "undefined");
			}
		}
	}
	| relational_expression '>' additive_expression { $$.nd = mknode($1.nd, $3.nd, ">"); 
		if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
			if(/*print("7") && */check_types($1.type, $3.type) == 0){
				strcpy($$.type, $1.type); 
			}
			else{
				strcpy($$.type, "undefined");
			}
		}
	}
	| relational_expression LE_OP additive_expression { $$.nd = mknode($1.nd, $3.nd, "<="); 
		if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
			if(/*print("8") &&*/ check_types($1.type, $3.type) == 0){
				strcpy($$.type, $1.type); 
			}
			else{
				strcpy($$.type, "undefined");
			}
		}
	}
	| relational_expression GE_OP additive_expression { $$.nd = mknode($1.nd, $3.nd, ">="); 
		if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
			if(/*print("9") &&*/ check_types($1.type, $3.type) == 0){
				strcpy($$.type, $1.type); 
			}
			else{
				strcpy($$.type, "undefined");
			}
		}
	}
	;

additive_expression
	: multiplicative_expression	{ $$.nd = mknode($1.nd, NULL, "ADDITIVE_EXPR"); strcpy($$.type, $1.type);  }
	| additive_expression '+' multiplicative_expression { $$.nd = mknode($1.nd, $3.nd, "+"); 
		if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
			//print(to_string(check_types($1.type, $3.type)));
			if(/*print("10") &&*/ check_types($1.type, $3.type) == 0){
				strcpy($$.type, $1.type); 
			}
			else{
				strcpy($$.type, "undefined");
			}
		}
	}
	| additive_expression '-' multiplicative_expression { $$.nd = mknode($1.nd, $3.nd, "-"); 
		if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
			if(/*print("11") &&*/ check_types($1.type, $3.type) == 0){
				strcpy($$.type, $1.type); 
			}
			else{
				strcpy($$.type, "undefined");
			}
		}
	}
	;

multiplicative_expression
	: cast_expression { $$.nd = mknode($1.nd, NULL, "MUL_EXPR"); strcpy($$.type, $1.type);  }
	| multiplicative_expression '*' cast_expression { $$.nd = mknode($1.nd, $3.nd, "*"); 
		if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
			if(/*print("12") &&*/ check_types($1.type, $3.type) == 0){
				strcpy($$.type, $1.type); 
			}
			else{
				strcpy($$.type, "undefined");
			}
		}
	}
	| multiplicative_expression '/' cast_expression { $$.nd = mknode($1.nd, $3.nd, "/"); 
		if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
			if(/*print("13") &&*/ check_types($1.type, $3.type) == 0){
				strcpy($$.type, $1.type); 
			}
			else{
				strcpy($$.type, "undefined");
			}
		}
	}
	| multiplicative_expression '%' cast_expression { $$.nd = mknode($1.nd, $3.nd, "%"); 
		if(strcmp($1.type, "undefined") !=0 && strcmp($3.type, "undefined") !=0){
			if(/*print("14") && */check_types($1.type, $3.type) == 0){
				strcpy($$.type, $1.type); 
			}
			else{
				strcpy($$.type, "undefined");
			}
		}
	}
	;

cast_expression
	: unary_expression { $$.nd = mknode($1.nd, NULL, "CAST_EXPR"); strcpy($$.type, $1.type);  }
	| '(' type_specifier ')' cast_expression { $$.nd = mknode($2.nd, $4.nd, "CAST_EXPR"); strcpy($$.type, $2.name); }
	;

unary_expression
	: postfix_expression { $$.nd = mknode($1.nd, NULL, "UNARY_EXPR"); strcpy($$.type, $1.type);  }
	| unary_operator cast_expression { $$.nd = mknode($1.nd, $2.nd, "UNARY_EXPR"); strcpy($$.type, $2.type); }
	;

unary_operator
	: '+'
	| '-'
	| '!'
	;

postfix_expression
	: primary_expression { $$.nd = mknode($1.nd, NULL, "POSTFIX_EXPR"); strcpy($$.type, $1.type);  }
	| postfix_expression '(' ')' { $$.nd = mknode($1.nd, NULL, "POSTFIX_EXPR"); strcpy($$.type, $1.type);  }
	| postfix_expression '(' argument_expression_list ')' { $$.nd = mknode($1.nd, $3.nd, "POSTFIX_EXPR"); /*strcpy($$.type, $1.type);  */ }
	;

primary_expression
	: IDENTIFIER		 { check_declarations($1.name); $$.nd = mknode(NULL, NULL, $1.name);
		if(!search($1.name)){
			strcpy($$.type, "undefined");
		}
		else{
			string a = symbol_table[table[$1.name]]->data_type; 
			char* c = const_cast<char*>(a.c_str()); 
			strcpy($$.type, c); 
		}
		}		
	| INT_CONST			 { $$.nd = mknode(NULL, NULL, $1.name); strcpy($$.type, "int"); /*print($$.type);*/ }
	| FRAC_CONST		 { $$.nd = mknode(NULL, NULL, $1.name); strcpy($$.type, "frac"); }
	| DOUBLE_CONST		 { $$.nd = mknode(NULL, NULL, $1.name); strcpy($$.type, "double"); }
	| STRING_LITERAL	 { $$.nd = mknode(NULL, NULL, $1.name); strcpy($$.type, "string_literal"); }
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
	| in_out_statement		{ $$.nd = mknode($1.nd, NULL, "STAT"); }
	;

declaration_list
	: declaration					{ $$.nd = mknode($1.nd, NULL, "DECLR_LIST"); }
	| declaration_list declaration	{ $$.nd = mknode($1.nd, $2.nd, "DECLR_LIST"); }
	;

declaration
	: type_specifier init_declarator_list EOL	{ $$.nd = mknode($1.nd, $2.nd, "DECLR"); }
	| type_specifier mulendoflines init_declarator_list EOL	{ $$.nd = mknode($1.nd, $3.nd, "DECLR"); }
	;

mulendoflines
	: EOL 
	| mulendoflines EOL { $$.nd = mknode($1.nd, NULL, "MUL_END_OF_LINES"); }
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
	| type_specifier {  add('V'); }				{ $$.nd = mknode($1.nd, NULL, "DIRECT_DECLR"); }
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
	: IF { add('K'); } '(' expression ')' EOL compound_statement EOL ELSE EOL compound_statement	{ 
		struct node* tp = mknode($4.nd, $7.nd, "IF_STAT");
			$$.nd = mknode(tp, $11.nd, "IF_ELSE_STAT"); 
		}/* shift reduce conflict here similar to c lang */
	| IF { add('K'); } '(' expression ')' EOL compound_statement					{ $$.nd = mknode($4.nd, $7.nd, "SELECT_STAT"); }
	;

iteration_statement
	: LOOP { add('K'); } '(' expression ')' EOL compound_statement	{ $$.nd = mknode($4.nd, $7.nd, "ITER_STAT"); }
	;

jump_statement
	: CONTINUE { add('K'); } EOL 
	| BREAK { add('K'); } EOL
	| EXIT { add('K'); } exit { $$.nd = mknode(NULL, $3.nd, "EXIT_EXPR"); }
	;

exit
	: EOL
	| ':' expression EOL { $$.nd = mknode(NULL, $2.nd, "EXIT"); }	
	;

in_out_statement
	: in_out_specifier { add('F'); } ':' initializer_list 

%%

int main(int argc, char* argv[]) 
{
	yyparse();
	SymbolTableGenerator();
	SemanticErrors();
	printtree(head);
}