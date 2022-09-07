%{

}%

D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]                             ##doubtful
E			[Ee][+-]?{D}+

%%
"#"			    { comment(); }
"break"			{ count(); return(BREAK); }
"continue"		{ count(); return(CONTINUE); }
"else"			{ count(); return(ELSE); }
"if"			{ count(); return(IF); }
"int"			{ count(); return(INT); }
"double"		{ count(); return(DOUBLE); }
"bool"		    { count(); return(BOOL); }
"string"		{ count(); return(STRING); }
"long"			{ count(); return(LONG); }
"frac"		    { count(); return(FRAC); }
"exit"		    { count(); return(EXIT); }
"struct"		{ count(); return(STRUCT); }        ##doubtful
"typedef"		{ count(); return(TYPEDEF); }       ##doubtful
"void"			{ count(); return(VOID); }
"loop"			{ count(); return(LOOP); }

"point"		    { count(); return(POINT); }
"line"		    { count(); return(LINE); }
"conic"		    { count(); return(CONIC); }
"line_pair"		{ count(); return(LINE_PAIR); }
"circle"		{ count(); return(CIRCLE); }
"parabola"		{ count(); return(PARABOLA); }
"ellipse"		{ count(); return(ELLIPSE); }
"hyperbola"		{ count(); return(HYPERBOLA); }

"("             { count(); return('(') }
")"             { count(); return(')') }
"."             { count(); return('.') }
"!"             { count(); return('!') }
"^"             { count(); return('^') }

“* “            { count(); return (MUL_OP);}
“/”             { count(); return (DIV_OP);}
“+”             { count(); return (ADD_OP);}
“-”             { count(); return (SUB_OP);}
“==”            { count(); return (EQ_OP);}

"&&"			{ count(); return(AND_OP); }
"||"			{ count(); return(OR_OP); }
"="			    { count(); return('='); }
"+="			{ count(); return(ADD_ASSIGN); }
"*="			{ count(); return(MUL_ASSIGN); }

"<="			{ count(); return(LE_OP); }
">="			{ count(); return(GE_OP); }
"!="			{ count(); return(NE_OP); }
"<"			    { count(); return('<'); }
">"			    { count(); return('>'); }
","			    { count(); return(','); }
":"			    { count(); return(':'); }
"->"			{ count(); return(PTR_OP); }
"'"             { count(); return(''');}

%%