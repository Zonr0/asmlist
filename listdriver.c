#include <stdlib.h>
int main() {
	int * pInt;
	pInt = malloc(sizeof(int));
	free(pInt);
	return 0;
}
