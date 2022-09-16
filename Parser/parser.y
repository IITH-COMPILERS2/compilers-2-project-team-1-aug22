%token IDENTIFIER FRAC_CONST DOUBLE_CONST INT_CONST STRING_LITERAL
%token ARROW LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN ADD_ASSIGN

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
	: '{' '}'
	| '{' statement_list '}'
	| '{' declaration_list '}'
	| '{' declaration_list statement_list '}'
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
