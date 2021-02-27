CC = gcc
# CFLAGS = -O2 -Wall -I .
CFLAGS = -g -D_REENTRANT 

LIB = -lpthread
 

clnt: client.c sockchat.h
	gcc $(CFLAGS) -o clnt $^ $(LIB)

serv: server.c sockchat.c sockchat.h
	gcc $(CFLAGS) -o serv $^ $(LIB)

clean:
	rm -f clnt serv