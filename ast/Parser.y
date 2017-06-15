%{

#include "read_file.h"
#include "parser.h"
#include "Lexer.h"
#include <string.h>

extern FILE * yyin;
%}


%output  "Parser.c"
%defines "Parser.h"
 
%union {
	char strval[40];
	int intval;
}

%type <strval> STRING
%type <intval> DIGIT
%type <intval> expr
%type <strval> VARIABLE

%token DIGIT
%token EQUAL INEQUAL LE GE
%token NOT 
%token GT LT
%token MINUS PLUS MULTI DIVIDE REMAIN
%token LAND LOR
%token STRING VARIABLE
%token AS DIM GOTO IF THEN INPUT LET PRINT REM

%left '+' '-'
%left '*' '/'


%%

program		: line
			| line program 
			;

line		: DIGIT command
			| DIGIT
			;

command		: REM STRING							{}
			| GOTO DIGIT					
			| LET VARIABLE EQUAL expr				{declare($2,$4);}
			| LET VARIABLE '['expr']' '=' expr	{}
			| DIM VARIABLE AS '['expr']'
			| PRINT '"'STRING'"'				{printf("%s\n", $3);}
			| PRINT STRING						{printf("%d\n",find($2));}
			| INPUT VARIABLE						{
												 input(); declare2($2);
												}
			| IF expr THEN DIGIT				{
												if($2==1) printf("TRUE CONDITION\n");
												else printf("FALSE CONDITION\n");
												}
			
			;

expr		: DIGIT							{$$ = $1;}
			| VARIABLE						{$$ = find($1);} 
			| expr MINUS expr				{$$ = $1 - $3;}
			| expr PLUS expr				{$$ = $1 + $3;}
			| expr MULTI expr				{$$ = $1 * $3;}
			| expr DIVIDE expr				{$$ = $1 / $3;}
			| expr REMAIN expr				{$$ = $1 % $3;}
			
			| expr EQUAL expr				{if($1==$3)	$$ = 1; 
											else $$= 0;}
			| expr INEQUAL expr				{if($1!=$3) $$ = 1;
											else $$ = 0;}
			| expr LE expr					{if($1<=$3) $$ = 1;
											else $$ = 0; }
			| expr GE expr					{if($1>=$3) $$ = 1;
											else $$ = 0; }
			| expr GT expr					{if($1>$3) $$ = 1;
											else $$ = 0; }
			| expr LT expr					{if($1<$3) $$ = 1;
											else $$ = 0; }
			| expr LAND expr				{if($1==1&&$3==1) $$ = 1;
											else $$ = 0; }
			| expr LOR expr					{if($1==1||$3==1) $$ = 1;
											else $$ = 0; }
			| MINUS expr					{$$ = -$2;}
			
			| NOT expr						{$$ = !$2;}

			| '('expr')'					{$$=$2;}
			;

 
%%
yyerror(char const*s)
{
	printf("Syntax Error in line number : %d : %s %s \n",yylineno,s,yytext);
}

yylex()
{
	return "a";
}



