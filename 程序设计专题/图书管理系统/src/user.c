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
#include "user.h"


#ifndef New
#define New(T) (T)malloc(sizeof(*(T)NULL))
#endif

UserMessageList userlist = NULL;

UserMessageList NewUserList(void)
{
	UserMessageList head;

	head = New(UserMessageList);
	strcpy(head->ID, " ");
	strcpy(head->Name, " ");
	strcpy(head->Gender, " ");
	strcpy(head->WorkUnit, " ");
	strcpy(head->BorrowTimeAll, " ");
	strcpy(head->BorrowTimeNow, " ");
	head->next = NULL;
	return (head);
}

UserMessageList SearchUser(UserMessageList head, char* userid)
{
	UserMessageList nodeptr;
	if (userid == NULL) return NULL;
	nodeptr = head->next;
	while (nodeptr != NULL) {
		if (strcmp(nodeptr->ID, userid) == 0) return nodeptr;
		else nodeptr = nodeptr->next;
	}
	return NULL;
}

//增加用户信息
UserMessageList AddUser(UserMessageList head, UserMessageList nodeptr, UserMessageList obj)
{
	UserMessageList ptr;

	if (obj == NULL) return NULL;
	if (nodeptr == NULL) { /*append the obj to the tail*/
		nodeptr = head;
		while (nodeptr->next != NULL) nodeptr = nodeptr->next;
	}
	ptr = New(UserMessageList); /*New a node*/
	strcpy(ptr->ID, obj->ID);
	strcpy(ptr->Name, obj->Name);  /*Set the data ptr of the node*/
	strcpy(ptr->Gender, obj->Gender);
	strcpy(ptr->WorkUnit, obj->WorkUnit);
	strcpy(ptr->BorrowTimeAll, obj->BorrowTimeAll);
	strcpy(ptr->BorrowTimeNow,obj->BorrowTimeNow);
	ptr->next = nodeptr->next;
	nodeptr->next = ptr;
	return head;
}

void CreateUserList()
{
	FILE* fp = NULL;
	char c;
	char* line, * record;
	char buffer[1024];
	UserMessageList obj = New(UserMessageList);
	obj->next = NULL;
	if ((fp = fopen("user.txt", "at+")) != NULL)
	{
		char* result = NULL;
		int j = 0, i = 0;
		userlist = NewUserList();
		fgets(buffer, sizeof(buffer), fp);//跳过第一行，第一行为表头，不需要输出
		while ((line = fgets(buffer, sizeof(buffer), fp)) != NULL)
		{
			record = strtok(line, "\t");//以制表符分割读入的整行数据
			while (record != NULL)
			{
				switch (j) {
				case 0:strcpy(obj->ID, record); break;
				case 1:strcpy(obj->Name, record); break;
				case 2:strcpy(obj->Gender, record); break;
				case 3:strcpy(obj->WorkUnit, record); break;
				case 4:strcpy(obj->BorrowTimeAll, record); break;
				case 5:strcpy(obj->BorrowTimeNow, record); break;
				default:break;
				}
				record = strtok(NULL, "\t");
				j++;
			}
			AddUser(userlist, NULL, obj);
			j = 0;

		}
		fclose(fp);
		fp = NULL;
	}
}

//用户信息更新
UserMessageList UpdateUser(UserMessageList head,int n, UserMessageList p)
{
	FILE* fp = NULL;
	FILE* fq = NULL;
	UserMessageList ptr;
	char a[1000];
	char b[11];
	int i;
	ptr=SearchUser(head, p->ID);
	if (ptr == NULL) {
		return head;//等界面做好了需要在这里补充显示此id不存在
	}
	strcpy(ptr->Name, p->Name);  /*Set the data ptr of the node*/
	strcpy(ptr->Gender, p->Gender);
	strcpy(ptr->WorkUnit, p->WorkUnit);
	strcpy(ptr->BorrowTimeAll, p->BorrowTimeAll);
	strcpy(ptr->BorrowTimeNow, p->BorrowTimeNow);
	if ((fp = fopen("user.txt", "r+")) != NULL)
	{
		fq = fopen("user2.txt", "w+");
		while (fgets(a, 1000, fp)) {
			for (i = 0; i < 10; i++) {
				b[i] = a[i];
			}
			b[10] = '\0';
			if (strcmp(b, ptr->ID) != 0) {
				fputs(a, fq);
			}
			else {
				if(n==1)
				fprintf(fq, "%s\t%s\t%s\t%s\t%s\t%s\n", p->ID,p->Name,p->Gender,p->WorkUnit, p->BorrowTimeAll, p->BorrowTimeNow);
				else if(n==2)
				fprintf(fq, "%s\t%s\t%s\t%s\t%s\t%s", p->ID, p->Name, p->Gender, p->WorkUnit, p->BorrowTimeAll, p->BorrowTimeNow);
			}
		}
		
		
		fclose(fp);
		fclose(fq);
		remove("user.txt");
		rename("user2.txt","user.txt");
	}
	return ptr;
}

//删除用户
UserMessageList DeleteUser(UserMessageList head, UserMessageList p)
{
	FILE* fp = NULL;
	FILE* fq = NULL;
	UserMessageList ptr1=New(UserMessageList);
	UserMessageList ptr2=New(UserMessageList);
	char a[1000];
	char b[11];
	char c[11];
	int i;
	ptr1 = SearchUser(head, p->ID);
	strcpy(c, p->ID);
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
	if ((fp = fopen("user.txt ", "at+")) != NULL)
	{
		fq = fopen("user2.txt ", "w+");
		while (fgets(a, 1000, fp)) {
			for (i = 0; i < 10; i++) {
				b[i] = a[i];
			}
			b[10] = '\0';
			if (strcmp(b, c) != 0) {
				fputs(a, fq);
			}
		}
		fclose(fp);
		fclose(fq);
		remove("user.txt ");
		rename("user2.txt ", "user.txt ");
	}
	return head;
}