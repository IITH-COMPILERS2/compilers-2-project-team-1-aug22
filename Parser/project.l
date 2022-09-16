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
		#include "project.tab.h"

		void comment();
		void token_c(FILE* fp);
		int token_no = 0;
		FILE *fp2;
%}

%%
#			    		{ }
[\n]					{ token_no++;}
";"						{ return(';'); }
break					{ return(BREAK); }
continue				{ return(CONTINUE); }
else					{ return(ELSE); }
if						{ return(IF); }
int						{ return(INT); }
double					{ return(DOUBLE); }
bool					{ return(BOOL); }
string					{ return(STRING); }
long					{ return(LONG); }
frac					{ return(FRAC); }
exit					{ return(EXIT); }      
void					{ return(VOID); }
loop					{ return(LOOP); }
input					{ return(INPUT); }
output					{ return(OUTPUT); }   
true		     		{ return(TRUE); }
false					{ return(FALSE); }

point					{ return(POINT); }
line					{ return(LINE); }
conic					{ return(CONIC); }
line_pair				{ return(LINE_PAIR); }
circle					{ return(CIRCLE); }
parabola				{ return(PARABOLA); }
ellipse					{ return(ELLIPSE); }
hyperbola				{ return(HYPERBOLA); }


{L}({L}|{D})*     		{ return(IDENTIFIER); }
{INT}\/({NZD}{D}*|0+{NZD}{D}*)		{ return(FRAC_CONST); }
{DEC}		  			{ return(DOUBLE_CONST); }
{INT}					{ return(INT_CONST); }
\"([^\\\"]|\\.)*\"		{ return(STRING_LITERAL); }

"( "           			{ return('('); }
")"             		{ return(')'); }
". "           			{ return('.'); }
"!"             		{ return('!'); }
"^ "            		{ return('^'); }

"*"            			{ return('*');}
"/ "           			{ return('/');}
"+ "            		{ return('+');}
"-"             		{ return( '-');}
"^^"             		{ return( POW_OP); }
"== "           		{ return( EQ_OP);}

"&&"					{ return(AND_OP); }
"||"					{ return(OR_OP); }
"="			    		{ return('='); }
"+="					{ return(ADD_ASSIGN); }
"*="					{ return(MUL_ASSIGN); }

"<="					{ return(LE_OP); }
">="					{ return(GE_OP); }
"!="					{ return(NE_OP); }
"<"			    		{ return('<'); }
">"			    		{ return('>'); }
","			    		{ return(','); }
":"			    		{ return(':'); }
"->"					{ return(ARROW); }
"<<"					{ return(FUN_ST);}
">>"					{ return(FUN_EN);}

.			    		{ /* ignore bad characters */ }

<<EOF>>         		{ return 0;}
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

// int main(int argc, char* argv[])
// {

// 	int n = atoi(argv[1]);
// 	char inp_file[50] = "testCases/test";
// 	char ch = 48+n;

// 	strncat(inp_file, &ch, 1);
// 	char temp[50] = ".cop";
// 	strcat(inp_file,temp);
	
// 	FILE* fp1 = fopen(inp_file, "r");
// 	yyin = fp1;


// 	char out_file[50] = "outputs/output";
// 	strncat(out_file, &ch, 1);
// 	fp2 = fopen(out_file, "w");


//     yylex();
// 	fclose(fp1);
// 	fclose(fp2);

    
// 	return 0;
// }

int yywrap() {
    return 1;
}

void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}
