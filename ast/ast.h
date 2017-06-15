#ifndef __AST_H
#define __AST_H

typedef struct _ast_node
{
	char command[30];
	char name[100];
	int value;
	int line_number;
	
	int num_child;

	struct _ast_node* parent;
	struct _ast_node **child;

	
}AST_NODE;

typedef struct _ast
{
	AST_NODE* root;
}AST;

void make_ast_print(AST_NODE* cur, char* command);
void make_ast_rem(AST_NODE* cur, char* command);
void make_ast_input(AST_NODE* cur, char* command);

AST_NODE* newNode();
#endif
