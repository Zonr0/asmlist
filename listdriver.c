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
	return 0;
}
