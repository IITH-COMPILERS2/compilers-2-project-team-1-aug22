%token IDENTIFIER FRAC_CONST DOUBLE_CONST INT_CONST STRING_LITERAL
%token ARROW LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN ADD_ASSIGN
%token FUN_ST FUN_EN

%token STRING INT LONG BOOL FRAC DOUBLE VOID EOL
%token TRUE FALSE
%token INPUT OUTPUT

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
    : IDENTIFIER parameter_list ARROW type_specifier compound_statement
	;

parameter_list
	:
	| ':' parameters
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
	: FUN_ST FUN_EN
	| FUN_ST statement_list FUN_EN
	| FUN_ST declaration_list FUN_EN
	| FUN_ST declaration_list statement_list FUN_EN
	;

expression_statement
	: EOL
	| expression EOL
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
	: IDENTIFIER
	| INT_CONST
	| FRAC_CONST
	| DOUBLE_CONST
	| STRING_LITERAL
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
	: declaration_specifiers EOL
	| declaration_specifiers init_declarator_list EOL
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
	: IDENTIFIER
	| '(' declarator ')'
	| direct_declarator '(' parameter_list ')'
	| direct_declarator '(' identifier_list ')'
	| direct_declarator '(' ')'							/* shift reduce conflict here similar to c lang */
	;

identifier_list
	: IDENTIFIER
	| identifier_list ',' IDENTIFIER
	;

initializer
	: assignment_expression
	;

selection_statement
	: IF '(' expression ')' statement
	| IF '(' expression ')' statement ELSE statement 	/* shift reduce conflict here similar to c lang */
	;

iteration_statement
	: LOOP '(' expression ')' statement
	;

jump_statement
	: CONTINUE EOL
	| BREAK EOL
	| EXIT EOL
	| EXIT expression EOL
	;
%%