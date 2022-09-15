%token IDENTIFIER FRAC_CONST DOUBLE_CONST INT_CONST STRING_LITERAL
%token ARROW LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN ADD_ASSIGN
%token AND_ASSIGN

%token TYPEDEF
%token STRING INT LONG BOOL FRAC DOUBLE TRUE FALSE VOID
%token STRUCT INPUT OUTPUT

%token IF ELSE LOOP CONTINUE BREAK EXIT

%token POINT LINE CONIC LINE_PAIR CIRCLE PARABOLA ELLIPSE HYPERBOLA
%token MAIN
%token EQ
%token _A _B _H _G _F _C _DELTA ON_CURVE
%token _X _Y SLOPE ACUTE_ANG_BISECS OBTUSE_ANG_BISECS ANGLE

%token CENTRE TANGENT NORMAL RADIUS AREA
%token FOCII DIRECT ECCEN P_AXIS VERTICES FOCAL_CHORD DOUBLE_ORDINATE LATUS_RECTUM INTERSEC_PT 
%token LEN_MAJ_AXIS LEN_MIN_AXIS LATUS_RECTA FOCAL_RADII DIR_CIRCLE AUX_CIRCLE CIRCUMF TRANS_AXIS CONJ_AXIS ASYMPTOTES

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
    : IDENTIFIER parameter_list '->' type_specifier compound_statement
	;

parameter_list
	:
	| '\:' parameters
	;

parameters
	: type_specifier IDENTIFIER
	| parameters ',' type_specifier IDENTIFIER
	;

type_specifier
	: VOID
	| BOOL
	| STRING
	| INT
	| LONG
	| DOUBLE
	| FRAC
	| POINT
	| PARABOLA
	| ELLIPSE
	| HYPERBOLA
	| CIRCLE
	| CONIC
	| LINE
	| LINE_PAIR
	;


compound_statement
	: '\'' '\''
	| '\'' statement_list '\''
	| '\'' declaration_list '\''
	| '\'' declaration_list statement_list '\''
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
	: direct_declarator
	| direct_declarator '=' initializer

direct_declarator
	: IDENTIFIER
	| '(' direct_declarator ')'
	| direct_declarator '[' constant_expression ']'
	| direct_declarator '[' ']'
	| direct_declarator '(' parameter_type_list ')'
	| direct_declarator '(' identifier_list ')'
	| direct_declarator '(' ')'
	;

constant_expression
	: conditional_expression
	;

conditional_expression
	: logical_or_expression
	| logical_or_expression '?' expression ':' conditional_expression
	;


primary_expression
	: IDENTIFIER
	| CONSTANT
	| STRING_LITERAL
	| '(' expression ')'
	;

postfix_expression
	: primary_expression
	| postfix_expression '[' expression ']'
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')'
	| postfix_expression '.' IDENTIFIER								##doubt
	| postfix_expression PTR_OP IDENTIFIER							##doubt
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;

unary_expression
	: postfix_expression
	| INC_OP unary_expression
	| DEC_OP unary_expression
	| unary_operator cast_expression
	| SIZEOF unary_expression
	| SIZEOF '(' type_name ')'
	;

unary_operator
	: '&'
	| '*'
	| '+'
	| '-'
	| '~'
	| '!'
	;

cast_expression
	: unary_expression
	| '(' type_name ')' cast_expression
	;

multiplicative_expression
	: cast_expression
	| multiplicative_expression '*' cast_expression
	| multiplicative_expression '/' cast_expression
	| multiplicative_expression '%' cast_expression
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression
	| additive_expression '-' multiplicative_expression
	;

shift_expression
	: additive_expression
	| shift_expression LEFT_OP additive_expression
	| shift_expression RIGHT_OP additive_expression
	;

relational_expression
	: shift_expression
	| relational_expression '<' shift_expression
	| relational_expression '>' shift_expression
	| relational_expression LE_OP shift_expression
	| relational_expression GE_OP shift_expression
	;

equality_expression
	: relational_expression
	| equality_expression EQ_OP relational_expression
	| equality_expression NE_OP relational_expression
	;

and_expression
	: equality_expression
	| and_expression '&' equality_expression
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression '^' and_expression
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression
	;

logical_and_expression
	: inclusive_or_expression
	| logical_and_expression AND_OP inclusive_or_expression
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OR_OP logical_and_expression
	;

conditional_expression
	: logical_or_expression
	| logical_or_expression '?' expression ':' conditional_expression
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression
	;

assignment_operator
	: '='
	| MUL_ASSIGN
	| DIV_ASSIGN
	| MOD_ASSIGN
	| ADD_ASSIGN
	| SUB_ASSIGN
	| LEFT_ASSIGN
	| RIGHT_ASSIGN
	| AND_ASSIGN
	| XOR_ASSIGN
	| OR_ASSIGN
	;
	
expression
	: assignment_expression
	| expression ',' assignment_expression
	;