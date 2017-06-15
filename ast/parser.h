#ifndef __PARSER_H
#define __PARSER_H

struct Table
{
	char name[20];
	int value;
}single_table[100];


static int tableCount=0;
static int tempvalue=0;


void declare(char*name,int value);
void input();
void declare2(char*name);
int find(char*name);

#endif
