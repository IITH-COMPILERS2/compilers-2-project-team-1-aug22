%token IDENTIFIER FRAC_CONST DOUBLE_CONST INT_CONST STRING_LITERAL
%token ARROW LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN ADD_ASSIGN
%token AND_ASSIGN

%token TYPEDEF
%token STRING INT LONG BOOL FRAC DOUBLE TRUE FALSE VOID
%token STRUCT INPUT OUTPUT

%token IF ELSE LOOP CONTINUE BREAK EXIT

%start translation_unit

translation_unit
	: external_declaration
	| translation_unit external_declaration
	;

external_declaration
	: function_definition
	| declaration
	;

function_definition
    : IDENTIFIER parameter_list '->' declaration_specifiers compound_statement
