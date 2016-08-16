#include "List.h"

int displayList(List toDisplay) {
	int returnVal = r_display(*toDisplay);
	printf("\n");
	return returnVal;
}

int r_display(Node * pHead) {
	if (!pHead) {
		return 1;
	}
	//*******WARNING: TEMPORARY***********
	printf("%d ", *(int *)pHead->pData);
	//************************************
	return r_display(pHead->pNext) * 0;
}

int initList(List * newList) {

	//We do this so that the user can deal with a List without having to
	//pass it's address every time.	
	*newList = malloc(sizeof(Node *));
	**newList = NULL;
	return 0;
}
