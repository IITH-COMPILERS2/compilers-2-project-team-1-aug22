%option noyywrap

D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]                             /*doubtful*/
E			[Ee][+-]?{D}+

%{
    #include <stdio.h>
    void count();
	void comment();
%}

%%
"#"			    { count(); }
"break"			{ count(); printf("BREAK"); }
"continue"		{ count(); printf("CONTINUE"); }
"else"			{ count(); printf("ELSE"); }
"if"			{ count(); printf("IF"); }
"int"			{ count(); printf("INT"); }
"double"		{ count(); printf("DOUBLE"); }
"bool"		    { count(); printf("BOOL"); }
"string"		{ count(); printf("STRING"); }
"long"			{ count(); printf("LONG"); }
"frac"		    { count(); printf("FRAC"); }
"exit"		    { count(); printf("EXIT"); }
"struct"		{ count(); printf("STRUCT"); }        /*doubtful*/
"typedef"		{ count(); printf("TYPEDEF"); }       /*doubtful*/
"void"			{ count(); printf("VOID"); }
"loop"			{ count(); printf("LOOP"); }

"point"		    { count(); printf("POINT"); }
"line"		    { count(); printf("LINE"); }
"conic"		    { count(); printf("CONIC"); }
"line_pair"		{ count(); printf("LINE_PAIR"); }
"circle"		{ count(); printf("CIRCLE"); }
"parabola"		{ count(); printf("PARABOLA"); }
"ellipse"		{ count(); printf("ELLIPSE"); }
"hyperbola"		{ count(); printf("HYPERBOLA"); }
"input"         { count(); printf("INPUT"); }

"("             { count(); printf("("); }
")"             { count(); printf(")"); }
"."             { count(); printf("."); }
"!"             { count(); printf("!"); }
"^"             { count(); printf("^"); }

"* "            { count(); printf ("MUL_OP");}
"/"             { count(); printf ("DIV_OP");}
"+"             { count(); printf ("ADD_OP");}
"-"             { count(); printf ("SUB_OP");}
"=="            { count(); printf ("EQ_OP");}

"&&"			{ count(); printf("AND_OP"); }
"||"			{ count(); printf("OR_OP"); }
"="			    { count(); printf("="); }
"+="			{ count(); printf("ADD_ASSIGN"); }
"*="			{ count(); printf("MUL_ASSIGN"); }

"<="			{ count(); printf("LE_OP"); }
">="			{ count(); printf("GE_OP"); }
"!="			{ count(); printf("NE_OP"); }
"<"			    { count(); printf("<"); }
">"			    { count(); printf(">"); }
","			    { count(); printf(","); }
":"			    { count(); printf(":"); }
"->"			{ count(); printf("PTR_OP"); }
"'"             { count(); printf("'");}

.			    { /* ignore bad characters */ }

<<EOF>>         {return 0;}
%%

int column = 0;

void comment()
{
  int c;

  /* Read until we find \n or EOF */
  while((c = input()) != '\n' && c != EOF)
    ;

  /* Maybe you want to place back EOF? */
  if(c == EOF)
    unput(c);
}


void count()
{
	int i;
	for(i = 0; yytext[i] != '\0'; i++)
	{
		if (yytext[i] == '\n')
		{
			column = 0;
		}
		else if (yytext[i] == '\t')
		{
			column += 8 - (column % 8);
		}
		else
		{
			column++;
		}
	}
	ECHO;
}

int main()
{
    yylex();

    return 0;
}