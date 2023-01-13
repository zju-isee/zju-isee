#ifndef __SOCKCHAT_H
#define __SOCKCHAT_H

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<unistd.h>
#include<arpa/inet.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<time.h>
#include<pthread.h>
#include<signal.h>

#define MAXDATASIZE 512
#define MAXLISTENSIZE 10

//pType
#define REQUEST 1
#define RESPONSE 2
#define INSTRUCT 3

//dType
#define TIME 1
#define NAME 2
#define LIST 3
#define MESSAGE 4
#define DISCONNECT 5
#define HELLO 6
#define FORWARD 7
#define QUIT 0

#define SERVPORT 3468

typedef struct dataPacket {
    char pType;
    char dType;
    int dst;
    char data[MAXDATASIZE];
} Packet;

typedef struct clientNode {
    int fd;
    unsigned short port;
    struct in_addr addr;
    struct clientNode *next;
} Client;

typedef struct clientList {
    Client *head;
    Client *tail;
    int size;
} CLList;

void addClient(CLList *CLL, Client *clnt);
void deleteCilent(CLList *CLL, int sockfd);
#endif