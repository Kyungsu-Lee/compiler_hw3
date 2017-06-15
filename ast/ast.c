#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "ast.h"

AST_NODE* newNode()
{
	AST_NODE* node = (AST_NODE*)malloc(sizeof(AST_NODE));
	node->parent = NULL;
	node->child = (AST_NODE**)malloc(100 * sizeof(AST_NODE*));
	node->num_child = 0;	

	return node;
}

void make_ast_print(AST_NODE* cur, char* str)
{
	AST_NODE* node = newNode();
	node->parent = cur;
	strcpy(node->command, "PRINT");
	strcpy(node->name, str);

	cur->child[cur->num_child++] = node;
}

void make_ast_rem(AST_NODE* cur, char* str)
{
	AST_NODE* node = newNode();
	node->parent = cur;
	strcpy(node->command, "REM");
	strcpy(node->name, str);

	cur->child[cur->num_child++] = node;
}
