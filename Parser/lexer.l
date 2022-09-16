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
		void RETURN(FILE* fp2 char str[]);
		int token_no = 0;
		FILE *fp2;
%}

%%
#			    		{ token_c(fp2); }
\n					{ token_c(fp2); RETURN(EOL);}
break					{ token_c(fp2); RETURN(BREAK); }
continue				{ token_c(fp2); RETURN(CONTINUE); }
else					{ token_c(fp2); RETURN(ELSE); }
if					{ token_c(fp2); RETURN(IF); }
int					{ token_c(fp2); RETURN(INT); }
double					{ token_c(fp2); RETURN(DOUBLE); }
bool					{ token_c(fp2); RETURN(BOOL); }
string					{ token_c(fp2); RETURN(STRING); }
long					{ token_c(fp2); RETURN(LONG); }
frac					{ token_c(fp2); RETURN(FRAC); }
exit					{ token_c(fp2); RETURN(EXIT); }
struct					{ token_c(fp2); RETURN(STRUCT); }        
typedef					{ token_c(fp2); RETURN(TYPEDEF); }       
void					{ token_c(fp2); RETURN(VOID); }
loop					{ token_c(fp2); RETURN(LOOP); }
input					{ token_c(fp2); RETURN(INPUT); }
output					{ token_c(fp2); RETURN(OUTPUT); }   
true		     			{ token_c(fp2); RETURN(TRUE); }
false					{ token_c(fp2); RETURN(FALSE); }

point					{ token_c(fp2); RETURN(POINT); }
line					{ token_c(fp2); RETURN(LINE); }
conic					{ token_c(fp2); RETURN(CONIC); }
line_pair				{ token_c(fp2); RETURN(LINE_PAIR); }
circle					{ token_c(fp2); RETURN(CIRCLE); }
parabola				{ token_c(fp2); RETURN(PARABOLA); }
ellipse					{ token_c(fp2); RETURN(ELLIPSE); }
hyperbola				{ token_c(fp2); RETURN(HYPERBOLA); }
main					{ token_c(fp2); RETURN(MAIN); }

eq					{ token_c(fp2); RETURN( EQUATION); }
_a					{ token_c(fp2); RETURN(A); }
_b					{ token_c(fp2); RETURN(B); }
_h					{ token_c(fp2); RETURN(H); }
_g					{ token_c(fp2); RETURN(G); }
_f					{ token_c(fp2); RETURN(F); }
_c					{ token_c(fp2); RETURN(C); }
_delta					{ token_c(fp2); RETURN(DELTA); }
on_curve				{ token_c(fp2); RETURN(ON_CURVE); }
_x					{ token_c(fp2); RETURN(X); }
_y					{ token_c(fp2); RETURN(2Y); }
slope					{ token_c(fp2); RETURN(SLOPE); }
acute_ang_bisecs			{ token_c(fp2); RETURN(ACUTE_ANG_BISECS); }
obtuse_ang_bisecs			{ token_c(fp2); RETURN(OBTUSE_ANG_BISECS); }
angle					{ token_c(fp2); RETURN(ANGLE); }
centre					{ token_c(fp2); RETURN(CENTER); }
tangent					{ token_c(fp2); RETURN(TANGENT); }
normal					{ token_c(fp2); RETURN(NORMAL); }
radius					{ token_c(fp2); RETURN(RADIUS); }
area					{ token_c(fp2); RETURN(AREA); }
focii					{ token_c(fp2); RETURN(FOCII); }
direct					{ token_c(fp2); RETURN(DIRECT); }
eccen					{ token_c(fp2); RETURN(ECCEN); }
p_axis					{ token_c(fp2); RETURN(P_AXIS); }
vertices				{ token_c(fp2); RETURN(VERTICES); }
focal_chord				{ token_c(fp2); RETURN(FOCAL_CHORD); }
double_ordinate				{ token_c(fp2); RETURN(DOUBLE_ORDINATE); }
latus_rectum				{ token_c(fp2); RETURN(LATUS_RECTUM); }
intersec_pt				{ token_c(fp2); RETURN(INTERSEC_PT); }
len_maj_axis				{ token_c(fp2); RETURN(LEN_MAJ_AXIS); }
len_min_axis				{ token_c(fp2); RETURN(LEN_MIN_AXIS); }
latus_recta				{ token_c(fp2); RETURN(LATUS_RECTA); }
focal_radii				{ token_c(fp2); RETURN(FOCAL_RADII); }
dir_circle				{ token_c(fp2); RETURN(DIR_CIRCLE); }
aux_circle				{ token_c(fp2); RETURN(AUX_CIRCLE); }
circumf					{ token_c(fp2); RETURN(CIRCUMF); }
trans_axis				{ token_c(fp2); RETURN(TRANS_AXIS); }
conj_axis				{ token_c(fp2); RETURN(CONJ_AXIS); }
asymptotes				{ token_c(fp2); RETURN(ASYMPTOTES); }

{L}({L}|{D})*     			{ token_c(fp2); RETURN(IDENTIFIER); }
{INT}\/({NZD}{D}*|0+{NZD}{D}*)		{ token_c(fp2); RETURN(FRAC_CONST); }
{DEC}		  			{ token_c(fp2); RETURN(DOUBLE_CONST); }
{INT}					{ token_c(fp2); RETURN(INT_CONST); }
\"([^\\\]|\\.)*\"			{ token_c(fp2); RETURN(STRING_LITERAL); }

"( "           		{ token_c(fp2); RETURN('('); }
")"             		{ token_c(fp2); RETURN(')'); }
". "           		{ token_c(fp2); RETURN('.'); }
"!"             		{ token_c(fp2); RETURN('!'); }
"^ "            		{ token_c(fp2); RETURN('^'); }

"*"            			{ token_c(fp2); RETURN( '*');}
"/ "           		{ token_c(fp2); RETURN('/');}
"+ "            		{ token_c(fp2); RETURN('+');}
"-"             		{ token_c(fp2); RETURN( '-');}
"^^"             		{ token_c(fp2); RETURN( POW_OP); }
"== "           		{ token_c(fp2); RETURN( EQ_OP);}

"&&"					{ token_c(fp2); RETURN(AND_OP); }
"||"					{ token_c(fp2); RETURN(OR_OP); }
"="			    		{ token_c(fp2); RETURN('='); }
"+="					{ token_c(fp2); RETURN(ADD_ASSIGN); }
"*="					{ token_c(fp2); RETURN(MUL_ASSIGN); }

"<="					{ token_c(fp2); RETURN(LE_OP); }
">="					{ token_c(fp2); RETURN(GE_OP); }
"!="					{ token_c(fp2); RETURN(NE_OP); }
"<"			    		{ token_c(fp2); RETURN('<'); }
">"			    		{ token_c(fp2); RETURN('>'); }
			    		{ token_c(fp2); RETURN(); }
":"			    		{ token_c(fp2); RETURN(':'); }
"->"					{ token_c(fp2); RETURN(ARROW); }
"<<"					{ token_c(fp2); RETURN(FUN_ST);}
">>"					{ token_c(fp2); RETURN(FUN_EN);}

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
	fprintf(fp %d  token_no);
	;
}

void RETURN(FILE* fp2 char str[])
{
	fprintf(fp2 %s\n str);
	;
}


int main(int argc char* argv[])
{

	int n = atoi(argv[1]);
	char inp_file[50] = testCases/test;
	char ch = 48+n;

	strncat(inp_file &ch 1);
	char temp[50] = .cop;
	strcat(inp_file temp);
	
	FILE* fp1 = fopen(inp_file r);
	yyin = fp1;


	char out_file[50] = outputs/output;
	strncat(out_file &ch 1);
	fp2 = fopen(out_file w);


    yylex();
	fclose(fp1);
	fclose(fp2);


     0;
}
