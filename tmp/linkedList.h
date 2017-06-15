#ifndef __LINKED_LIST
#define __LINKED_LIST

typedef struct _node
{
	int index;
	void* value;
	struct _node* next;
	struct _node* prev;
}Node;

typedef struct _list
{
	int count;
	Node* head;
	Node* tail;
}List;


void init_node(Node* node);
void list_init(List* list);
int list_is_empty(List* list);
void list_insert_node(List* list, Node* node);
Node* list_at(List* list, int index);

#endif
