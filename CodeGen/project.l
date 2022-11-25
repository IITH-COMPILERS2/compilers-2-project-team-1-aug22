D			[0-9]
NZD         [1-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]                             
E			[Ee][+-]?{D}+
DEC 		{D}+[.]{D}+
INT			{D}+	

%{
		#include <bits/stdc++.h>
		#include <stdio.h>
		#include <stdlib.h>
		#include <string.h>
		#include "project.tab.hpp"
		using namespace std;
		void comment();
		void token_c(FILE* fp);
		int line_no = 1;
		FILE *fp2;
%}

%%
" "						{ }
#			    		{ comment(); line_no++; return(EOL); }
\n						{ line_no++; return(EOL); }
break					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(BREAK); }
continue				{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(CONTINUE); }
else					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(ELSE); }
if						{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(IF); }
int						{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(INT); }
double					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(DOUBLE); }
bool					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(BOOL); }
string					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(STRING); }
long					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(LONG); }
frac					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(FRAC); }
exit					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(EXIT); }      
void					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(VOID); }
loop					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(LOOP); }
input					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(INPUT); }
output					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(OUTPUT); }   
true		     		{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(TRUE); }
false					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(FALSE); }

point					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(POINT); }
line					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(LINE); }
conic					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(CONIC); }
line_pair				{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(LINE_PAIR); }
circle					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(CIRCLE); }
parabola				{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(PARABOLA); }
ellipse					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(ELLIPSE); }
hyperbola				{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(HYPERBOLA); }
eq_						{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(EQ_); }
conic_name				{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(CONIC_NAME); }


{L}({L}|{D})*     		{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(IDENTIFIER); }
{INT}\/({NZD}{D}*|0+{NZD}{D}*)		{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(FRAC_CONST); }
{DEC}		  			{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.dob_num = atof(yytext);*/ return(DOUBLE_CONST); }
{INT}					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.num = atoi(yytext);*/ return(INT_CONST); }
\"([^\\\"]|\\.)*\"		{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(STRING_LITERAL); }

"("           			{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return('('); }
")"             		{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(')'); }
"."           			{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return('.'); }
"!"             		{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return('!'); }
"^"            			{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return('^'); }

"*"            			{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return('*');}
"/"           			{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return('/');}
"+"            			{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return('+');}
"-"             		{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return('-');}
"^^"             		{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(POW_OP); }
"=="           			{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(EQ_OP);}

"&&"					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(AND_OP); }
"||"					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(OR_OP); }
"="			    		{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return('='); }
"+="					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(ADD_ASSIGN); }
"*="					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(MUL_ASSIGN); }
"%"					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return('%'); }

"<="					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(LE_OP); }
">="					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(GE_OP); }
"!="					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(NE_OP); }
"<"			    		{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return('<'); }
">"			    		{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return('>'); }
","			    		{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(','); }
":"			    		{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(':'); }
"->"					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(ARROW); }
"<<"					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(FUN_ST);}
">>"					{ strcpy(yylval.obj.sem_nd.name,(yytext)); /*yylval.val = strdup(yytext);*/ return(FUN_EN);}

.			    		{ /* ignore bad characters */ }

<<EOF>>         		{ return 0;}
%%

int column = 0;

void comment()
{
	int c;

	/* Read until we find \n or EOF */
	while((c = yyinput()) != '\n' && c != EOF)
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

void yyerror(string msg) {
    //fprintf(stderr, "%s\n", msg);
	cout << msg << " at line " << yylineno << " and at statement \"" << yytext << "\"\n";
}
