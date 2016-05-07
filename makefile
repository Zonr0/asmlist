CC=gcc
CFLAGS=-g -Wall -O0
AR=ar
ARFLAGS=-cvq

All: List

List: listdriver.c List.a
	$(CC) $(CFLAGS) $^ -o $@

List.a: ListC.o ListASM.o
	$(AR) $(ARFLAGS) $@ $^

#List.o: List.c ListASM.s List.h
#	$(CC) $(CFLAGS) List.c ListASM.s -c

#List.o: List.s ListASM.s List.h
#	$(CC) $(CFLAGS) List.s ListASM.s -c

#List.o: ListC.o ListASM.o
#	$(CC) $(CFLAGS) $^ -c -o $@

ListC.o: List.c List.h
	$(CC) $(CFLAGS) $< -c -o $@

ListASM.o: ListASM.s
	$(CC) $(CFLAGS) $^ -c

dump: dumpmain dumplist

dumpmain: listdriver.c List.h
	$(CC) $(CFLAGS) -S $<

dumplist: List.c List.h
	$(CC) $(CFLAGS) -S $<

clean:
	rm *.o
	rm List.a
	rm List
