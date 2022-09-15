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
    : IDENTIFIER parameter_list '->' declaration_specifiers compound_statement
	;
