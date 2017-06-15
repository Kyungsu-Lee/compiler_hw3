#include "parser.h"
#include "Parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void declare(char*name,int value)
{	char temp[31];
	int i, flag;

	flag=0;
	strcpy(temp,name);
	for(i=0;i<tableCount;i++){
		if(!strcmp(single_table[i].name,temp))
		{
			flag=1;
			break;
		}
	}
	if(flag)
	{
		single_table[i].value=value;
	}
	else
	{
		strcpy(single_table[tableCount].name,temp);
		single_table[tableCount].value=value;
		printf("%s : %d\n",single_table[tableCount].name,single_table[tableCount].value);
		tableCount++;
	}
}

void input()
{
//	printf("Enter your value: ");
	scanf("%d",&tempvalue);
}

void declare2(char*name)
{
	int i, flag;
	flag=0;
	char temp[31];
	strcpy(temp,name);
	for(i=0;i<tableCount;i++)
	{
		if(!strcmp(single_table[i].name,temp))
		{
			flag=1;
			break;
		}
	}
	if(flag)
	{
//		printf("exsiting var, reassign\n");
		single_table[i].value=tempvalue;
	}
	else
	{
//		printf("new var assign\n");
		strcpy(single_table[tableCount].name,temp);
		single_table[tableCount].value=tempvalue;
		printf("%s: %d\n",single_table[tableCount].name,single_table[tableCount].value);
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
		if(!strcmp(single_table[i].name,temp))
		{
			flag=1;
			return single_table[i].value;
		}
	}
	if(!flag)
	{
		yyerror("undefined value");
		exit(0);
	}
}
