CC=gcc
CFLAGS=-g -Wall -O0

All: List

List: List.o listdriver.c
	$(CC) $(CFLAGS) $^ -o $@

#List.o: List.c ListASM.s List.h
#	$(CC) $(CFLAGS) List.c ListASM.s -c

List.o: List.s ListASM.s List.h
	$(CC) $(CFLAGS) List.s ListASM.s -c

List.s: List.c List.h
	$(CC) $(CFLAGS) $< -S 

dump: dumpmain dumplist

dumpmain: listdriver.c List.h
	$(CC) $(CFLAGS) -S $<

dumplist: List.c List.h
	$(CC) $(CFLAGS) -S $<

clean:
	rm *.o
