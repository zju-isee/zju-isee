
CC = gcc
CFLAGS = -g

all:  sim

sim:  main.o cache.o
	$(CC) -o sim main.o cache.o -lm

main.o:  main.c cache.h
	$(CC) $(CFLAGS) -c main.c

cache.o:  cache.c cache.h
	$(CC) $(CFLAGS) -c cache.c
