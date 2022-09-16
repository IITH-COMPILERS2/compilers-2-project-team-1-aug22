D			[0-9]
NZD         [1-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]                             
E			[Ee][+-]?{D}+
DEC 		[+-]?{D}+[.]{D}+
INT			[+-]?{D}+	

%{
		#include <stdio.h>
		#include <stdlib.h>
		#include <string.h>
		#include "y.tab.h"

		void comment();
		void token_c(FILE* fp);
		int token_no = 0;
		FILE *fp2;
%}

%%
#			    		{ token_c(fp2); }
\n						{ token_c(fp2); return(EOL);}
break					{ token_c(fp2); return(BREAK); }
continue				{ token_c(fp2); return(CONTINUE); }
else					{ token_c(fp2); return(ELSE); }
if						{ token_c(fp2); return(IF); }
int						{ token_c(fp2); return(INT); }
double					{ token_c(fp2); return(DOUBLE); }
bool					{ token_c(fp2); return(BOOL); }
string					{ token_c(fp2); return(STRING); }
long					{ token_c(fp2); return(LONG); }
frac					{ token_c(fp2); return(FRAC); }
exit					{ token_c(fp2); return(EXIT); }      
void					{ token_c(fp2); return(VOID); }
loop					{ token_c(fp2); return(LOOP); }
input					{ token_c(fp2); return(INPUT); }
output					{ token_c(fp2); return(OUTPUT); }   
true		     		{ token_c(fp2); return(TRUE); }
false					{ token_c(fp2); return(FALSE); }

point					{ token_c(fp2); return(POINT); }
line					{ token_c(fp2); return(LINE); }
conic					{ token_c(fp2); return(CONIC); }
line_pair				{ token_c(fp2); return(LINE_PAIR); }
circle					{ token_c(fp2); return(CIRCLE); }
parabola				{ token_c(fp2); return(PARABOLA); }
ellipse					{ token_c(fp2); return(ELLIPSE); }
hyperbola				{ token_c(fp2); return(HYPERBOLA); }
main					{ token_c(fp2); return(MAIN); }


{L}({L}|{D})*     		{ token_c(fp2); return(IDENTIFIER); }
{INT}\/({NZD}{D}*|0+{NZD}{D}*)		{ token_c(fp2); return(FRAC_CONST); }
{DEC}		  			{ token_c(fp2); return(DOUBLE_CONST); }
{INT}					{ token_c(fp2); return(INT_CONST); }
\"([^\\\"]|\\.)*\"		{ token_c(fp2); return(STRING_LITERAL); }

"( "           			{ token_c(fp2); return('('); }
")"             		{ token_c(fp2); return(')'); }
". "           			{ token_c(fp2); return('.'); }
"!"             		{ token_c(fp2); return('!'); }
"^ "            		{ token_c(fp2); return('^'); }

"*"            			{ token_c(fp2); return('*');}
"/ "           			{ token_c(fp2); return('/');}
"+ "            		{ token_c(fp2); return('+');}
"-"             		{ token_c(fp2); return( '-');}
"^^"             		{ token_c(fp2); return( POW_OP); }
"== "           		{ token_c(fp2); return( EQ_OP);}

"&&"					{ token_c(fp2); return(AND_OP); }
"||"					{ token_c(fp2); return(OR_OP); }
"="			    		{ token_c(fp2); return('='); }
"+="					{ token_c(fp2); return(ADD_ASSIGN); }
"*="					{ token_c(fp2); return(MUL_ASSIGN); }

"<="					{ token_c(fp2); return(LE_OP); }
">="					{ token_c(fp2); return(GE_OP); }
"!="					{ token_c(fp2); return(NE_OP); }
"<"			    		{ token_c(fp2); return('<'); }
">"			    		{ token_c(fp2); return('>'); }
","			    		{ token_c(fp2); return(','); }
":"			    		{ token_c(fp2); return(':'); }
"->"					{ token_c(fp2); return(ARROW); }
"<<"					{ token_c(fp2); return(FUN_ST);}
">>"					{ token_c(fp2); return(FUN_EN);}

.			    		{ /* ignore bad characters */ }

<<EOF>>         		{ 0;}
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

void token_c(FILE* fp)
{
	token_no++;
	fprintf(fp, "%d" , token_no);
	;
}

int main(int argc, char* argv[])
{

	int n = atoi(argv[1]);
	char inp_file[50] = "testCases/test";
	char ch = 48+n;

	strncat(inp_file, &ch, 1);
	char temp[50] = ".cop";
	strcat(inp_file,temp);
	
	FILE* fp1 = fopen(inp_file, "r");
	yyin = fp1;


	char out_file[50] = "outputs/output";
	strncat(out_file, &ch, 1);
	fp2 = fopen(out_file, "w");


    yylex();
	fclose(fp1);
	fclose(fp2);

    
	return 0;
}

int yywrap() {
    return 1;
}

void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}
