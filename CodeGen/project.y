%{
	#include "../Semantics.hpp"
	#include "../AST.hpp"
	#include "../functions.hpp"
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

%token <obj> POINT LINE CONIC LINE_PAIR CIRCLE PARABOLA ELLIPSE HYPERBOLA EQ_ CONIC_NAME

%left EQ_OP NE_OP
%left AND_OP OR_OP
%left LE_OP GE_OP '<' '>'
%left '+' '-'
%left '*' '/' '%'
%nonassoc '!'

%type <obj> translation_unit external_declaration function_definition parameter_list parameters type_specifier conic_specifier
  compound_statement expression_statement expression assignment_expression
  assignment_operator conditional_expression logical_or_expression logical_and_expression
  equality_expression relational_expression additive_expression multiplicative_expression
  cast_expression unary_expression unary_operator postfix_expression primary_expression
  argument_expression_list statement_list statement /*declaration_list*/ declaration 
  mulendoflines init_declarator_list init_declarator declarator jump_statement exit input output temp_fun
  direct_declarator identifier_list initializer selection_statement iteration_statement 

%type <obj> '=' '+' '-' '!'

%start translation_unit

%%

translation_unit
	: { enter_scope(); } external_declaration 
	{
		$$.sem_nd.nd = mknode(NULL, $2.sem_nd.nd, "TRANSLATION_UNIT"); head = $$.sem_nd.nd;
		$$.cg_nd = new Node;
		$$.cg_nd->start = new Start();
		$$.cg_nd->start->store($2.cg_nd);
		root = $$.cg_nd->start;
	}
	| translation_unit external_declaration
	{
		$2.sem_nd.nd = mknode(NULL, NULL, "TRANSLATION_UNIT"); $$.sem_nd.nd = mknode($1.sem_nd.nd, $2.sem_nd.nd, "TRANSLATION_UNIT"); head = $$.sem_nd.nd;
		$$.cg_nd->start->store($2.cg_nd);
	}
	;

external_declaration
	: mulendoflines
	| function_definition
	{
		$$.sem_nd.nd = mknode(NULL, $1.sem_nd.nd, "EXTERNAL_DECLR");
		$$.cg_nd = new Node;
		$$.cg_nd->decl = NULL;
		$$.cg_nd->func_def = $1.cg_nd->func_def;
	}
	| declaration
	{
		$$.cg_nd = new Node;
		$$.cg_nd->func_def = NULL;
		$$.cg_nd->decl = $1.cg_nd->decl;
	}
	;

function_definition
    : IDENTIFIER { function_name = yytext; is_function_now = true; } parameter_list ARROW error_fun type_specifier { ret_type = yytext; add('F'); } EOL compound_statement
	{
		struct node* tp = mknode($3.sem_nd.nd, $6.sem_nd.nd, "OPTIONS");
		$$.sem_nd.nd = mknode(tp, $9.sem_nd.nd, $1.sem_nd.name);
		$$.cg_nd = new Node;
		if(param_id.size() == 0){
			$$.cg_nd->func_def = new Function_Def(string($1.sem_nd.name), string(ret_type), $9.cg_nd->block);
		}
		else{
			vector<Variable*> vars;
			for(auto i : param_id){
				vars.push_back(new Variable(i.second, i.first));
			}
			$$.cg_nd->func_def = new Function_Def(string($1.sem_nd.name), vars, string(ret_type), $9.cg_nd->block);
			param_id.clear();
			function_params.clear();
		}
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
	;	
	

conic_specifier
	: PARABOLA	{ insert_type(); }		
	| ELLIPSE	{ insert_type(); }		
	| HYPERBOLA	{ insert_type(); }		
	| CIRCLE	{ insert_type(); }		
	| CONIC		{ insert_type(); }		
	| LINE		{ insert_type(); }		
	| LINE_PAIR	{ insert_type(); }
	;

// in_out_specifier
// 	: INPUT		{ insert_type(); }
// 	| OUTPUT	{ insert_type(); }
// 	;

compound_statement
	: FUN_ST FUN_EN
	{
		$$.sem_nd.nd = mknode(NULL, NULL, "COMPOUND_STATEMENT");
	}
	| FUN_ST temp_fun statement_list FUN_EN
	{
		$$.sem_nd.nd = mknode(NULL, $3.sem_nd.nd, "COMPOUND_STATEMENT");
		exit_scope();
		$$.cg_nd = new Node;
		$$.cg_nd->block = new Block($3.cg_nd->stmts);
	}
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
			// function_params.clear();
			is_function_now = false;
		}
	}
	;

expression_statement
	: EOL
	{
		$$.cg_nd = new Node;
		$$.cg_nd->num = 3;
	}
	| expression EOL
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "EXPR_ST");
		$$.cg_nd = $1.cg_nd;
	}
	;

expression
	: assignment_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "EXPR");
		strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = $1.cg_nd;
	}
	| expression ',' assignment_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "EXPR");
		strcpy($$.sem_nd.type, $3.sem_nd.type);
		$$.cg_nd = $3.cg_nd;
	}
	;

assignment_expression
	: conditional_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "ASS_EXPR");
		strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = new Node;
		if($1.cg_nd->num == 7){
			$$.cg_nd->num = $1.cg_nd->num;
			$$.cg_nd->function_call = $1.cg_nd->function_call;
		}
		else if($1.cg_nd->num == 2){
			$$.cg_nd->num = 7;
			$$.cg_nd->function_call = $1.cg_nd->function_call;
		}
		else if($1.cg_nd->num == 4){
			$$.cg_nd = $1.cg_nd;
		}
		else{
			$$.cg_nd->ass_expr = new Assignment_expr($1.cg_nd->cond_expr);
			$$.cg_nd->cond_expr = $1.cg_nd->cond_expr;
		}
	}
	| unary_expression assignment_operator assignment_expression
	{
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
		$$.cg_nd = new Node;
		$$.cg_nd->ass_expr = new Assignment_expr($1.cg_nd->cond_expr->getLocation(), $2.sem_nd.name, $3.cg_nd->cond_expr);
		$$.cg_nd->cond_expr = $3.cg_nd->cond_expr;
	}
	;

assignment_operator
	: '='
	| MUL_ASSIGN
	| ADD_ASSIGN
	;

conditional_expression
	: logical_or_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "COND_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = $1.cg_nd;
	}
	;

logical_or_expression
	: logical_and_expression 
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "LOGI_OR_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = $1.cg_nd;
	}
	| logical_or_expression OR_OP logical_and_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "OR");
		if(strcmp($1.sem_nd.type, "undefined") != 0 && strcmp($3.sem_nd.type, "undefined") != 0){
			if(/*print("2") && */check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type);
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
		$$.cg_nd = new Node;
		$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->cond_expr, $2.sem_nd.name, $3.cg_nd->cond_expr);
	}
	;

logical_and_expression
	: equality_expression 
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "LOGI_AND_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = $1.cg_nd;
	}
	| logical_and_expression AND_OP equality_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "AND"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("3") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
		$$.cg_nd = new Node;
		$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->cond_expr, $2.sem_nd.name, $3.cg_nd->cond_expr);
	}
	;

equality_expression
	: relational_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "EQ_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = $1.cg_nd;
	}
	| equality_expression EQ_OP relational_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "=="); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("4") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
		$$.cg_nd = new Node;
		$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->cond_expr, $2.sem_nd.name, $3.cg_nd->cond_expr);
	}
	| equality_expression NE_OP relational_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "!="); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("5") && */check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
		$$.cg_nd = new Node;
		$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->cond_expr, $2.sem_nd.name, $3.cg_nd->cond_expr);
	}
	;

relational_expression
	: additive_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "RELATIONAL_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = $1.cg_nd;
	}
	| relational_expression '<' additive_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "<"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("6") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
		$$.cg_nd = new Node;
		$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->cond_expr, "<", $3.cg_nd->cond_expr);
	}
	| relational_expression '>' additive_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, ">"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("7") && */check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
		$$.cg_nd = new Node;
		$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->cond_expr, ">", $3.cg_nd->cond_expr);
	}
	| relational_expression LE_OP additive_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "<="); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("8") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
		$$.cg_nd = new Node;
		$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->cond_expr, $2.sem_nd.name, $3.cg_nd->cond_expr);
	}
	| relational_expression GE_OP additive_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, ">="); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("9") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
		$$.cg_nd = new Node;
		$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->cond_expr, $2.sem_nd.name, $3.cg_nd->cond_expr);
	}
	;

additive_expression
	: multiplicative_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "ADDITIVE_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = $1.cg_nd;
	}
	| additive_expression '+' multiplicative_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "+"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			//print(to_string(check_types($1.sem_nd.type, $3.sem_nd.type)));
			if(/*print("10") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
		$$.cg_nd = new Node;
		$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->cond_expr, $2.sem_nd.name, $3.cg_nd->cond_expr);
	}
	| additive_expression '-' multiplicative_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "-"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("11") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
		$$.cg_nd = new Node;
		$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->cond_expr, $2.sem_nd.name, $3.cg_nd->cond_expr);
	}
	;

multiplicative_expression
	: cast_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "MUL_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = $1.cg_nd;
	}
	| multiplicative_expression '*' cast_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "*"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("12") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
		$$.cg_nd = new Node;
		$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->cond_expr, "*", $3.cg_nd->cond_expr);
	}
	| multiplicative_expression '/' cast_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "/"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("13") &&*/ check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
		$$.cg_nd = new Node;
		$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->cond_expr, "/", $3.cg_nd->cond_expr);
	}
	| multiplicative_expression '%' cast_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "%"); 
		if(strcmp($1.sem_nd.type, "undefined") !=0 && strcmp($3.sem_nd.type, "undefined") !=0){
			if(/*print("14") && */check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
				strcpy($$.sem_nd.type, $1.sem_nd.type); 
			}
			else{
				strcpy($$.sem_nd.type, "undefined");
			}
		}
		$$.cg_nd = new Node;
		$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->cond_expr, "%", $3.cg_nd->cond_expr);
	}
	;

cast_expression
	: unary_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "CAST_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = $1.cg_nd;
	}
	| '(' type_specifier ')' cast_expression
	{
		$$.sem_nd.nd = mknode($2.sem_nd.nd, $4.sem_nd.nd, "CAST_EXPR"); strcpy($$.sem_nd.type, $2.sem_nd.name);
		$$.cg_nd = $4.cg_nd;
	}
	;

unary_expression
	: postfix_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "UNARY_EXPR"); strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = $1.cg_nd;
	}
	| unary_operator cast_expression { $$.sem_nd.nd = mknode($1.sem_nd.nd, $2.sem_nd.nd, "UNARY_EXPR"); strcpy($$.sem_nd.type, $2.sem_nd.type); }
	;

unary_operator
	: '+'
	| '-'
	| '!'
	;

postfix_expression
	: primary_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "POSTFIX_EXPR"); 
		strcpy($$.sem_nd.type, $1.sem_nd.type);
		if($1.cg_nd->num == 2 || $1.cg_nd->num == 4){
			$$.cg_nd = $1.cg_nd;
		}
		else{
			$$.cg_nd = new Node;
			if(is_identifier_sign==0){
				Location* temp = new Location(-1);
				Conditional_expr* temp1 = new Conditional_expr(temp);
				Conditional_expr* temp2 = new Conditional_expr($1.cg_nd->loc);
				$$.cg_nd->cond_expr = new Conditional_expr(temp1,"*",temp2);
				is_identifier_sign=1;
			}
			else{
				$$.cg_nd->cond_expr = new Conditional_expr($1.cg_nd->loc);
			}
		}
	}
	| IDENTIFIER '(' ')'
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "POSTFIX_EXPR");
		strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = new Node;
		// $$.cg_nd->num = 7;
		$$.cg_nd->function_call = new FunctionCall($1.sem_nd.name);
		fun_call_params.clear();
		$$.cg_nd->cond_expr = new Conditional_expr($$.cg_nd->function_call);
	}
	| IDENTIFIER '(' argument_expression_list ')'
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "POSTFIX_EXPR");
		$$.cg_nd = new Node;
		// $$.cg_nd->num = 7;
		$$.cg_nd->function_call = new FunctionCall($1.sem_nd.name, fun_call_params);
		fun_call_params.clear();
		$$.cg_nd->cond_expr = new Conditional_expr($$.cg_nd->function_call);
		// fun_call_params.clear();
	}
	| IDENTIFIER '.' IDENTIFIER '(' ')'
	{
		$$.cg_nd = new Node;
		string id1 = string($1.sem_nd.name);
		string id2 = string($3.sem_nd.name);
		if(id2 == "slope"){
			if(getLine(id1)){
				Location* loc = new Location(lines[id1]->slope());
				$$.cg_nd->cond_expr = new Conditional_expr(loc);
			}
		}
		else if(id2 == "delta"){
			if(getConic(id1)){
				Location* loc = new Location(lines[id1]->delta());
				$$.cg_nd->cond_expr = new Conditional_expr(loc);
			}
			else if(getLine(id1)){
				Location* loc = new Location(lines[id1]->delta());
				$$.cg_nd->cond_expr = new Conditional_expr(loc);
			}
			else if(getCircle(id1)){
				Location* loc = new Location(lines[id1]->delta());
				$$.cg_nd->cond_expr = new Conditional_expr(loc);
			}
			else if(getParabola(id1)){
				Location* loc = new Location(lines[id1]->delta());
				$$.cg_nd->cond_expr = new Conditional_expr(loc);
			}
			else if(getHyperbola(id1)){
				Location* loc = new Location(lines[id1]->delta());
				$$.cg_nd->cond_expr = new Conditional_expr(loc);
			}
			else if(getEllipse(id1)){
				Location* loc = new Location(lines[id1]->delta());
				$$.cg_nd->cond_expr = new Conditional_expr(loc);
			}
		}
		else if(id2 == "eccen"){
			if(getConic(id1)){
				Location* loc = new Location(lines[id1]->eccen());
				$$.cg_nd->cond_expr = new Conditional_expr(loc);
			}
			else if(getLine(id1)){
				Location* loc = new Location(lines[id1]->eccen());
				$$.cg_nd->cond_expr = new Conditional_expr(loc);
			}
			else if(getCircle(id1)){
				Location* loc = new Location(lines[id1]->eccen());
				$$.cg_nd->cond_expr = new Conditional_expr(loc);
			}
			else if(getParabola(id1)){
				Location* loc = new Location(lines[id1]->eccen());
				$$.cg_nd->cond_expr = new Conditional_expr(loc);
			}
			else if(getHyperbola(id1)){
				Location* loc = new Location(lines[id1]->eccen());
				$$.cg_nd->cond_expr = new Conditional_expr(loc);
			}
			else if(getEllipse(id1)){
				Location* loc = new Location(lines[id1]->eccen());
				$$.cg_nd->cond_expr = new Conditional_expr(loc);
			}
		}
		//else if(id2 == "")
		// $$.cg_nd = new Node;
		// $$.cg_nd->cond_expr = new Conditional_expr();
	}
	| IDENTIFIER '.' IDENTIFIER '(' argument_expression_list ')'
	{

	}
	;

argument_expression_list
	: IDENTIFIER
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "ARGU_EXPR_LIST");
		fun_call_params.push_back($1.sem_nd.name);
	}
	| argument_expression_list ',' IDENTIFIER
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "ARGU_EXPR_LIST");
		fun_call_params.push_back($3.sem_nd.name);
	}
	;


primary_expression
	: IDENTIFIER		 
	{
		check_declarations($1.sem_nd.name); $$.sem_nd.nd = mknode(NULL, NULL, $1.sem_nd.name);
		if(!search($1.sem_nd.name)){
			strcpy($$.sem_nd.type, "undefined");
		}
		else{
			string a = symbol_table.back()->symbol_info[symbol_table.back()->scope_table_util[$1.sem_nd.name]]->data_type; 
			char* c = const_cast<char*>(a.c_str()); 
			strcpy($$.sem_nd.type, c); 
		}
		$$.cg_nd = new Node;
		$$.cg_nd->loc = new Location(string($1.sem_nd.name), 0);
		if(sign < 0){
			is_identifier_sign = 0;
			sign = 1;
		}
	}		
	| INT_CONST
	{
		$$.sem_nd.nd = mknode(NULL, NULL, "INT_CONST");
		strcpy($$.sem_nd.type, "int"); /*print($$.sem_nd.type);*/ 
		$$.cg_nd = new Node;
		$$.cg_nd->loc = new Location(stoi($1.sem_nd.name));
		if(sign == -1){
			sign = 1;
		}
	}
	| FRAC_CONST
	{
		$$.sem_nd.nd = mknode(NULL, NULL, $1.sem_nd.name);
		strcpy($$.sem_nd.type, "frac");
	}
	| DOUBLE_CONST
	{
		$$.sem_nd.nd = mknode(NULL, NULL, "DOUBLE_CONST");
		strcpy($$.sem_nd.type, "double");
		$$.cg_nd = new Node;
		$$.cg_nd->loc = new Location(stod($1.sem_nd.name));
		if(sign == -1){
			sign = 1;
		}
	}
	| STRING_LITERAL
	{
		$$.sem_nd.nd = mknode(NULL, NULL, $1.sem_nd.name);
		strcpy($$.sem_nd.type, "string_literal");
		$$.cg_nd = new Node;
		$$.cg_nd->loc = new Location(string($1.sem_nd.name), 1);
	}
	| '(' expression ')'
	{
		$$.sem_nd.nd = mknode($2.sem_nd.nd, NULL, "PRIM_EXPR");
		$$.cg_nd = new Node;
		$$.cg_nd = $2.cg_nd;
		if($2.cg_nd->num == 7){
			$$.cg_nd->num = 2;
		} else{
			$$.cg_nd->num = 4;
		}
	}
	;

statement_list
	: statement
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT_LIST");
		$$.cg_nd = new Node;
		$$.cg_nd->stmts = new Statements();
		if($1.cg_nd->num != 3)
			$$.cg_nd->stmts->store($1.cg_nd->stmt);
	}
	| statement_list statement
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $2.sem_nd.nd, "STAT_LIST");
		if($2.cg_nd->num != 3)
			$$.cg_nd->stmts->store($2.cg_nd->stmt);
	}
	;

statement
	: declaration
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT");
		$$.cg_nd = new Node;
		$$.cg_nd->stmt = $1.cg_nd->decl;
		// cout << "hi1\n";
	}
	| compound_statement
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT");
		$$.cg_nd = $1.cg_nd;
		// cout << "hi2\n";
	}
	| expression_statement
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT");
		$$.cg_nd = new Node;
		if($1.cg_nd->num == 3){
			$$.cg_nd->num = $1.cg_nd->num;
			//cout << "hi:(\n";
			//$$.cg_nd->stmt = new Assignment_expr();
		}
		else if($1.cg_nd->num == 7){
			// cout << "hai\n";
			$$.cg_nd->stmt = $1.cg_nd->function_call;
		}
		else{
			$$.cg_nd->stmt = $1.cg_nd->ass_expr;
			// cout << "hi3\n";
		}
	}
	| selection_statement
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT");
		$$.cg_nd = new Node;
		$$.cg_nd->stmt = $1.cg_nd->ifelsestmt;
		// cout << "hi4\n";
	}
	| iteration_statement
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT");
		$$.cg_nd = new Node;
		$$.cg_nd->stmt = $1.cg_nd->loopstmt;
		// cout << "hi5\n";
	}
	| jump_statement
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT");
		$$.cg_nd = new Node;
		$$.cg_nd->stmt = $1.cg_nd->exit;
		// $$.cg_nd = $1.cg_nd;
	}
	| input
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT");
		$$.cg_nd = new Node;
		$$.cg_nd->stmt = $1.cg_nd->read;
		// cout << "hi6\n";
	}
	| output
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "STAT");
		$$.cg_nd = new Node;
		$$.cg_nd->stmt = $1.cg_nd->print;
		// cout << "hi7\n";
	}
	;

declaration
	: type_specifier init_declarator_list EOL
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $2.sem_nd.nd, "DECLR");
		$$.cg_nd = new Node;
		$$.cg_nd->decl = new Declaration(type, $2.cg_nd->vars);
	}
	| type_specifier mulendoflines init_declarator_list EOL	
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "DECLR");
		$$.cg_nd = new Node;
		$$.cg_nd->decl = new Declaration(type, $3.cg_nd->vars);
	}
	| POINT IDENTIFIER ':' INT_CONST ',' INT_CONST EOL
	{
		// cout << $1.sem_nd.name << " " << $4.sem_nd.name << " " << $6.sem_nd.name << endl;
		points[string($2.sem_nd.name)] = new Point(stod($4.sem_nd.name), stod($6.sem_nd.name));
		$$.cg_nd = new Node;
		$$.cg_nd->decl = new Declaration();
	}
	| conic_specifier IDENTIFIER ':' INT_CONST ',' INT_CONST ',' INT_CONST ',' INT_CONST ',' INT_CONST ',' INT_CONST EOL
	{
		// cout << $1.sem_nd.name << " " << $4.sem_nd.name << " " << $6.sem_nd.name << endl;
		string type = string($1.sem_nd.name);
		if(type == "conic"){
			conics[string($2.sem_nd.name)] = new Conic(stod($4.sem_nd.name), stoi($6.sem_nd.name), stod($8.sem_nd.name), stoi($10.sem_nd.name), stod($12.sem_nd.name), stoi($14.sem_nd.name));
		} else if(type == "parabola"){
			parabolas[string($2.sem_nd.name)] = new Parabola(stod($4.sem_nd.name), stoi($6.sem_nd.name), stod($8.sem_nd.name), stoi($10.sem_nd.name), stod($12.sem_nd.name), stoi($14.sem_nd.name));
		} else if(type == "ellipse"){
			ellipses[string($2.sem_nd.name)] = new Ellipse(stod($4.sem_nd.name), stoi($6.sem_nd.name), stod($8.sem_nd.name), stoi($10.sem_nd.name), stod($12.sem_nd.name), stoi($14.sem_nd.name));
		} else if(type == "hyperbola"){
			hyperbolas[string($2.sem_nd.name)] = new Hyperbola(stod($4.sem_nd.name), stoi($6.sem_nd.name), stod($8.sem_nd.name), stoi($10.sem_nd.name), stod($12.sem_nd.name), stoi($14.sem_nd.name));
		} else if(type == "circle"){
			circles[string($2.sem_nd.name)] = new Circle(stod($4.sem_nd.name), stoi($6.sem_nd.name), stod($8.sem_nd.name), stoi($10.sem_nd.name), stod($12.sem_nd.name), stoi($14.sem_nd.name));
		} else if(type == "line"){
			lines[string($2.sem_nd.name)] = new Line(stod($4.sem_nd.name), stoi($6.sem_nd.name), stod($8.sem_nd.name), stoi($10.sem_nd.name), stod($12.sem_nd.name), stoi($14.sem_nd.name));
		}
		$$.cg_nd = new Node;
		$$.cg_nd->decl = new Declaration();
	}
	;

mulendoflines
	: EOL
	| mulendoflines EOL { $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "MUL_END_OF_LINES"); }
	;

init_declarator_list
	: init_declarator
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "INIT_DECLR_LIST"); 
		$$.cg_nd = new Node;
		$$.cg_nd->vars = new Variables();
		$$.cg_nd->vars->store($1.cg_nd->var);
	}
	| init_declarator_list ',' init_declarator	
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "INIT_DECLR_LIST"); 
		$$.cg_nd->vars->store($3.cg_nd->var);
	}
	;

init_declarator
	: declarator
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "INIT_DECLR"); 
		strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = new Node;
		$$.cg_nd->var = new Variable($1.sem_nd.name, type);
	}
	| declarator '=' initializer
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, $3.sem_nd.nd, "INIT_DECLR"); 
		if(/*print("14") && */check_types($1.sem_nd.type, $3.sem_nd.type) == 0){
			strcpy($$.sem_nd.type, $1.sem_nd.type);
		}
		$$.cg_nd = new Node;
		$$.cg_nd->var = new Variable($1.sem_nd.name, type, $3.cg_nd->ass_expr);
	}
	;

declarator
	: direct_declarator					{ $$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "DECLR"); strcpy($$.sem_nd.type, $1.sem_nd.type); }
	;

direct_declarator
	: IDENTIFIER	{ add('V'); }
	{
		$$.sem_nd.nd = mknode(NULL, NULL, $1.sem_nd.name); 
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
	: assignment_expression
	{
		$$.sem_nd.nd = mknode($1.sem_nd.nd, NULL, "INITIALIZER");
		strcpy($$.sem_nd.type, $1.sem_nd.type);
		$$.cg_nd = $1.cg_nd;
	}
	;

selection_statement
	: IF '(' expression ')' EOL compound_statement EOL ELSE EOL compound_statement
	{ 
		struct node* tp = mknode($3.sem_nd.nd, $6.sem_nd.nd, "IF_STAT");
		$$.sem_nd.nd = mknode(tp, $10.sem_nd.nd, "IF_ELSE_STAT"); 
		$$.cg_nd = new Node;
		$$.cg_nd->ifelsestmt = new IfElseStatement($3.cg_nd->cond_expr, $6.cg_nd->block, $10.cg_nd->block);
	}/* shift reduce conflict here similar to c lang */
	| IF '(' expression ')' EOL compound_statement EOL
	{
		$$.sem_nd.nd = mknode($3.sem_nd.nd, $6.sem_nd.nd, "SELECT_STAT");
		$$.cg_nd = new Node;
		$$.cg_nd->ifelsestmt = new IfElseStatement($3.cg_nd->cond_expr, $6.cg_nd->block);
	}
	;

iteration_statement
	: LOOP '(' expression ')' EOL compound_statement
	{
		$$.sem_nd.nd = mknode($3.sem_nd.nd, $6.sem_nd.nd, "ITER_STAT");
		$$.cg_nd = new Node;
		$$.cg_nd->loopstmt = new LoopStatement($3.cg_nd->cond_expr, $6.cg_nd->block);
	}
	;

jump_statement
	: CONTINUE EOL 
	| BREAK EOL
	| EXIT exit
	{
		$$.sem_nd.nd = mknode(NULL, $2.sem_nd.nd, "EXIT_EXPR");
		$$.cg_nd = $2.cg_nd;
	}
	;

exit
	: EOL
	{
		$$.cg_nd = new Node;
		$$.cg_nd->exit = new Exit();
	}
	| ':' expression EOL 
	{ 
		$$.sem_nd.nd = mknode(NULL, $2.sem_nd.nd, "EXIT");
		string a = symbol_table.back()->fun_ret_type;
		char* c = const_cast<char*>(a.c_str());
		check_return_types($2.sem_nd.type, c);
		$$.cg_nd = new Node;
		$$.cg_nd->exit = new Exit($2.cg_nd->ass_expr);
	}
	;

output
	: OUTPUT ':' STRING_LITERAL
	{
		$$.cg_nd = new Node;
		$$.cg_nd->print = new Print(string($3.sem_nd.name));
	}
	| OUTPUT ':' IDENTIFIER
	{
		$$.cg_nd = new Node;
		$$.cg_nd->loc = new Location($3.sem_nd.name, 0);
		$$.cg_nd->print = new Print($$.cg_nd->loc);
	}
	| OUTPUT ':' IDENTIFIER '.' EQ_ '(' ')'
	{
		$$.cg_nd = new Node;
		string id = string($3.sem_nd.name);
		string res;
		if(getConic(id)){
			 res = conics[id]->eq_();
		}
		else if(getLine(id)){
			res = lines[id]->eq_();
		}
		else if(getCircle(id)){
			res = circles[id]->eq_();
		}
		else if(getParabola(id)){
			res = parabolas[id]->eq_();
		}
		else if(getHyperbola(id)){
			res = hyperbolas[id]->eq_();
		}
		else if(getEllipse(id)){
			res = ellipses[id]->eq_();
		}
		$$.cg_nd->print = new Print(res, 1);
	}
	| OUTPUT ':' IDENTIFIER '.' CONIC_NAME '(' ')'
	{
		$$.cg_nd = new Node;
		string id = string($3.sem_nd.name);
		string res;
		if(getConic(id)){
			 res = conics[id]->conic_name();
		}
		else if(getLine(id)){
			res = lines[id]->conic_name();
		}
		else if(getCircle(id)){
			res = circles[id]->conic_name();
		}
		else if(getParabola(id)){
			res = parabolas[id]->conic_name();
		}
		else if(getHyperbola(id)){
			res = hyperbolas[id]->conic_name();
		}
		else if(getEllipse(id)){
			res = ellipses[id]->conic_name();
		}
		$$.cg_nd->print = new Print(res, 1);
	}
	// : OUTPUT ':' assignment_expression
	// {
	// 	$$.cg_nd = new Node;
	// 	$$.cg_nd->print = new Print($3.cg_nd->ass_expr);
	// }
	;
input
	: INPUT ':' IDENTIFIER
	{
		$$.cg_nd = new Node;
		$$.cg_nd->loc = new Location($3.sem_nd.name, 0);
		$$.cg_nd->read = new Read($$.cg_nd->loc);
	}
	; 

%%

int main(int argc, char* argv[]) 
{
	yyparse();
	SymbolTableGenerator();
	SemanticErrors();
	printtree(head);
	if(root){
		root->traverse();
		root->codegen();
	}
}