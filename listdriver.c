#include <stdlib.h>
#include <stddef.h>
#include "List.h"
int main() {
	int data1,data2,data3,data4,data5;
	List test = NULL;
	initList(&test);

	data1 = 10;data2 = 20;data3 = 30;data4 = 40;data5 = 50;
	addToList(test, (void*)&data1);
	addToList(test, (void*)&data2);
	addToList(test, (void*)&data3);
	addToList(test, (void*)&data4);
	addToList(test, (void*)&data5);
	displayList(test);

	printf("%s","removing one item then displaying\n");
	removeFirst(test);
	displayList(test);

	printf("%s","removing all items then displaying\n");
	removeFirst(test);
	removeFirst(test);
	removeFirst(test);
	removeFirst(test);
	displayList(test);

	printf("%s","Attempting to remove from an empty list\n");
	removeFirst(test);
	displayList(test);

	printf("%s","All tests complete\n");

	return 0;
}
