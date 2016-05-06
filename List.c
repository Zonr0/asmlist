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
	printf("%d ", pHead->data);
	return 0;
}

int initList(List newList) {
	*newList = NULL;
	return 0;
}
