#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>

typedef struct Node
{
	struct Node * pNext;
	int data;
} Node;

typedef Node ** List;

extern int displayList(List toDisplay);

extern int initList(List * newList); 

extern int addToList(List addTo, int newData);

//Internally used

extern int r_display(Node * head);

//extern int addItem(Node * pHead, int newData);
