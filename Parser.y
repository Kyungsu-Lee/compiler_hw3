%{
#include "read_file.h"
#include "Parser.h"
#include "Lexer.h"
#include <string.h>

extern FILE * yyin;
struct ast_node * new_ast_node(int operator,struct ast_node*left,struct ast_node* right);
struct ast_node * new_ast_reference_node(struct symbol_node *symbol);
struct ast_node * new_ast_number_node(double value);
%}

%output  "Parser.c"
%defines "Parser.h"
 
%union {
	char strval[40];
	double intval;
	struct ast_node * ast;
	struct symbol_node * symbol;
}

%type <strval> STRING
%type <intval> DIGIT
%type <symbol> VARIABLE
%type <ast> expr
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

program		: program line
			| 
			;

line		: DIGIT command
			| DIGIT
			;

command		: REM STRING							{//printf("command level\n");
			  										}

			| GOTO DIGIT							{
													}
	
			| LET VARIABLE EQUAL expr				{
														printf("command level\n");
													//	declare($2,$4);
													}
			| LET VARIABLE '['expr']' '=' expr		{
																										
													}
			| DIM VARIABLE AS '['expr']'			{
														
													}
		
			| PRINT '"'STRING'"'					{
														printf("command	level\n");
														printf("%s\n", $3);
													}
		
			| PRINT STRING							{
														printf("command	level\n");
													//	printf("%d\n",find($2));
													}
			
			| INPUT VARIABLE						{
														printf("command level\n");
													//	input(); declare2($2);
													}
			| IF expr THEN DIGIT					{
														printf("command level\n");
													//	if($2==1) printf("TRUE CONDITION\n");
													//	else printf("FALSE CONDITION\n");
													}
			
			;

expr		: DIGIT							{	
				 								 $$ = new_ast_number_node($1);
			  								}
			| VARIABLE						{
												$$ = new_ast_reference_node($1);
											} 
			| expr MINUS expr				{$$ = new_ast_node(266,$1,$3);}
			| expr PLUS expr				{$$ = new_ast_node(267,$1,$3);}
			| expr MULTI expr				{$$ = new_ast_node(268,$1,$3);}
			| expr DIVIDE expr				{$$ = new_ast_node(269,$1,$3);}
			| expr REMAIN expr				{$$ = new_ast_node(270,$1,$3);}
			
			| expr EQUAL expr				{$$ = new_ast_node(259,$1,$3);}

			| expr INEQUAL expr				{$$ = new_ast_node(260,$1,$3);}
			
			| expr LE expr					{$$ = new_ast_node(261,$1,$3);}
			
			| expr GE expr					{$$ = new_ast_node(262,$1,$3);}
			
			| expr GT expr					{$$ = new_ast_node(264,$1,$3);}
			
			| expr LT expr					{$$ = new_ast_node(265,$1,$3);}
			
			| expr LAND expr				{$$ = new_ast_node(271,$1,$3);}
			
			| expr LOR expr					{$$ = new_ast_node(272,$1,$3);}
			
			| MINUS expr					{$$ = new_ast_node(266,$2,NULL);}
			
			| NOT expr						{$$ = new_ast_node(263,$2,NULL);}

			| '('expr')'					{$$ = $2;}
			
			;

 
%%

yyerror(char const*s)
{
	printf("Syntax Error in line number : %d : %s %s \n",yylineno,s,yytext);
}


struct symbol_node
{
	char name[20];
	double value;
};

struct ast_node
{
	int operator;
	struct ast_node* left;
	struct ast_node* right;
};
struct ast_number_node
{
	double value;
};
struct ast_reference_node
{
	struct symbol_node * symbol;
};


struct ast_node * new_ast_node (int operator,struct ast_node * left,struct ast_node * right)
{
	struct ast_node *ast_node= malloc(sizeof(struct ast_node));
	ast_node->operator=operator;

	ast_node->left=left;
	ast_node->right=right;
	return ast_node;
}

struct ast_node * new_ast_reference_node (struct symbol_node * symbol)
{
	struct ast_reference_node * ast_node=malloc(sizeof(struct ast_reference_node));
	ast_node->symbol=symbol;
	return (struct ast_node *)ast_node;
}

struct ast_node * new_ast_number_node (double value)
{
	struct ast_number_node * ast_node=malloc(sizeof(struct ast_number_node));
	ast_node->value=value;
	return (struct ast_node *)ast_node;
}

/*
int tableCount=0;
int tempvalue=0;


declare(char*name,int value)
{	char temp[31];
	int i, flag;

	flag=0;
	strcpy(temp,name);
	for(i=0;i<tableCount;i++){
		if(!strcmp(table[i].name,temp))
		{
			flag=1;
			break;
		}
	}
	if(flag)
	{
		table[i].value=value;
	}
	else
	{
		strcpy(table[tableCount].name,temp);
		table[tableCount].value=value;
		printf("%s : %d\n",table[tableCount].name,table[tableCount].value);
		tableCount++;
	}
}
input()
{
//	printf("Enter your value: ");
	scanf("%d",&tempvalue);
}
declare2(char*name)
{
	int i, flag;
	flag=0;
	char temp[31];
	strcpy(temp,name);
	for(i=0;i<tableCount;i++)
	{
		if(!strcmp(table[i].name,temp))
		{
			flag=1;
			break;
		}
	}
	if(flag)
	{
//		printf("exsiting var, reassign\n");
		table[i].value=tempvalue;
	}
	else
	{
//		printf("new var assign\n");
		strcpy(table[tableCount].name,temp);
		table[tableCount].value=tempvalue;
		printf("%s: %d\n",table[tableCount].name,table[tableCount].value);
		tableCount++;
	}
}
int find(char*name)
{
	char temp[31];
	int i,flag;
	flag=0;
	strcpy(temp,name);
	for(i=0;i<tableCount;i++)
	{
		if(!strcmp(table[i].name,temp))
		{
			flag=1;
			return table[i].value;
		}
	}
	if(!flag)
	{
		yyerror("undefined value");
		exit(0);
	}
}*/
/*
int gotof(int lineno)
{
	int i,flag;
	flag=0;
	for(i=0;i<num_child;i++){
		if(AST[i]->root.line_number==lineno)
		{
			flag=1;
			return i;
		}
	}
	if(!flag){
		printf("Wrong line number!\n");
		exit(0);
	}
	
}
*/








