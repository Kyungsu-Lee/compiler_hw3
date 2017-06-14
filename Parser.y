%{

#include "read_file.h"
#include "Parser.h"
#include "Lexer.h"
 
%}


%output  "Parser.c"
%defines "Parser.h"
 

%token DIGIT
%left '+''*'
%token EQUAL INEQUAL LE GE
%token NOT 
%token GT LT
%token MINUS PLUS MULTI DIVIDE REMAIN
%token  LAND LOR
 
%%
 
factor  : DIGIT			 {$$ = $1 ; printf("%d\n", $1); }
	; 

 
%%
