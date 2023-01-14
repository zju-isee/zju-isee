#include "sockchat.h"

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
CLList *CLL;
int acceptNum = 0;

void sendHello(int sockfd)
{
    Packet pkt;
    pkt.pType = RESPONSE;
    pkt.dType = HELLO;
    pkt.dst = 0;
    memset(pkt.data, 0, sizeof(pkt.data));
    sprintf(pkt.data, "Hello, sockfd %d\n", sockfd);
    printf("\tData prepare to send to client %d: %s",sockfd, pkt.data);
    send(sockfd, (char *)&pkt, 6+strlen(pkt.data)+1, 0);
}

void sendTime(int sockfd)
{
    Packet pkt;
    pkt.pType = RESPONSE;
    pkt.dType = TIME;
    pkt.dst = 0;
    memset(pkt.data, 0, sizeof(pkt.data));

    time_t rawtime;
    struct tm *lt;
    time(&rawtime);
    lt = localtime(&rawtime);
    sprintf(pkt.data, "Date:%d/%d/%d Time:%d:%d:%d\n", lt->tm_year + 1900, lt->tm_mon + 1, lt->tm_mday, lt->tm_hour, lt->tm_min, lt->tm_sec);
    printf("\tData prepare to send to client %d: %s",sockfd, pkt.data);
    send(sockfd, (char *)&pkt, 6+strlen(pkt.data)+1, 0);    
}

void sendName(int sockfd) {
    Packet pkt;
    pkt.pType = RESPONSE;
    pkt.dType = NAME;
    pkt.dst = 0;
    memset(pkt.data, 0, sizeof(pkt.data));

    char hostName[64];
    gethostname(hostName, sizeof(hostName));
    sprintf(pkt.data, "Host name: %s\n", hostName);
    printf("\tData prepare to send to client %d: %s",sockfd, pkt.data);
    send(sockfd, (char *)&pkt, 6+strlen(pkt.data)+1, 0);
}

void sendList(int sockfd) {
    Packet pkt;
    pkt.pType = RESPONSE;
    pkt.dType = LIST;
    pkt.dst = 0;
    memset(pkt.data, 0, sizeof(pkt.data));

    pthread_mutex_lock(&mutex);
    int offset = 0;
    Client *p = CLL->head;
    while (p != NULL) {
        offset += sprintf(pkt.data+offset, "sockfd: %d ", p->fd);
        offset += sprintf(pkt.data+offset, "port: %hu ", p->port);
        offset += sprintf(pkt.data+offset, "ip address: %s\n", inet_ntoa(p->addr));
        p = p->next;         
    }
    pthread_mutex_unlock(&mutex);
    printf("\tData prepare to send to client %d: %s",sockfd, pkt.data);
    send(sockfd, (char *)&pkt, 6+strlen(pkt.data)+1, 0);
}


void sendExit(int sockfd)
{
    Packet pkt;
    pkt.pType = INSTRUCT;
    pkt.dType = QUIT;
    pkt.dst = 0;
    memset(pkt.data, 0, sizeof(pkt.data));
    sprintf(pkt.data, "Server down\n");
    printf("\tData prepare to send to client %d: %s",sockfd, pkt.data);
    send(sockfd, (char *)&pkt, 6+strlen(pkt.data)+1, 0);
}


void forwardMessage(int sockfd, Packet *pkt) {
    Packet msgPkt;
    Packet rPkt;
    memset(msgPkt.data, 0, sizeof(msgPkt.data));
    memset(rPkt.data, 0, sizeof(rPkt.data));

    pthread_mutex_lock(&mutex);
    Client *p = CLL->head;
    while (p) {
        if (p->fd == sockfd) {
            break;
        }
        p = p->next;
    }
    pthread_mutex_unlock(&mutex);

    if (p == NULL) {
        rPkt.pType = RESPONSE;
        rPkt.dType = MESSAGE;
        rPkt.dst = 0;
        sprintf(rPkt.data, "No client %d\n", pkt->dst);
        printf("\tData prepare to send to client %d: %s",sockfd, rPkt.data);
        send(sockfd, (char *)&rPkt, 6+strlen(rPkt.data)+1, 0);
    } else {
        msgPkt.pType = INSTRUCT;
        msgPkt.dType = FORWARD;
        msgPkt.dst = 0;
        sprintf(msgPkt.data, "From client %d: %s", sockfd, pkt->data);
        printf("\tData prepare to send to client %d: %s",pkt->dst, msgPkt.data);
        send(pkt->dst, (char *)&msgPkt, 6+strlen(msgPkt.data)+2, 0);

        rPkt.pType = RESPONSE;
        rPkt.dType = MESSAGE;
        rPkt.dst = 0;
        sprintf(rPkt.data, "Send message to client %d successfully\n", pkt->dst);
        printf("\n\tData prepare to send to client %d: %s",sockfd, rPkt.data);
        send(sockfd, (char *)&rPkt, 6+strlen(rPkt.data)+1, 0);
    }   
}

void handleDisconnect(int sockfd) {
    pthread_mutex_lock(&mutex);
    deleteCilent(CLL, sockfd);
    acceptNum--;
    pthread_mutex_unlock(&mutex);
    close(sockfd);
    printf("Valid client number: %d\n", acceptNum);
}

static void handleInt(int sig)
{
	pthread_mutex_lock(&mutex);
    Client *p = CLL->head;
    while (p != NULL) {
        int sockfd = p->fd;
        deleteCilent(CLL, sockfd);
        sendExit(sockfd);
        printf("CLient %d exit successfully\n", sockfd);
        close(sockfd);
        p = p->next;
    }
	pthread_mutex_unlock(&mutex);

    acceptNum = 0;
	printf("Server exit successfully\n");
	exit(0);
}


void *acceptSocket(void *clnt)
{
    int sockfd = ((Client *)clnt)->fd;
    struct in_addr addr = ((Client *)clnt)->addr;
    unsigned short port = ((Client *)clnt)->port;

    printf("Say hello to client %d\n", sockfd);
    sendHello(sockfd);

    Packet pkt;
    while (1) {
        int count = recv(sockfd, (char *)&pkt, sizeof(pkt), 0);
        if (count < 0) {
            printf("Sockfd: %d receive error\n", sockfd);
            continue;
        }
        switch (pkt.dType) {
            case TIME:
            {
                printf("(Time Request)");
                printf("Sockfd: %d, pType: %d, dType: %d, dst: %d, data: %s\n", sockfd, pkt.pType, pkt.dType, pkt.dst, pkt.data);               
                sendTime(sockfd);
                break;
            }
            case NAME:
            {
                printf("(Name Request)");
                printf("Sockfd: %d, pType: %d, dType: %d, dst: %d, data: %s\n", sockfd, pkt.pType, pkt.dType, pkt.dst, pkt.data);
                sendName(sockfd);
                break;
            }
            case LIST:
            {
                printf("(List Request)");
                printf("Sockfd: %d, pType: %d, dType: %d, dst: %d, data: %s\n", sockfd, pkt.pType, pkt.dType, pkt.dst, pkt.data);
                sendList(sockfd);
                break;
            }
            case MESSAGE:
            {
                printf("(Message Request)");
                printf("Sockfd: %d, pType: %d, dType: %d, dst: %d, data: %s\n", sockfd, pkt.pType, pkt.dType, pkt.dst, pkt.data);
                forwardMessage(sockfd, &pkt);
                break;
            }
            case DISCONNECT:
            {
                printf("(Disconnect Request)");
                printf("Sockfd: %d, pType: %d, dType: %d, dst: %d, data: %s\n", sockfd, pkt.pType, pkt.dType, pkt.dst, pkt.data);
                handleDisconnect(sockfd);
                pthread_exit(0);
                printf("Client %d disconnect successfully\n", sockfd);
                break;
            }
            default:
                continue;
                break;
        }
    }
}


int main()
{
    int serv_sockfd;
    struct sockaddr_in serv_addr;

    signal(SIGINT, handleInt);

    CLL = (CLList *)malloc(sizeof(CLL));
    CLL->head = NULL;
    CLL->tail = NULL;
    CLL->size = 0;

    serv_sockfd = socket(AF_INET, SOCK_STREAM, 0);
    memset(&serv_addr, 0, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    serv_addr.sin_port = htons(SERVPORT);
    int bStat = bind(serv_sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr));
    if (bStat < 0) {
        perror("Bind error");
        exit(0);
    }
    int lStat = listen(serv_sockfd, MAXLISTENSIZE);
    if (lStat < 0) {
        perror("Listen error");
        exit(0);
    }
    printf("Listen starts\n");

    
    while (1) {
        if (CLL->size < MAXLISTENSIZE) {
            int length = sizeof(struct sockaddr_in);
            struct sockaddr_in clnt_addr;
            memset(&clnt_addr, 0, sizeof(clnt_addr));
            int clnt_sockfd = accept(serv_sockfd, (struct sockaddr*)&clnt_addr, &length);
            if (clnt_sockfd < 0) {
                printf("Invalid sockfd\n");
                continue;
            }
            pthread_mutex_lock(&mutex);
            acceptNum++;
            Client *clnt = (Client *)malloc(sizeof(Client));
            clnt->fd = clnt_sockfd;
            clnt->port = clnt_addr.sin_port;
            clnt->addr = clnt_addr.sin_addr;
            clnt->next = NULL;
            addClient(CLL, clnt);
            pthread_mutex_unlock(&mutex); 
            printf("Received a new connection, client: %d, addr: %s, port: %d\n", clnt->fd, inet_ntoa(clnt->addr), clnt->port); 
            printf("Valid client number: %d\n", acceptNum);
            pthread_t tid;
            pthread_attr_t attr; 
            pthread_attr_init(&attr); 
            pthread_attr_setdetachstate(&attr, 1); 
            pthread_create(&tid, &attr, acceptSocket, (void *)clnt);   
        } 
    }
    close(serv_sockfd);

    return 0;
}