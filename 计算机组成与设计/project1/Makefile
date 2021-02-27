

CC = gcc
CFLAGS = -g


all:  asm sim

asm:  asm.c
	$(CC) $(CFLAGS) -c asm.c
	$(CC) $(CFLAGS) -o asm asm.o

sim:  riscv-small.c
	$(CC) $(CFLAGS) -c riscv-small.c
	$(CC) $(CFLAGS) -o sim riscv-small.o