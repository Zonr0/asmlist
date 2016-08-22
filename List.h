#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>

typedef struct Node
{
	struct Node * pNext;
	void * pData;
} Node;

typedef Node ** List;

extern int displayList(List toDisplay);

extern int initList(List * newList); 

extern int cleanupList(List * newList);

//*********************Insertion**********************************************

extern int addToList(List addTo, void * pData);

extern int addToListSorted(List addTo, void * pData);

//*************************Retrieval*******************************************

extern void * findInList(List searchedList,
	      	void * pSearchedForData,
		int (*comparator)(void *, void *));

//*************************Removal & Deletion***********************************

extern int deleteList(List targetList);

extern int removeFirst(List remove);

//Internally used

extern int r_display(Node * head);

//extern int addItem(Node * pHead, int newData);
