%{
	#include "../Semantics.hpp"
	#include "../AST.hpp"
    void yyerror(string s);
    int yylex();
    int yywrap();
	class Start *root = NULL;
%}

%define parse.error simple
%union {
	struct nd_info {
		struct var_name {
			char name[1000];
			struct node* nd;
			char type[1000];
		} sem_nd;
		class Node* cg_nd;
	} obj;
}


%token <obj> IDENTIFIER STRING_LITERAL
%token <obj> FRAC_CONST DOUBLE_CONST INT_CONST
%token <obj> ARROW LE_OP GE_OP EQ_OP NE_OP POW_OP
%token <obj> AND_OP OR_OP MUL_ASSIGN ADD_ASSIGN
%token <obj> FUN_ST FUN_EN

%token <obj> STRING INT LONG BOOL FRAC DOUBLE VOID EOL
%token <obj> TRUE FALSE
%token <obj> INPUT OUTPUT

%token <obj> IF ELSE LOOP CONTINUE BREAK EXIT

%token <obj> POINT LINE CONIC LINE_PAIR CIRCLE PARABOLA ELLIPSE HYPERBOLA

%type <obj> translation_unit external_declaration function_definition parameter_list parameters type_specifier in_out_specifier
  compound_statement expression_statement expression assignment_expression
  assignment_operator conditional_expression logical_or_expression logical_and_expression
  equality_expression relational_expression additive_expression multiplicative_expression
  cast_expression unary_expression unary_operator postfix_expression primary_expression
  argument_expression_list statement_list statement /*declaration_list*/ declaration 
  mulendoflines init_declarator_list init_declarator initializer_list declarator
  direct_declarator identifier_list initializer selection_statement iteration_statement jump_statement exit in_out_statement temp_fun

%type <obj> '=' '+' '-' '!'

%start translation_unit

%%

translation_unit
	: { enter_scope(); } external_declaration 
	{ 	
		$$.sem_nd.nd = mknode(NULL, $2.sem_nd.nd, "TRANSLATION_UNIT"); head = $$.sem_nd.nd;
		root = new Start($2.cg_nd);
		$$.cg_nd = new Node;
		$$.cg_nd->start = root;
		root->traverse();
	}
	| translation_unit external_declaration 
	{ 
		$2.sem_nd.nd = mknode(NULL, NULL, "TRANSLATION_UNIT"); $$.sem_nd.nd = mknode($1.sem_nd.nd, $2.sem_nd.nd, "TRANSLATION_UNIT"); head = $$.sem_nd.nd;
		root = new Start($2.cg_nd);
		$$.cg_nd = new Node;
		$$.cg_nd->start = root;
	}
	;

external_declaration
	: mulendoflines
	| function_definition 
	{ 
		$$.sem_nd.nd = mknode(NULL, $1.sem_nd.nd, "EXTERNAL_DECLR"); 
		$$.cg_nd = new Node;
		$$.cg_nd->func_def = new Function_Def();
	}
	| declaration
	{
		$$.cg_nd = new Node;
		$$.cg_nd->decl = new Declaration();
	}
	;

function_definition
    : IDENTIFIER { function_name = yytext; is_function_now = true; } parameter_list ARROW error_fun type_specifier { ret_type = yytext; add('F'); } EOL compound_statement { 
		struct node* tp = mknode($3.sem_nd.nd, $6.sem_nd.nd, "OPTIONS");
		$$.sem_nd.nd = mknode(tp, $9.sem_nd.nd, $1.sem_nd.name);
	}
	;

error_fun
	: %empty
	| error
	;

parameter_list
	: %empty {} 
	| ':' parameters { $$.sem_nd.nd = mknode(NULL, $2.sem_nd.nd, "PARAMS_LIST"); }
	;

parameters
	: type_specifier IDENTIFIER {
			struct node* tp = mknode(NULL, NULL, $2.sem_nd.name);
			$$.sem_nd.nd = mknode($1.sem_nd.nd, tp, "PARAMS");
			function_params.push_back($1.sem_nd.name);
			param_id.push_back({$1.sem_nd.name, $2.sem_nd.name});
		}
	| parameters ',' type_specifier IDENTIFIER {
			struct node* tp = mknode(NULL, NULL, $4.sem_nd.name);
			struct node* tp2 = mknode($3.sem_nd.nd, tp, "VARIABLES");
			$$.sem_nd.nd = mknode($1.sem_nd.nd, tp2, "PARAMS");
			function_params.push_back($3.sem_nd.name);
			param_id.push_back({$3.sem_nd.name, $4.sem_nd.name});
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
	: FUN_ST FUN_EN								{$$.sem_nd.nd = mknode(NULL, NULL, "COMPOUND_STATEMENT"); }
	| FUN_ST temp_fun statement_list FUN_EN				{$$.sem_nd.nd = mknode(NULL, $3.sem_nd.nd, "COMPOUND_STATEMENT"); exit_scope(); }
	;

temp_fun
	:  %empty {
		if(is_function_now){
			symbol_table.back()->symbol_info[symbol_table.back()->scope_table_util[function_name]]->params = function_params;
		}
		enter_scope(); 
		if(is_function_now){
			for(auto i : param_id) {
				add_params(i.first, i.second);
			}
			symbol_table.back()->fun_ret_type = ret_type;
			function_params.clear();
			param_id.clear();
			is_function_now = false;
		}
	}
	;

expression_statement
	: EOL
	| expression EOL	{$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "EXPR_ST"); }
	;

expression
	: assignment_expression	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type); }
	| expression ',' assignment_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "EXPR"); strcpy($$.sem_nd.type, $3.sem_nd.type); }
	;

assignment_expression
	: conditional_expression	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "ASS_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type); }
	| unary_expression assignment_operator assignment_expression { 
			struct node* tp = mknode($1.sem_nd.nd, $2.sem_nd.nd, "UN_ASSGN");
			$$.sem_nd.nd = mknode(tp, $3.sem_nd.nd, "ASS_EXPR");
			if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
				if(/*print("1") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
					strcpy($$.sem_nd.type, $1.sem_nd.type); 
				}
				else{
					strcpy($$.sem_nd.type, "undefined");
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
	: logical_or_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "COND_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);  }
	;

logical_or_expression
	: logical_and_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "LOGI_OR_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);  }
	| logical_or_expression OR_OP logical_and_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "OR"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("2") && */check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
	}
	;

logical_and_expression
	: equality_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "LOGI_AND_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);  }
	| logical_and_expression AND_OP equality_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "AND"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("3") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
	}
	;

equality_expression
	: relational_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "EQ_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);  }
	| equality_expression EQ_OP relational_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "=="); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("4") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
	}
	| equality_expression NE_OP relational_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "!="); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("5") && */check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
	}
	;

relational_expression
	: additive_expression	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "RELATIONAL_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);  }
	| relational_expression '<' additive_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "<"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("6") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
	}
	| relational_expression '>' additive_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, ">"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("7") && */check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
	}
	| relational_expression LE_OP additive_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "<="); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("8") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
	}
	| relational_expression GE_OP additive_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, ">="); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("9") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
	}
	;

additive_expression
	: multiplicative_expression	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "ADDITIVE_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);  }
	| additive_expression '+' multiplicative_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "+"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			//print(to_string(check_types($1.sem_nd.type, $3.sem_nd.type)));
			if(/*print("10") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
	}
	| additive_expression '-' multiplicative_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "-"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("11") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
	}
	;

multiplicative_expression
	: cast_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "MUL_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);  }
	| multiplicative_expression '*' cast_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "*"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("12") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
	}
	| multiplicative_expression '/' cast_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "/"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("13") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
	}
	| multiplicative_expression '%' cast_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "%"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("14") && */check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
	}
	;

cast_expression
	: unary_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "CAST_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);  }
	| '(' type_specifier ')' cast_expression { $$.sem_nd.nd = mknode($2.sem_nd.nd, $4.sem_nd.nd, "CAST_EXPR"); strcpy($$.sem_nd.type, $2.sem_nd.name); }
	;

unary_expression
	: postfix_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "UNARY_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);  }
	| unary_operator cast_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $2.sem_nd.nd, "UNARY_EXPR"); strcpy($$.sem_nd.type, $2.sem_nd.type); }
	;

unary_operator
	: '+'
	| '-'
	| '!'
	;

postfix_expression
	: primary_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "POSTFIX_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);  }
	| postfix_expression '(' ')' { $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "POSTFIX_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);  }
	| postfix_expression '(' argument_expression_list ')' { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "POSTFIX_EXPR"); /*strcpy($$.sem_nd.type, $1.sem_nd.type);  */ }
	;

primary_expression
	: IDENTIFIER		 { check_declarations($1.sem_nd.name); $$.sem_nd.nd = mknode(NULL, NULL, $1.sem_nd.name);
		if(!search($1.sem_nd.name)){
			strcpy($$.sem_nd.type, "undefined");
		}
		else{
			string a = symbol_table.back()->symbol_info[symbol_table.back()->scope_table_util[$1.sem_nd.name]]->data_type; 
			char* c = const_cast<char*>(a.c_str()); 
			strcpy($$.sem_nd.type, c); 
		}
		}		
	| INT_CONST			 { $$.sem_nd.nd = mknode(NULL, NULL, "INT_CONST"); strcpy($$.sem_nd.type, "int"); /*print($$.sem_nd.type);*/ }
	| FRAC_CONST		 { $$.sem_nd.nd = mknode(NULL, NULL, $1.sem_nd.name); strcpy($$.sem_nd.type, "frac"); }
	| DOUBLE_CONST		 { $$.sem_nd.nd = mknode(NULL, NULL, "DOUBLE_CONST"); strcpy($$.sem_nd.type, "double"); }
	| STRING_LITERAL	 { $$.sem_nd.nd = mknode(NULL, NULL, $1.sem_nd.name); strcpy($$.sem_nd.type, "string_literal"); }
	| '(' expression ')' { $$.sem_nd.nd = mknode($2.sem_nd.nd, NULL, "PRIM_EXPR"); }
	;

argument_expression_list
	: assignment_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "ARGU_EXPR_LIST"); }
	| argument_expression_list ',' assignment_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "ARGU_EXPR_LIST"); }
	;

statement_list
	: statement	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT_LIST"); }
	| statement_list statement { $$.sem_nd.nd = mknode($1.sem_nd.nd, $2.sem_nd.nd, "STAT_LIST"); }
	;

statement
	: declaration			{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT"); }
	| compound_statement	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT"); }
	| expression_statement	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT"); }
	| selection_statement	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT"); }
	| iteration_statement	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT"); }
	| jump_statement		{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT"); }
	| in_out_statement		{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT"); }
	;

// declaration_list
// 	: declaration					{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "DECLR_LIST"); }
// 	| declaration_list declaration	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, $2.sem_nd.nd, "DECLR_LIST"); }
// 	;

declaration
	: type_specifier init_declarator_list EOL	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, $2.sem_nd.nd, "DECLR"); }
	| type_specifier mulendoflines init_declarator_list EOL	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "DECLR"); }
	;

mulendoflines
	: EOL 
	| mulendoflines EOL { $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "MUL_END_OF_LINES"); }
	;

init_declarator_list
	: init_declarator							{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "INIT_DECLR_LIST"); }
	| init_declarator_list ',' init_declarator	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "INIT_DECLR_LIST"); }
	;

init_declarator
	: declarator						{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "INIT_DECLR"); strcpy($$.sem_nd.type, $1.sem_nd.type); }
	| declarator '=' initializer		{ $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "INIT_DECLR"); 
			if(/*print("14") && */check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type);
			}
		}
	| declarator ':' initializer_list 	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "INIT_DECLR"); strcpy($$.sem_nd.type, $1.sem_nd.type); }
	;

initializer_list
	: initializer						{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "INIT_LIST"); strcpy($$.sem_nd.type, $1.sem_nd.type);}
	| initializer_list ',' initializer	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "INIT_LIST"); strcpy($$.sem_nd.type, $3.sem_nd.type);}
	;

declarator
	: direct_declarator					{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "DECLR"); strcpy($$.sem_nd.type, $1.sem_nd.type); }
	;

direct_declarator
	: IDENTIFIER	{ add('V'); }				{ $$.sem_nd.nd = mknode(NULL, NULL, $1.sem_nd.name); 
			string a = symbol_table.back()->symbol_info[symbol_table.back()->scope_table_util[$1.sem_nd.name]]->data_type; 
			char* c = const_cast<char*>(a.c_str()); 
			strcpy($$.sem_nd.type, c);
		}
	| type_specifier {  add('V'); }				{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "DIRECT_DECLR"); 
			strcpy($$.sem_nd.type, $1.sem_nd.name); 
		}
	| '(' declarator ')'						{ $$.sem_nd.nd = mknode($2.sem_nd.nd, NULL, "DIRECT_DECLR"); }
	| direct_declarator '(' parameter_list ')'	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "DIRECT_DECLR"); }
	| direct_declarator '(' identifier_list ')'	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "DIRECT_DECLR"); }
	| direct_declarator '(' ')'					{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "DIRECT_DECLR"); }			/* shift reduce conflict here similar to c lang */
	;

identifier_list
	: IDENTIFIER	{ add('V'); }						{ $$.sem_nd.nd = mknode(NULL, NULL, $1.sem_nd.name); }
	| identifier_list ',' IDENTIFIER	{ add('V'); }	{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "IDEN_LIST"); }
	;

initializer
	: assignment_expression				{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "INITIALIZER"); strcpy($$.sem_nd.type, $1.sem_nd.type); }
	;

selection_statement
	: IF '(' expression ')' EOL compound_statement EOL ELSE EOL compound_statement	{ 
		struct node* tp = mknode($3.sem_nd.nd, $6.sem_nd.nd, "IF_STAT");
			$$.sem_nd.nd = mknode(tp, $10.sem_nd.nd, "IF_ELSE_STAT"); 
		}/* shift reduce conflict here similar to c lang */
	| IF '(' expression ')' EOL compound_statement					{ $$.sem_nd.nd = mknode($3.sem_nd.nd, $6.sem_nd.nd, "SELECT_STAT"); }
	;

iteration_statement
	: LOOP '(' expression ')' EOL compound_statement	{ $$.sem_nd.nd = mknode($3.sem_nd.nd, $6.sem_nd.nd, "ITER_STAT"); }
	;

jump_statement
	: CONTINUE EOL 
	| BREAK EOL
	| EXIT exit { $$.sem_nd.nd = mknode(NULL, $2.sem_nd.nd, "EXIT_EXPR"); }
	;

exit
	: EOL
	| ':' expression EOL { 
		$$.sem_nd.nd = mknode(NULL, $2.sem_nd.nd, "EXIT"); 
		string a = symbol_table.back()->fun_ret_type; 
		char* c = const_cast<char*>(a.c_str());
		check_return_types($2.sem_nd.type, c);
	}
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
	// if(root){
	// 	cout << "hai\n";
	// 	root->traverse();
	// }
}