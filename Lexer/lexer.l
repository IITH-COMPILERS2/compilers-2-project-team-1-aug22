%option noyywrap

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

		void comment();
		void token_c(FILE* fp);
		void token_pr(FILE* fp2, char str[]);
		int token_no = 0;
		FILE *fp2;
%}

%%
"#"			    		{ token_c(fp2); }
"\n"					{ token_c(fp2); token_pr(fp2,"EOL");}
"break"					{ token_c(fp2); token_pr(fp2,"BREAK"); }
"continue"				{ token_c(fp2); token_pr(fp2,"CONTINUE"); }
"else"					{ token_c(fp2); token_pr(fp2,"ELSE"); }
"if"					{ token_c(fp2); token_pr(fp2,"IF"); }
"int"					{ token_c(fp2); token_pr(fp2,"INT"); }
"double"				{ token_c(fp2); token_pr(fp2,"DOUBLE"); }
"bool"					{ token_c(fp2); token_pr(fp2,"BOOL"); }
"string"				{ token_c(fp2); token_pr(fp2,"STRING"); }
"long"					{ token_c(fp2); token_pr(fp2,"LONG"); }
"frac"					{ token_c(fp2); token_pr(fp2,"FRAC"); }
"exit"					{ token_c(fp2); token_pr(fp2,"EXIT"); }      
"void"					{ token_c(fp2); token_pr(fp2,"VOID"); }
"loop"					{ token_c(fp2); token_pr(fp2,"LOOP"); }
"input"					{ token_c(fp2); token_pr(fp2,"INPUT"); }
"output"				{ token_c(fp2); token_pr(fp2,"OUTPUT"); }   
"true"		     		{ token_c(fp2); token_pr(fp2,"TRUE"); }
"false"					{ token_c(fp2); token_pr(fp2,"FALSE"); }

"point"					{ token_c(fp2); token_pr(fp2,"POINT"); }
"line"					{ token_c(fp2); token_pr(fp2,"LINE"); }
"conic"					{ token_c(fp2); token_pr(fp2,"CONIC"); }
"line_pair"				{ token_c(fp2); token_pr(fp2,"LINE_PAIR"); }
"circle"				{ token_c(fp2); token_pr(fp2,"CIRCLE"); }
"parabola"				{ token_c(fp2); token_pr(fp2,"PARABOLA"); }
"ellipse"				{ token_c(fp2); token_pr(fp2,"ELLIPSE"); }
"hyperbola"				{ token_c(fp2); token_pr(fp2,"HYPERBOLA"); }
"main"					{ token_c(fp2); token_pr(fp2, "MAIN"); }

{L}({L}|{D})*     				{ token_c(fp2); token_pr(fp2,"IDENTIFIER"); }
{INT}\/({NZD}{D}*|0+{NZD}{D}*)	{ token_c(fp2); token_pr(fp2,"FRAC_CONST"); }
{DEC}				  			{ token_c(fp2); token_pr(fp2,"DOUBLE_CONST"); }
{INT}							{ token_c(fp2); token_pr(fp2,"INT_CONST"); }
\"([^\\\"]|\\.)*\"				{ token_c(fp2); token_pr(fp2,"STRING_LITERAL"); }

"("             		{ token_c(fp2); token_pr(fp2,"("); }
")"             		{ token_c(fp2); token_pr(fp2,")"); }
"."             		{ token_c(fp2); token_pr(fp2,"."); }
"!"             		{ token_c(fp2); token_pr(fp2,"!"); }
"^"             		{ token_c(fp2); token_pr(fp2,"^"); }

"*"            			{ token_c(fp2); token_pr(fp2, "*");}
"/"             		{ token_c(fp2); token_pr(fp2, "/");}
"+"             		{ token_c(fp2); token_pr(fp2, "+");}
"-"             		{ token_c(fp2); token_pr(fp2, "-");}
"^^"             		{ token_c(fp2); token_pr(fp2, "POW_OP"); }
"=="            		{ token_c(fp2); token_pr(fp2, "EQ_OP");}

"&&"					{ token_c(fp2); token_pr(fp2,"AND_OP"); }
"||"					{ token_c(fp2); token_pr(fp2,"OR_OP"); }
"="			    		{ token_c(fp2); token_pr(fp2,"="); }
"+="					{ token_c(fp2); token_pr(fp2,"ADD_ASSIGN"); }
"*="					{ token_c(fp2); token_pr(fp2,"MUL_ASSIGN"); }

"<="					{ token_c(fp2); token_pr(fp2,"LE_OP"); }
">="					{ token_c(fp2); token_pr(fp2,"GE_OP"); }
"!="					{ token_c(fp2); token_pr(fp2,"NE_OP"); }
"<"			    		{ token_c(fp2); token_pr(fp2,"<"); }
">"			    		{ token_c(fp2); token_pr(fp2,">"); }
","			    		{ token_c(fp2); token_pr(fp2,","); }
":"			    		{ token_c(fp2); token_pr(fp2,":"); }
"->"					{ token_c(fp2); token_pr(fp2,"ARROW"); }
"<<"					{ token_c(fp2); token_pr(fp2,"FUN_ST");}
">>"					{ token_c(fp2); token_pr(fp2,"FUN_EN");}

.			    		{ /* ignore bad characters */ }

<<EOF>>         		{return 0;}
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
	fprintf(fp, "%d ", token_no);
	return;
}

void token_pr(FILE* fp2, char str[])
{
	fprintf(fp2, "%s\n", str);
	return;
}


int main(int argc, char* argv[])
{

	int n = atoi(argv[1]);
	char inp_file[50] = "testCases/test";
	char ch = 48+n;

	strncat(inp_file, &ch, 1);
	char temp[50] = ".cop";
	strcat(inp_file, temp);
	
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
