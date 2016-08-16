#include <stdlib.h>
#include <stddef.h>
#include "List.h"
int main() {
	List test = NULL;
	initList(&test);
	addToList(test, 10);
	addToList(test, 20);
	addToList(test, 30);
	addToList(test, 40);
	addToList(test, 50);
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
