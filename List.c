#include "List.h"

int displayList(List toDisplay) {
	r_display(*toDisplay);
	printf("\n");
}

int r_display(Node * pHead) {
	if (!pHead) {
		return 0;
	}
	printf("%d ", pHead->data);
}

int initList(List newList) {
	*newList = NULL;
}
