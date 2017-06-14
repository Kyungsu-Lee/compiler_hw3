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
 
line    : expr '\n'		 {printf("%d\n", $1);} 
	| expr			 {printf("to%d\n", $$);}
	;
expr    : expr '+' term 	 {$$ = $1 + $3;} 
	| term			 {printf("to\n");}	 
	;
term    : term '*' factor      	 {$$ = $1 * $3;} 
	| factor		 {printf("to\n");}
	; 
factor  : '(' expr ')' 		 {$$ = $2 ;} 
	| DIGIT			 {$$ = $1 ; printf("to\n");} 
	; 

 
%%
