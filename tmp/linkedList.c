#include "linkedList.h"
#include <stdio.h>

void init_node(Node* node)
{
	node-> index = 0;
	node->next = node->prev = NULL;
}

void list_init(List* list)
{
	list->count = 0;
	list->head = list->tail = NULL;
}

int list_is_empty(List* list)
{
	return list->count == 0;
}

void list_insert_node(List* list, Node* node)
{
	if(list_is_empty(list))
	{
		list->head = list->tail = node;
	}

	else
	{
		list->tail->next = node;
		node->prev = list->tail;
		node->index = list->tail->index + 1;
		list->tail = node;
	}

	(list->count)++;
}

Node* list_at(List* list, int index)
{
	Node* tmp;
		
	for(tmp = list->head; (tmp != NULL) && (tmp->index != index); tmp = tmp->next);

	if(tmp == NULL || tmp->index != index) return NULL;
	
	return tmp;
}
