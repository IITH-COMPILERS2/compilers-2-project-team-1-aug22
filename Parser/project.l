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
		int token_no = 1;
		FILE *fp2;
%}

%%
#			    		{ }
[\n]					{ token_no++;}
";"						{ strcpy(yylval.nd_obj.name,(yytext)); return(';'); }
break					{ strcpy(yylval.nd_obj.name,(yytext)); return(BREAK); }
continue				{ strcpy(yylval.nd_obj.name,(yytext)); return(CONTINUE); }
else					{ strcpy(yylval.nd_obj.name,(yytext)); return(ELSE); }
if						{ strcpy(yylval.nd_obj.name,(yytext)); return(IF); }
int						{ strcpy(yylval.nd_obj.name,(yytext)); return(INT); }
double					{ strcpy(yylval.nd_obj.name,(yytext)); return(DOUBLE); }
bool					{ strcpy(yylval.nd_obj.name,(yytext)); return(BOOL); }
string					{ strcpy(yylval.nd_obj.name,(yytext)); return(STRING); }
long					{ strcpy(yylval.nd_obj.name,(yytext)); return(LONG); }
frac					{ strcpy(yylval.nd_obj.name,(yytext)); return(FRAC); }
exit					{ strcpy(yylval.nd_obj.name,(yytext)); return(EXIT); }      
void					{ strcpy(yylval.nd_obj.name,(yytext)); return(VOID); }
loop					{ strcpy(yylval.nd_obj.name,(yytext)); return(LOOP); }
input					{ strcpy(yylval.nd_obj.name,(yytext)); return(INPUT); }
output					{ strcpy(yylval.nd_obj.name,(yytext)); return(OUTPUT); }   
true		     		{ strcpy(yylval.nd_obj.name,(yytext)); return(TRUE); }
false					{ strcpy(yylval.nd_obj.name,(yytext)); return(FALSE); }

point					{ strcpy(yylval.nd_obj.name,(yytext)); return(POINT); }
line					{ strcpy(yylval.nd_obj.name,(yytext)); return(LINE); }
conic					{ strcpy(yylval.nd_obj.name,(yytext)); return(CONIC); }
line_pair				{ strcpy(yylval.nd_obj.name,(yytext)); return(LINE_PAIR); }
circle					{ strcpy(yylval.nd_obj.name,(yytext)); return(CIRCLE); }
parabola				{ strcpy(yylval.nd_obj.name,(yytext)); return(PARABOLA); }
ellipse					{ strcpy(yylval.nd_obj.name,(yytext)); return(ELLIPSE); }
hyperbola				{ strcpy(yylval.nd_obj.name,(yytext)); return(HYPERBOLA); }


{L}({L}|{D})*     		{ strcpy(yylval.nd_obj.name,(yytext)); return(IDENTIFIER); }
{INT}\/({NZD}{D}*|0+{NZD}{D}*)		{ strcpy(yylval.nd_obj.name,(yytext)); return(FRAC_CONST); }
{DEC}		  			{ strcpy(yylval.nd_obj.name,(yytext)); return(DOUBLE_CONST); }
{INT}					{ strcpy(yylval.nd_obj.name,(yytext)); return(INT_CONST); }
\"([^\\\"]|\\.)*\"		{ strcpy(yylval.nd_obj.name,(yytext)); return(STRING_LITERAL); }

"( "           			{ strcpy(yylval.nd_obj.name,(yytext)); return('('); }
")"             		{ strcpy(yylval.nd_obj.name,(yytext)); return(')'); }
". "           			{ strcpy(yylval.nd_obj.name,(yytext)); return('.'); }
"!"             		{ strcpy(yylval.nd_obj.name,(yytext)); return('!'); }
"^ "            		{ strcpy(yylval.nd_obj.name,(yytext)); return('^'); }

"*"            			{ strcpy(yylval.nd_obj.name,(yytext)); return('*');}
"/ "           			{ strcpy(yylval.nd_obj.name,(yytext)); return('/');}
"+ "            		{ strcpy(yylval.nd_obj.name,(yytext)); return('+');}
"-"             		{ strcpy(yylval.nd_obj.name,(yytext)); return( '-');}
"^^"             		{ strcpy(yylval.nd_obj.name,(yytext)); return( POW_OP); }
"== "           		{ strcpy(yylval.nd_obj.name,(yytext)); return( EQ_OP);}

"&&"					{ strcpy(yylval.nd_obj.name,(yytext)); return(AND_OP); }
"||"					{ strcpy(yylval.nd_obj.name,(yytext)); return(OR_OP); }
"="			    		{ strcpy(yylval.nd_obj.name,(yytext)); return('='); }
"+="					{ strcpy(yylval.nd_obj.name,(yytext)); return(ADD_ASSIGN); }
"*="					{ strcpy(yylval.nd_obj.name,(yytext)); return(MUL_ASSIGN); }

"<="					{ strcpy(yylval.nd_obj.name,(yytext)); return(LE_OP); }
">="					{ strcpy(yylval.nd_obj.name,(yytext)); return(GE_OP); }
"!="					{ strcpy(yylval.nd_obj.name,(yytext)); return(NE_OP); }
"<"			    		{ strcpy(yylval.nd_obj.name,(yytext)); return('<'); }
">"			    		{ strcpy(yylval.nd_obj.name,(yytext)); return('>'); }
","			    		{ strcpy(yylval.nd_obj.name,(yytext)); return(','); }
":"			    		{ strcpy(yylval.nd_obj.name,(yytext)); return(':'); }
"->"					{ strcpy(yylval.nd_obj.name,(yytext)); return(ARROW); }
"<<"					{ strcpy(yylval.nd_obj.name,(yytext)); return(FUN_ST);}
">>"					{ strcpy(yylval.nd_obj.name,(yytext)); return(FUN_EN);}

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
