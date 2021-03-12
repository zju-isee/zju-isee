#ifndef USER_H
#define USER_H


//用户信息结构
typedef struct UserMessage {
    char ID[30];//用户账号
    char Name[30];//用户姓名
    char Gender[20];//性别
    char WorkUnit[20];//工作单位
    char BorrowTimeAll[10];//总借书量
    char BorrowTimeNow[10];//当前借书量
    struct UserMessage* next;
} *UserMessageList;


extern UserMessageList userlist;


//创建一个空头结点的用户链表
UserMessageList NewUserList(void);

//查找用户
UserMessageList SearchUser(UserMessageList head, char* userid);


//增加用户
UserMessageList AddUser(UserMessageList head, UserMessageList nodeptr, UserMessageList obj);

//创建用户链表
void CreateUserList();

//修改用户信息，返回用户链表头指针；
UserMessageList UpdateUser(UserMessageList head,int n, UserMessageList p);

//删除用户,返回用户链表头指针
UserMessageList DeleteUser(UserMessageList head, UserMessageList p);
#endif