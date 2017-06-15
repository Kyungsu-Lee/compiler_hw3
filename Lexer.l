%{
 
/*
 * Lexer.l file
 * To generate the lexical analyzer run: "flex Lexer.l"
 */
 
#include "Parser.h"
#include <stdio.h>
#include <stdlib.h>

%}

%option outfile="Lexer.c" header-file="Lexer.h"
%option yylineno
alpha [a-zA-Z]
digit [0-9]

%x line rem print print1



%%
 
{digit}+	{
//	printf("number!\n");
	yylval.intval=atoi(yytext);
	return DIGIT;
			}
"REM"						{//printf("REM\n"); 
							BEGIN(rem);return REM;}

<rem>[^\\\n]+				{//printf("string!\n"); 
							return STRING;}
<rem>[\n]					{yylineno=+yylineno;BEGIN(INITIAL);}

"PRINT" 					{//printf("PRINT\n"); 
							 BEGIN(print);return PRINT;}
<print>[ ]					{}
<print>[^"\\\n ]+			{//printf("string!\n"); 
							 memset(yylval.strval,0,20);
							 strcpy(yylval.strval,yytext);
							 return STRING;}
<print>"\\n"				{yylineno=+yylineno;BEGIN(INITIAL);}

<print>"\""					{//printf("qoute\n"); 
							 BEGIN(print1);return yytext[0];}
<print1>[^"\\\n]*			{//printf("string!\n");
							 memset(yylval.strval,0,20);
					 		 strcpy(yylval.strval,yytext);
							 return STRING;}
<print1>"\""				{printf("qoute\n");
							BEGIN(INITIAL);return yytext[0];}

"="     return EQUAL;
"<="    return LE;
">="    return GE;
"!"    	return NOT;
">"		return GT;
"<"		return LT;
"-"		return MINUS;
"+"		return PLUS;
"*"		return MULTI;
"/"		return DIVIDE;
"%"		return REMAIN;
"<>"	return INEQUAL;
"&"		return LAND;
"|"		return LOR;

"AS"	return AS;
"DIM"	return DIM;
"GOTO"	return GOTO;
"IF"	return IF;
"THEN"	return THEN;
"INPUT"	return INPUT;
"LET"	return LET;

[A-Za-z][A-Za-z_0-9]*			{//	printf("variable!\n");
					memset(yylval.strval,0,20);
					strcpy(yylval.strval,yytext);
					return VARIABLE;
				}
[ ] 	{}
[\t]	{}
[\n]	{yylineno = yylineno +1;}


.	return yytext[0];

%%
