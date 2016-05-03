#include <stddef.h>
#include <stdio.h>

typedef struct Node
{
	struct Node * pNext;
	int data;
} Node;

typedef Node ** List;

extern int displayList(List toDisplay);

extern int r_display(Node * head);

extern int initList(List newList); 

extern int addItem(List addTo, int newData);

