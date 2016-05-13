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
	return 0;
}
