#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdbool.h>




struct Table
{
	char name[32];
	int value;
}table[20];
int tableCount=0;

void assign(char* a, int b){

	char temp[32];
	int i, flag;
	flag=0;
	
	strcpy(temp,a);
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
		table[i].value=b;
	}
	else
	{
		strcpy(table[tableCount].name,temp);
		table[tableCount].value=b;
		tableCount++;
	}
}

int find(char* a)
{
	char temp[32];
	int i, flag;
	flag=0;

	strcpy(temp,a);
	for(i=0;i<tableCount;i++)
	{
		if(strcmp(table[i].name,temp))
		{
			flag=1;
			break;
		}
	}
	if(flag)
	{
		return table[i].value;
	}
	else
	{
		yyerror("undefined variable\n");
	}
}

		
	
