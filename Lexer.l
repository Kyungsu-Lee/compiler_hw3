%{
 
/*
 * Lexer.l file
 * To generate the lexical analyzer run: "flex Lexer.l"
 */
 
#include "Parser.h"
#include <stdio.h>
 
%}

%option outfile="Lexer.c" header-file="Lexer.h"
 
alpha [a-zA-Z]
digit [0-9]
 
%%
 
{digit}+	{return DIGIT;} 

 
"="     return EQUAL;
"<="    return LE;
">="    return GE;
"!"    	return NOT;
">"	return GT;
"<"	return LT;
"-"	return MINUS;
"+"	return PLUS;
"*"	return MULTI;
"/"	return DIVIDE;
"%"	return REMAIN;
"<>"	return INEQUAL;
"&"	return LAND;
"|"	return LOR;
	
.	{}

