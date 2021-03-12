#include "graphics.h"
#include "extgraph.h"
#include "genlib.h"
#include "simpio.h"
#include "conio.h"
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include <windows.h>
#include <olectl.h>
#include <mmsystem.h>
#include <wingdi.h>
#include <ole2.h>
#include <ocidl.h>
#include <winuser.h>

#include "imgui.h"
#include "borrow.h"

#ifndef New
#define New(T) (T)malloc(sizeof(*(T)NULL))
#endif

BorrowMessageList borrowlist = NULL;

BorrowMessageList NewBorrowList(void)
{
	BorrowMessageList head;

	head = New(BorrowMessageList);
	strcpy(head->UserID, " ");
	strcpy(head->BookID, " ");
	strcpy(head->BookName, " ");
	strcpy(head->BorrowDate, " ");
	strcpy(head->ReturnDue, " ");
	head->next = NULL;
	return (head);
}

BorrowMessageList InsertBR(BorrowMessageList head, BorrowMessageList nodeptr, BorrowMessageList obj)
{
	BorrowMessageList ptr;
	if (obj == NULL) return NULL;
	if (nodeptr == NULL) { //得到链表尾部结点
		nodeptr = head;
		while (nodeptr->next != NULL) nodeptr = nodeptr->next;
	}
	ptr = New(BorrowMessageList); //新结点
	strcpy(ptr->UserID, obj->UserID);
	strcpy(ptr->BookID, obj->BookID);
	strcpy(ptr->BookName, obj->BookName); 
	strcpy(ptr->BorrowDate, obj->BorrowDate);
	strcpy(ptr->ReturnDue, obj->ReturnDue);
	ptr->next = nodeptr->next;
	nodeptr->next = ptr;

	return head;
}

void CreateBorrowList()
{
	FILE* fp = NULL;
	char c;
	char* line, * record;
	char buffer[1024];
	BorrowMessageList obj = New(BorrowMessageList);
	obj->next = NULL;
	if ((fp = fopen("borrow.txt", "at+")) != NULL)
	{
		char* result = NULL;
		int j = 0, i = 0;
		borrowlist = NewBorrowList();
		fgets(buffer, sizeof(buffer), fp);//跳过第一行，第一行为表头，不需要输出
		while ((line = fgets(buffer, sizeof(buffer), fp)) != NULL)
		{
			record = strtok(line, "\t");//以制表符分割读入的整行数据
			while (record != NULL)
			{
				switch (j) {
				case 0:strcpy(obj->UserID, record); break;
				case 1:strcpy(obj->BookID, record); break;
				case 2:strcpy(obj->BookName, record); break;
				case 3:strcpy(obj->BorrowDate, record); break;
				case 4:strcpy(obj->ReturnDue, record); break;
				default:break;
				}
				record = strtok(NULL, "\t");
				j++;
			}
			InsertBR(borrowlist, NULL, obj);
			j = 0;

		}
		fclose(fp);
		fp = NULL;
	}
}

BorrowMessageList SearchBR(BorrowMessageList head, char *message1, char *message2)
{
	BorrowMessageList nodeptr;
	nodeptr = head->next;
	while (nodeptr != NULL) {
		if (strcmp(nodeptr->UserID, message1)==0 && strcmp(nodeptr->BookID, message2)==0) {
			return nodeptr;
		}
		else nodeptr = nodeptr->next;
	}
	return NULL;
}

BorrowMessageList SearchBR1(BorrowMessageList head, char *message)
{
	FILE *fp;
	BorrowMessageList rtn=NULL, ptr=NULL;
	BorrowMessageList nodeptr, obj;

	obj = New(BorrowMessageList);
	if (message == NULL) return NULL;
	nodeptr = head->next;
	obj->next = NULL;
	rtn = NewBorrowList();

	while (nodeptr != NULL) {
		if (strcmp(nodeptr->UserID, message)==0) {
			strcpy(obj->UserID, nodeptr->UserID);
			strcpy(obj->BookID, nodeptr->BookID);
			strcpy(obj->BookName, nodeptr->BookName);
			strcpy(obj->BorrowDate, nodeptr->BorrowDate);
			strcpy(obj->ReturnDue, nodeptr->ReturnDue);
			InsertBR(rtn, NULL, obj);
		}
		nodeptr = nodeptr->next;
	}
	ptr = rtn->next;
	if(ptr!=NULL)
	{
		fp = fopen("return2.txt", "w+");
		fprintf(fp, "%s\t%s\t%s\n", "书名", "借阅日期", "应还日期");
		while(ptr!=NULL){
			fprintf(fp, "%s\t%s\t%s", ptr->BookName, ptr->BorrowDate, ptr->ReturnDue);
			ptr = ptr->next;
		}
		fclose(fp);
	}
	free(ptr);
	free(obj);
	return rtn;
}

BorrowMessageList DeleteBR(BorrowMessageList head, BorrowMessageList p){
	FILE* fp = NULL;
	FILE* fq = NULL;
	BorrowMessageList ptr1,ptr2;
	char a[1000];
	char b[11];
	char c[11];
	char e[9];
	char f[9];
	int i;
	FILE *fw;
	ptr1 = SearchBR(head, p->UserID, p->BookID);
	strcpy(c, p->UserID);
	strcpy(f, p->BookID);
	if (ptr1 == NULL) {
		return head;//等界面做好了需要在这里补充显示此id不存在
	}
	if (ptr1->next == NULL) {
		ptr1 = NULL;
		free(ptr1);
	}
	else {
		ptr2 = head->next;
		if (ptr2 == ptr1) {
			head->next = ptr1->next;
			free(ptr1);
		}
		else {
			while (ptr2->next != ptr1) {
				ptr2 = ptr2->next;
			}
			ptr2->next = ptr1->next;
			ptr1 = NULL;
			free(ptr1);
		}
	}

	if ((fp = fopen("borrow.txt ", "at+")) != NULL)
	{
		fq = fopen("borrow2.txt ", "w+");
		while (fgets(a, 1000, fp)) {
			for (i = 0; i < 10; i++) {
				b[i] = a[i];
			}
			for(i=11; i<19; i++){
				e[i-11] = a[i];
			}
			b[10] = '\0';
			e[8] = '\0';
			if (strcmp(b, c) != 0 || strcmp(e, f) != 0) {
				fputs(a, fq);
			}
		}
		fclose(fp);
		fclose(fq);
		remove("borrow.txt ");
		rename("borrow2.txt ", "borrow.txt ");
	}
	return head;
}