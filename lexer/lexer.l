%option noyywrap

D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]                             /*doubtful*/
E			[Ee][+-]?{D}+

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
"break"					{ token_c(fp2); token_pr(fp2,"BREAK"); }
"continue"				{ token_c(fp2); token_pr(fp2,"CONTINUE"); }
"else"					{ token_c(fp2); token_pr(fp2,"ELSE"); }
"if"					{ token_c(fp2); token_pr(fp2,"IF"); }
"int"					{ token_c(fp2); token_pr(fp2,"INT"); }
"double"				{ token_c(fp2); token_pr(fp2,"DOUBLE"); }
"bool"		    		{ token_c(fp2); token_pr(fp2,"BOOL"); }
"string"				{ token_c(fp2); token_pr(fp2,"STRING"); }
"long"					{ token_c(fp2); token_pr(fp2,"LONG"); }
"frac"		    		{ token_c(fp2); token_pr(fp2,"FRAC"); }
"exit"		    		{ token_c(fp2); token_pr(fp2,"EXIT"); }
"struct"				{ token_c(fp2); token_pr(fp2,"STRUCT"); }        /*doubtful*/
"typedef"				{ token_c(fp2); token_pr(fp2,"TYPEDEF"); }       /*doubtful*/
"void"					{ token_c(fp2); token_pr(fp2,"VOID"); }
"loop"					{ token_c(fp2); token_pr(fp2,"LOOP"); }

"point"		    		{ token_c(fp2); token_pr(fp2,"POINT"); }
"line"		    		{ token_c(fp2); token_pr(fp2,"LINE"); }
"conic"		    		{ token_c(fp2); token_pr(fp2,"CONIC"); }
"line_pair"				{ token_c(fp2); token_pr(fp2,"LINE_PAIR"); }
"circle"				{ token_c(fp2); token_pr(fp2,"CIRCLE"); }
"parabola"				{ token_c(fp2); token_pr(fp2,"PARABOLA"); }
"ellipse"				{ token_c(fp2); token_pr(fp2,"ELLIPSE"); }
"hyperbola"				{ token_c(fp2); token_pr(fp2,"HYPERBOLA"); }
"input"         		{ token_c(fp2); token_pr(fp2,"INPUT"); }

"("             		{ token_c(fp2); token_pr(fp2,"("); }
")"             		{ token_c(fp2); token_pr(fp2,")"); }
"."             		{ token_c(fp2); token_pr(fp2,"."); }
"!"             		{ token_c(fp2); token_pr(fp2,"!"); }
"^"             		{ token_c(fp2); token_pr(fp2,"^"); }

"* "            		{ token_c(fp2); printf ("MUL_OP");}
"/"             		{ token_c(fp2); printf ("DIV_OP");}
"+"             		{ token_c(fp2); printf ("ADD_OP");}
"-"             		{ token_c(fp2); printf ("SUB_OP");}
"=="            		{ token_c(fp2); printf ("EQ_OP");}

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
"->"					{ token_c(fp2); token_pr(fp2,"PTR_OP"); }
"'"             		{ token_c(fp2); token_pr(fp2,"FUNC_OP");}

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


int main()
{
	int n;
	printf("Enter Test Case (int):");
	scanf("%d",&n);

	char inp_file[12] = "test_case";
	char ch = 48+n;

	strncat(inp_file, &ch, 1);

	FILE* fp1 = fopen(inp_file, "r");
	yyin = fp1;


	char out_file[10] = "output_";
	strncat(out_file, &ch, 1);
	fp2 = fopen(out_file, "w");


    yylex();
	fclose(fp1);
	fclose(fp2);


    return 0;
}
