#include "ast.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "read_file.h"
#include "Parser.h"
#include "Lexer.h"

#include <stdio.h>
#include <stdlib.h>
int main()
{
	AST* ast = (AST*)malloc(sizeof(AST));
	AST_NODE* cur = newNode();
	
	ast->root = cur;

	make_ast_print(cur, "hello");
	make_ast_rem(cur, "hello");
//	printf("%s\n", cur->child[0]->command);
	printf("well\n");
	yytext = cur->child[0]->command;
	printf("well\n");
	yyparse();
}
