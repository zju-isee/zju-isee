#include "sockchat.h"

int connectStat = 0;

//menu function
int showMenu()
{
    printf("************MENU************\n");
    printf("1: Connect\n");
    printf("2: Disconnect\n");
    printf("3: Get time\n");
    printf("4: Get server name\n");
    printf("5: Get active client list\n");
    printf("6: Send message\n");
    printf("7: Exit\n");
    printf("************MENU************\n");
    printf("Your choice: ");

    int choice;
    scanf("%d", &choice);
    return choice;
}

void *receiveData(void *sockfd)
{
    Packet pkt;

    int isAccepted = 0;

    while (1) {
        memset(pkt.data, 0, sizeof(pkt.data));
        int count = recv(*(int *)sockfd, (char *)&pkt, sizeof(pkt), 0);
        if (pkt.pType == RESPONSE && pkt.dType == HELLO) {
            printf("\nServer accepts\n");
            isAccepted = 1;
        }
        if(isAccepted == 0) {
            printf("\nServer listen list is full\n");
            pthread_exit(0);
        } else {
            if (pkt.pType == INSTRUCT && pkt.dType == QUIT) {
                printf("Server down\n");
                connectStat = 0;        
                pthread_exit(0);
            }
            printf("\nData received: \n%s\n", pkt.data);
        }
    }
}

int connectServer(int sockfd)
{
    printf("Input ip address: ");
    char ip[20];
    scanf("%s", ip);

    struct sockaddr_in serv_addr;
    memset(&serv_addr, 0 , sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = inet_addr(ip);
    serv_addr.sin_port = htons(SERVPORT);

    //connect
    int cStat = connect(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr));
    if (cStat == -1) {
        perror("Failed to connect");
        return -1;
    }   
    printf("Connect %s successfully\n", ip);
    connectStat = 1;

    return 1;
}

void disconnectServer(int sockfd)
{
    Packet pkt;
    pkt.pType = REQUEST;
    pkt.dType = DISCONNECT;
    pkt.dst = 0;
    memset(pkt.data, 0, sizeof(pkt.data));
    send(sockfd, (char *)&pkt, 2, 0);
    close(sockfd);
    connectStat = 0;
    printf("Disconnect successfully\n");
}

void getTime(int sockfd) {
    Packet pkt;
    pkt.pType = REQUEST;
    pkt.dType = TIME;
    pkt.dst = 0;
    memset(pkt.data, 0, sizeof(pkt.data));
    send(sockfd, (char *)&pkt, 2, 0);
}

void getName(int sockfd) {
    Packet pkt;
    pkt.pType = REQUEST;
    pkt.dType = NAME;
    pkt.dst = 0;
    memset(pkt.data, 0, sizeof(pkt.data));
    send(sockfd, (char *)&pkt, 2, 0);    
}

void getList(int sockfd) {
    Packet pkt;
    pkt.pType = REQUEST;
    pkt.dType = LIST;
    pkt.dst = 0;
    memset(pkt.data, 0, sizeof(pkt.data));
    send(sockfd, (char *)&pkt, 2, 0);
}

void sendMessage(int sockfd) {
    Packet pkt;
    pkt.pType = REQUEST;
    pkt.dType = MESSAGE;
    memset(pkt.data, 0, sizeof(pkt.data));
    printf("Input client id: ");
    scanf("%d", &pkt.dst);
    printf("Input message you want to send: ");
    getchar();
    fgets(pkt.data, MAXDATASIZE, stdin);
    send(sockfd, (char *)&pkt, strlen(pkt.data)+2+sizeof(int)+1, 0);
}

int main()
{
    //Create a socket
    int sockfd = socket(AF_INET, SOCK_STREAM, 0);

    if (sockfd == -1) {
        perror("Failed to create a socket");
        exit(0);
    }
    int i;

    pthread_t tid;
    int ret, pStat;
    while (1) {
        int choice = showMenu();        
        switch (choice)
        {
        case 1:
            if (connectStat) {
                printf("Have connected!\n");
                continue;
            }
            ret = connectServer(sockfd);
            if (ret < 0) {
                continue;
            }
            pStat = pthread_create(&tid, NULL, &receiveData, (void *)&sockfd);
            if (pStat != 0) {
                perror("Failed to create a pthread");
                return -1;
            }
            printf("Create a pthread successfully\n");            
            break;
        case 2:
            if (!connectStat) {
                printf("No valid connection\n");
                continue;
            }
            pthread_cancel(tid);
            disconnectServer(sockfd);
            break;
        case 3:
            if (!connectStat) {
                printf("No valid connection\n");
                continue;
            }
            getTime(sockfd);
            break;
        case 4:
            if (!connectStat) {
                printf("No valid connection\n");
                continue;
            }
            getName(sockfd);
            break;
        case 5:
            if (!connectStat) {
                printf("No valid connection\n");
                continue;
            }
            getList(sockfd);
            break;
        case 6:
            if (!connectStat) {
                printf("No valid connection\n");
                continue;
            }
            sendMessage(sockfd);
            break;
        case 7:
            if (connectStat) {
                pthread_cancel(tid);
                disconnectServer(sockfd);
            }
            printf("Exit successfully\n");
            exit(0);
            break;
        default:
            printf("Invaid choice\n");
            continue;
            break;
        }
    }
    exit(0);
    return 0;
}
