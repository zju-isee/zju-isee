#include "sockchat.h"

void addClient(CLList *CLL, Client *clnt)
{
    CLL->size++;

    if (CLL->tail == NULL) {
        CLL->tail = clnt;
        CLL->head = clnt;
        return;
    }
    CLL->tail->next = clnt;
    CLL->tail = clnt;
}

void deleteCilent(CLList *CLL, int sockfd)
{
    Client *p = CLL->head;
    Client *p_prev = CLL->head;
    while (p != NULL) {
        if (p->fd == sockfd) {
            break;
        }
        p_prev = p;
        p = p->next;
    }
    if (p == p_prev) {
        free(p);
        CLL->head = NULL;
        CLL->tail = NULL;
    } else {
        p_prev->next = p->next;
        free(p);
    }
    CLL->size--;
    return;
}
