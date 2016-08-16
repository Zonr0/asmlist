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

//*********************Insertion**********************************************

extern int addBeginning(List addTo, int newData);

extern int addToListSorted(List addTo, int newData);

//*************************Removal & Deletion***********************************

extern int deleteList(List targetList);

extern int removeFirst(List remove);

//Internally used

extern int r_display(Node * head);

//extern int addItem(Node * pHead, int newData);
