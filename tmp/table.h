#ifndef __TABLE_H
#define __TABLE_H

#include "linkedList.h"

typedef struct _table
{
	List* rows;
}Table;

typedef struct _element
{
	int value;
	char* name;
}single_table_element;

void* insert_single_table(single_table_element* element);
int find_single_table(char* name);
void* declare_single_table(char* name, int value);

static Table single_table;

#endif
