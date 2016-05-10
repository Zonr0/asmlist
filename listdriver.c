#include <stdlib.h>
#include <stddef.h>
#include "List.h"
int main() {
	List test = NULL;
	initList(&test);
	addToList(test, 5);
	addToList(test, 10);
	displayList(test);
	return 0;
}
