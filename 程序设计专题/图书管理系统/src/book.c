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
#include "book.h"

#ifndef New
#define New(T) (T)malloc(sizeof(*(T)NULL))
#endif

BookMessageList booklist = NULL;
char FileNameCur[30]="";


//创建一个空头结点的图书链表
BookMessageList NewBookList(void)
{
	BookMessageList head;

	head = New(BookMessageList);
	strcpy(head->ID, " ");
	strcpy(head->Name, " ");
    strcpy(head->Author, " ");
	strcpy(head->KeyWord, " ");
	strcpy(head->Publisher, " ");
	strcpy(head->ReleaseDate, " ");
	strcpy(head->NumberAll, " ");
	strcpy(head->Number, " ");
	strcpy(head->BorrowTime, " ");
	head->next = NULL;
	return (head);
}

//精确查找图书
BookMessageList SearchBook0(BookMessageList head, int choice, char* message)
{
	FILE *fp;
	BookMessageList nodeptr;

	if (message == NULL) return NULL;
	nodeptr = head->next;

	switch(choice){
		case 1:
			while (nodeptr != NULL) {
				if (strcmp(nodeptr->ID, message)==0) {
					fp = fopen("return.txt", "w+");
					fprintf(fp, "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s", nodeptr->ID, nodeptr->Name,  nodeptr->Author, nodeptr->KeyWord, nodeptr->Publisher,nodeptr->ReleaseDate,nodeptr->NumberAll, nodeptr->Number, nodeptr->BorrowTime);
					fclose(fp);
					return nodeptr;
				}
				else nodeptr = nodeptr->next;
			}
			break;
		case 2:
			while (nodeptr != NULL) {
				if (strcmp(nodeptr->Name, message)==0) {
					return nodeptr;
				}
				else nodeptr = nodeptr->next;
			}
			break;
		case 3:
			while (nodeptr != NULL) {
				if (strcmp(nodeptr->ID, message)==0) {
					return nodeptr;
				}
				else nodeptr = nodeptr->next;
			}
			break;
		default:break;
	}
	return NULL;
}

//模糊查找图书
BookMessageList SearchBook1(BookMessageList head, int choice, char* message)
{
	FILE *fp;
	BookMessageList rtn=NULL, ptr=NULL;
	BookMessageList nodeptr, obj;

	obj = New(BookMessageList);
	if (message == NULL) return NULL;
	nodeptr = head->next;
	obj->next = NULL;
	rtn = NewBookList();

    switch (choice)
    {
    case 1://书名查找
        while (nodeptr != NULL) {
            if (strstr(nodeptr->Name, message)!=NULL) {
				strcpy(obj->ID, nodeptr->ID);
				strcpy(obj->Name, nodeptr->Name);
				strcpy(obj->Author, nodeptr->Author);
				strcpy(obj->KeyWord, nodeptr->KeyWord);
				strcpy(obj->Publisher, nodeptr->Publisher);
				strcpy(obj->ReleaseDate, nodeptr->ReleaseDate);
				strcpy(obj->NumberAll, nodeptr->NumberAll);
				strcpy(obj->Number, nodeptr->Number);
				strcpy(obj->BorrowTime, nodeptr->BorrowTime);
				InsertBook(rtn, NULL, obj);
			}
            nodeptr = nodeptr->next;
        }
        break;
	case 2://作者查找
		while (nodeptr != NULL) {
            if (strstr(nodeptr->Author, message)!=NULL) {
				strcpy(obj->ID, nodeptr->ID);
				strcpy(obj->Name, nodeptr->Name);
				strcpy(obj->Author, nodeptr->Author);
				strcpy(obj->KeyWord, nodeptr->KeyWord);
				strcpy(obj->Publisher, nodeptr->Publisher);
				strcpy(obj->ReleaseDate, nodeptr->ReleaseDate);
				strcpy(obj->NumberAll, nodeptr->NumberAll);
				strcpy(obj->Number, nodeptr->Number);
				strcpy(obj->BorrowTime, nodeptr->BorrowTime);
				InsertBook(rtn, NULL, obj);
			}
            nodeptr = nodeptr->next;
        }
        break; 
    case 3://关键字查找
		while (nodeptr != NULL) {
            if (strstr(nodeptr->KeyWord, message)!=NULL) {
				strcpy(obj->ID, nodeptr->ID);
				strcpy(obj->Name, nodeptr->Name);
				strcpy(obj->Author, nodeptr->Author);
				strcpy(obj->KeyWord, nodeptr->KeyWord);
				strcpy(obj->Publisher, nodeptr->Publisher);
				strcpy(obj->ReleaseDate, nodeptr->ReleaseDate);
				strcpy(obj->NumberAll, nodeptr->NumberAll);
				strcpy(obj->Number, nodeptr->Number);
				strcpy(obj->BorrowTime, nodeptr->BorrowTime);
				InsertBook(rtn, NULL, obj);			
			}
            nodeptr = nodeptr->next;
        }
        break;   
    default:
        break;
    }
	ptr = rtn->next;
	if(ptr!=NULL)
	{
		fp = fopen("return.txt", "w+");
		while(ptr!=NULL){
			fprintf(fp, "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s", ptr->ID, ptr->Name, ptr->Author, ptr->KeyWord, ptr->Publisher,ptr->ReleaseDate, ptr->NumberAll, ptr->Number, ptr->BorrowTime);
			ptr = ptr->next;
		}
		fclose(fp);
	}
	free(ptr);
	free(obj);
	return rtn;
}

//插入图书信息
BookMessageList InsertBook(BookMessageList head, BookMessageList nodeptr, BookMessageList obj)
{
	BookMessageList ptr;
	if (obj == NULL) return NULL;
	if (nodeptr == NULL) { //得到链表尾部结点
		nodeptr = head;
		while (nodeptr->next != NULL) nodeptr = nodeptr->next;
	}
	ptr = New(BookMessageList); //新结点
    strcpy(ptr->ID, obj->ID);
    strcpy(ptr->Name, obj->Name);
    strcpy(ptr->Author, obj->Author);
    strcpy(ptr->KeyWord, obj->KeyWord);
    strcpy(ptr->Publisher, obj->Publisher);
    strcpy(ptr->ReleaseDate, obj->ReleaseDate);
    strcpy(ptr->NumberAll, obj->NumberAll);
    strcpy(ptr->Number, obj->Number);
    strcpy(ptr->BorrowTime, obj->BorrowTime);
	ptr->next = nodeptr->next;
	nodeptr->next = ptr;
	return head;
}

//从文件创建图书链表
void CreateBookList(char *FileName)
{
	FILE* fp = NULL;
	char c;
	char* line, * record;
	char buffer[1024];
	BookMessageList obj = New(BookMessageList);
	obj->next = NULL;
	if ((fp = fopen(FileName, "at+")) != NULL)
	{
		char* result = NULL;
		int j = 0, i = 0;
		booklist = NewBookList();
		fgets(buffer, sizeof(buffer), fp);//跳过第一行，第一行为表头，不需要输出
		while ((line = fgets(buffer, sizeof(buffer), fp)) != NULL)
		{
			record = strtok(line, "\t");//以制表符分割读入的整行数据
			while (record != NULL)
			{
				switch (j) {
				case 0:strcpy(obj->ID, record); break;
				case 1:strcpy(obj->Name, record); break;
				case 2:strcpy(obj->Author, record); break;
				case 3:strcpy(obj->KeyWord, record); break;
				case 4:strcpy(obj->Publisher, record); break;
				case 5:strcpy(obj->ReleaseDate, record); break;
				case 6:strcpy(obj->NumberAll, record); break;
				case 7:strcpy(obj->Number, record); break;
				case 8:strcpy(obj->BorrowTime, record); break;
				default:break;
				}
				record = strtok(NULL, "\t");
				j++;
			}
			InsertBook(booklist, NULL, obj);
			j = 0;

		}
		fclose(fp);
		fp = NULL;
	}
}

//更新图书
BookMessageList UpdateBook(BookMessageList head, int n, BookMessageList p){
	FILE* fp = NULL;
	FILE* fq = NULL;
	BookMessageList ptr2;
	char a[1000];
	char b[9];
	char c[9];
	int i;
	ptr2 = SearchBook0(head, 3, p->ID);
	if (ptr2 == NULL) {
		return NULL;
	}
	strcpy(ptr2->Name, p->Name); 
	strcpy(ptr2->Author, p->Author);
	strcpy(ptr2->KeyWord, p->KeyWord);
	strcpy(ptr2->Publisher, p->Publisher);
	strcpy(ptr2->ReleaseDate, p->ReleaseDate);
	strcpy(ptr2->NumberAll, p->NumberAll);
	strcpy(ptr2->Number, p->Number);
	strcpy(ptr2->BorrowTime, p->BorrowTime);
	if ((fp = fopen(FileNameCur, "r+")) != NULL)
	{
		fq = fopen("book2.txt", "w+");
		while (fgets(a, 1000, fp)) {
			for (i = 0; i < 8; i++) {
				b[i] = a[i];
			}
			b[8] = '\0';
			for (i = 0; i < 8; i++) {
				c[i] = ptr2->ID[i];
			}
			c[8] = '\0';
			if (strcmp(b, c) != 0) {
				fputs(a, fq);
			}
			else {
				if(n==1)
					fprintf(fq, "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n", p->ID, p->Name,p->Author , p->KeyWord,p->Publisher,p->ReleaseDate,p->NumberAll,p->Number,p->BorrowTime);
				else if(n==2)
					fprintf(fq, "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s", p->ID, p->Name, p->Author, p->KeyWord, p->Publisher, p->ReleaseDate, p->NumberAll, p->Number, p->BorrowTime);
			}
		}
		fclose(fp);
		fclose(fq);
		remove(FileNameCur);
		rename("book2.txt ", FileNameCur);
	}
	return ptr2;
}

//删除图书
BookMessageList DeleteBook(BookMessageList head, BookMessageList p)
{
	FILE* fp = NULL;
	FILE* fq = NULL;
	BookMessageList ptr1,ptr2,ptr3;
	int num1,num2, num3;
	char a[1000];
	char b[9];
	char c[9];
	int i;
	ptr1 = SearchBook0(head, 3, p->ID);
	strcpy(c, p->ID);

	if (ptr1 == NULL) {
		return head;
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
	if ((fp = fopen("book.txt ", "at+")) != NULL)
	{
		fq = fopen("book2.txt ", "w+");
		while (fgets(a, 1000, fp)) {
			for (i = 0; i < 8; i++) {
				b[i] = a[i];
			}
			b[8] = '\0';
			if (strcmp(b, c) != 0) {
				fputs(a, fq);
			}
		}
		fclose(fp);
		fclose(fq);
		remove("book.txt ");
		rename("book2.txt ", "book.txt ");
	}

	return head;
}
