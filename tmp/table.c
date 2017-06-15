#include "linkedList.h"
#include "table.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>

void* insert_single_table(single_table_element* element)
{
	if(single_table.rows == NULL)
	{
		single_table.rows = (List*)malloc(sizeof(List*));
		list_init(single_table.rows);
	}

	Node* tmp = (Node*)malloc(sizeof(Node*));
	init_node(tmp);
	
	tmp->value = element;

	list_insert_node(single_table.rows, tmp);

	return tmp;
}

int find_single_table(char* name)
{
	Node* tmp;

	for(tmp = single_table.rows->head; tmp != NULL; tmp = tmp->next)
	{
		single_table_element* element = (single_table_element*)tmp->value;
		if(!strcmp(element->name, name))
			return element->value;
	}

	return INT_MAX;
}

void* declare_single_table(char* name, int value)
{
	single_table_element* element = (single_table_element*)malloc(sizeof(single_table_element));

	element->name = name;
	element->value = value;
	
	void* b = insert_single_table(element);
	printf("%d\n", ((single_table_element*)((Node*)b)->value)->value);	
	return element;
}


