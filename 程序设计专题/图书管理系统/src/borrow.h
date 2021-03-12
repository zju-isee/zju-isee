#ifndef BORROW_H
#define BORROW_H

//图书用户关系表
typedef struct BorrowMessage {
    char UserID[30];//借书者ID
    char BookID[30];//图书编号
    char BookName[30];//书名
    char BorrowDate[30];//借阅日期
    char ReturnDue[30];//应还日期
    struct Borrow* next;//下一个对应关系
} *BorrowMessageList;

extern BorrowMessageList borrowlist;

BorrowMessageList NewBorrowList(void);
BorrowMessageList InsertBR(BorrowMessageList head, BorrowMessageList nodeptr, BorrowMessageList obj);
BorrowMessageList SearchBR(BorrowMessageList head, char *message1, char *message2);
BorrowMessageList SearchBR1(BorrowMessageList head, char *message);
void CreateBorrowList();
BorrowMessageList DeleteBR(BorrowMessageList head, BorrowMessageList p);

#endif