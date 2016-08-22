#include <stdlib.h>
#include <stddef.h>
#include "List.h"

int intGreater(void * pLeft, void * pRight) {
	int * pLeftInt = (int *) pLeft;
	int * pRightInt = (int *) pRight;

	if (!pLeftInt || !pRightInt) return -2; //Invalid
	else if (*pLeftInt > *pRightInt) return 1; //Greater
	else if (*pLeftInt == *pRightInt) return 0; //Equal
	else return -1; //Less
}

int main() {
	int data1,data2,data3,data4,data5;
	int nonData = 6;
	int * pFind = NULL;
	List test = NULL;
	initList(&test);

	data1 = 10;data2 = 20;data3 = 30;data4 = 40;data5 = 50;
	addToList(test, (void*)&data1);
	addToList(test, (void*)&data2);
	addToList(test, (void*)&data3);
	addToList(test, (void*)&data4);
	addToList(test, (void*)&data5);
	displayList(test);

	printf("%s","Searching for 30");
	pFind = (int*)findInList(test, (void*)&data3, intGreater);

	if (pFind)
	{
		printf("%s%d","\nFound data value: ", *pFind);
	}
	else {
		printf("%s","\nData not found");
	}

	printf("%s","\nSearching for 99 (shouldn't be in list)");
	pFind = (int*)findInList(test, (void*)&nonData, intGreater);

	if (pFind)
	{
		printf("%s%d","\nFound data value: ", *pFind);
	}
	else {
		printf("%s","\nData not found");
	}

	printf("%s","\nremoving one item then displaying\n");
	removeFirst(test);
	displayList(test);

	printf("%s","removing all items then displaying\n");
	deleteList(test);
	displayList(test);

	printf("%s","Attempting to remove from an empty list\n");
	removeFirst(test);
	displayList(test);

	cleanupList(&test);

	printf("%s","All tests complete\n");

	return 0;
}
