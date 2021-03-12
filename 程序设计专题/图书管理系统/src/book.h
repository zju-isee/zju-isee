#ifndef BOOK_H
#define BOOK_H

//图书信息链表
typedef struct BookMessage {
    char ID[30];//图书编号
    char Name[30];//书名
    char Author[50];//作者
    char KeyWord[50];//关键字
    char Publisher[30];//出版社
    char ReleaseDate[30];//出版日期
    char NumberAll[5];//全部数量
    char Number[5];//当前剩余数量
    char BorrowTime[5];//被借阅次数
    struct BookMessage* next;//下一本书
} *BookMessageList;

extern BookMessageList booklist;//全局变量声明
extern char FileNameCur[30];

//创建一个空头结点的图书链表
BookMessageList NewBookList(void);

//精确查找图书
BookMessageList SearchBook0(BookMessageList head, int choice, char* message);

//模糊查找图书
BookMessageList SearchBook1(BookMessageList head, int choice, char* message);

//插入图书
BookMessageList InsertBook(BookMessageList head, BookMessageList nodeptr, BookMessageList obj);

//创建图书链表
void CreateBookList(char *FileName);

//修改图书信息
BookMessageList UpdateBook(BookMessageList head, int n, BookMessageList p);

//删除图书
BookMessageList DeleteBook(BookMessageList head, BookMessageList p);

#endif