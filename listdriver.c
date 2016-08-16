#include <stdlib.h>
#include <stddef.h>
#include "List.h"
int main() {
	List test = NULL;
	initList(&test);
	addBeginning(test, 10);
	addBeginning(test, 20);
	addBeginning(test, 30);
	addBeginning(test, 40);
	addBeginning(test, 50);
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
