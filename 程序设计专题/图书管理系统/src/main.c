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

#include <time.h>
#include "imgui.h"
#include "book.h"
#include "user.h"
#include "borrow.h"
void VisitGUI();
void UserGUI();
void StartGUI();
void ManagerLogGUI();
void ManagerGUI();
void DrawShowAbout();
void DrawShowUseWay();
#ifndef New
#define New(T) (T)malloc(sizeof(*(T)NULL))
#endif

//日期
struct Date{
	char year[6];
	char month[3];
	char day[3];
};

//返回的借阅日期和应还日期，借书时长设置为15天
struct BRTime{
	struct Date BTime;
	struct Date RTime;
};

//变量
static double WinWidth, WinHeight;//窗口尺寸
static int ShowGUI=0;//切换GUI界面

static char AdminID[30]="admin";//管理员账号
static char AdminPassword[30]="123456";//管理员密码
static char UserIDCur[30] = "";

static int FileState=0;

static int ShowFileNew=0;//控制是否显示新建文件界面
static int ShowFileOpen=0;//控制是否显示打开文件界面
static int ShowFileSave=0;//控制是否显示保存文件界面

static int ShowBookAdd=0;//控制是否显示新增图书界面
static int ShowBookSearch=0;//控制是否显示搜索图书界面
static int ShowBookDelete=0;//控制是否显示删除图书界面
static int ShowBookUpdate=0;//控制是否显示删除图书界面
static int ShowBookPrint=0;//控制是否打印全部图书

static int BookSearchMode=0;
static int UserSearchMode=0;

static int ShowOneUser=0;//打印一个用户
static int ShowAllUser=0;//打印全部用户
static int ShowUserRegister=0;//用户注册
static int ShowUserMessage=0;//控制是否显示用户信息
static int ShowUserUpdate=0;//控制是否修改用户
static int ShowUserDelete=0;//控制是否注销用户
static int ShowUserBorrow=0;//控制是否显示用户借书界面
static int ShowUserReturn=0;//控制是否显示用户还书界面
static int ShowUserSearch=0;//控制是否显示用户查询界面

static int ShowVisitSearch=0;//控制是否显示游客查询书籍界面

static int ShowUserPop=0;//控制是否显示借书排行榜
static int ShowBookPop=0;//控制是否显示最受欢迎图书

static int BookNameSort=0;
static int BookIDSort=0;
static int UserNameSort=0;
static int UserIDSort=0;

static int ShowAbout = 0;
static int ShowUseWay = 0;
//函数
void DisplayClear(void);//清屏函数
void Display(void);//用户的显示函数

void FileNew(void);//新建文件控件
void FileSave(void);//保存文件控件
void FileOpen(void);//打开文件控件

void ManagerBookAdd(void);//新增图书控件
void ManagerBookSearch(int n);//查询图书控件
void ManagerBookDelete(void);//删除图书控件
void ManagerSearchButtons(void);//书籍查找按钮
void ManagerBookDelete(void);//书籍删除
void ManagerUpdateButtons(void);//书籍更新按钮
void ManagerBookUpdate(int n);//书籍更新
void BookPrint(void);//打印全部图书

void UserRegister(void);//用户注册
void UserPrint(void);//打印全部用户
void UserMessageShow(void);//用户个人信息
void UserShow(void);
void UserRegister(void);//用户注册
void UserUpdateButtons(void);//用户更新按钮
void UserUpdate(int n);//用户修改
void UserDelete(void);//用户注销
void UserBorrow(void);//用户借书
void UserReturn(void);//用户还书 
void UserSearch(void);//用户查询
void UserSearchButtons(void);//用户查询图书按钮
void UserSortPrint(char* FileName);
void sort0();//图书借阅排行
void sort1();//用户借阅排行
void sort2();//书名排行
void sort3();//图书ID排行
void sort4();//用户名字排行
void sort5();//用户ID排行
struct BRTime GetTime();
void SearchResultsGUI();
void OnlyHelp();
// 用户的字符事件响应函数
void CharEventProcess(char ch)
{
	uiGetChar(ch);
	Display();
}

// 用户的键盘事件响应函数
void KeyboardEventProcess(int key, int event)
{
	uiGetKeyboard(key,event); // GUI获取键盘
	Display(); // 刷新显示
}

// 用户的鼠标事件响应函数
void MouseEventProcess(int x, int y, int button, int event)
{
	uiGetMouse(x,y,button,event); //GUI获取鼠标
	Display(); // 刷新显示
}

// 用户主程序入口
void Main() 
{
	//关闭控制台，仅在VS Code环境下使用，若为VS2019或VS2010环境，请注释掉下面这行代码
	FreeConsole();
	// 初始化窗口和图形系统
	SetWindowTitle("图书管理系统");
    InitGraphics();

	// 获得窗口尺寸
    WinWidth = GetWindowWidth();
    WinHeight = GetWindowHeight();

    //自定义颜色
    DefineColor("GrayBlue", 0.57, 0.71, 0.83);

	// 注册时间响应函数
	registerCharEvent(CharEventProcess); // 字符
	registerKeyboardEvent(KeyboardEventProcess);// 键盘
	registerMouseEvent(MouseEventProcess);      // 鼠标

    setMenuColors("GrayBlue", "Black", "Dark Gray","White",1 );
    setButtonColors("GrayBlue", "Black", "Dark Gray","White",1 );
    setTextBoxColors("GrayBlue", "Black", "Dark Gray","White",1 );
}

//显示函数
void Display()
{
	// 清屏
	DisplayClear();

    switch(ShowGUI){
        case 0:StartGUI();break;//开始界面
        case 1:VisitGUI();break;//游客界面
        case 2:UserGUI();break;//用户界面
        case 3:ManagerLogGUI();break;//管理员登陆界面
        case 4:ManagerGUI();break;//管理员界面
        case 7:SearchResultsGUI();break;
        case 8:UserShow();break;
        case 9:OnlyHelp(); break;
	    default:break;
    }
}

void OnlyHelp() {
    double fH = GetFontHeight();//字高
    double w = WinWidth / 4;//按钮宽度
    double h = fH * 2.5;//按钮高度
    int selection;//菜单选项
    double x;
    double y;
    static char* menuListHelp[] = { "帮助",
        "关于本软件",
        "使用方法", };
    static char* selectedLabel1 = NULL;
    static char* selectedLabel2 = NULL;

    drawMenuBar(0, WinHeight - fH * 1.5, WinWidth, fH * 1.5);
    selection = menuList(GenUIID(0), 0, WinHeight - fH * 1.5, w / 3, TextStringWidth(menuListHelp[1]) * 1.2, fH * 1.5, menuListHelp, sizeof(menuListHelp) / sizeof(menuListHelp[0]));
    if (selection > 0) {
        selectedLabel1 = menuListHelp[0];
        selectedLabel2 = menuListHelp[selection];
    }
    if (selection == 1) {
        ShowAbout = 1;
        ShowUseWay = 0;
        ShowGUI = 9;
    }
    if (selection == 2) {
        ShowAbout = 0;
        ShowUseWay = 1;
        ShowGUI = 9;
    }
    if (ShowAbout) {
        DrawShowAbout();
    }
    if (ShowUseWay) {
        DrawShowUseWay();
    }
    drawMenuBar(0, 0, WinWidth, fH * 3);//上一步操作显示栏
    if (button(GenUIID(0), WinWidth - WinWidth / 12 - fH, fH * 4, WinWidth / 12, h, "返回")) {
        ShowAbout = 0;
        ShowUseWay = 0;
        ShowGUI = 0;
        selectedLabel1 = NULL;
        selectedLabel2 = NULL;
    }
    SetPenColor("Red");
    drawLabel(0, fH * 2, "上一步菜单操作为：");
    SetPenColor("Black");
    drawLabel(0, fH * 0.5, selectedLabel1);
    drawLabel(w / 3, fH * 0.5, selectedLabel2);
}

//开始界面
void StartGUI(){
    double fH=GetFontHeight();//字高
    double w=WinWidth/4;//按钮宽度
    double h=fH*2.5;//按钮高度
    int selection;//菜单选项
    double x;
    double y;
	static char* menuListHelp[] = { "帮助",
		"关于本软件",
		"使用方法", };
	static char * selectedLabel1 = NULL;
    static char * selectedLabel2 = NULL;

    drawMenuBar(0, WinHeight-fH*1.5, WinWidth, fH*1.5);//菜单栏

	selection = menuList(GenUIID(0), 0, WinHeight-fH*1.5, w/3, TextStringWidth(menuListHelp[1])*1.2, fH*1.5, menuListHelp, sizeof(menuListHelp)/sizeof(menuListHelp[0]));
	if( selection>0 ) {
        selectedLabel1 = menuListHelp[0]; 
        selectedLabel2 = menuListHelp[selection];
    }
    if (selection == 1) {
        ShowAbout = 1;
        ShowUseWay = 0;
        ShowGUI =9;
    }
    if (selection == 2) {
        ShowAbout = 0;
        ShowUseWay = 1;
        ShowGUI = 9;
    }
    if (ShowAbout) {
        DrawShowAbout();
    }
    if (ShowUseWay) {
        DrawShowUseWay();
    }
    drawMenuBar(0, 0, WinWidth, fH*3);//上一步操作显示栏

    if(button(GenUIID(0), WinWidth/2-w/2, WinHeight/2+7*fH , w, h, "游客登录")) {
        selectedLabel1 = NULL;
        selectedLabel2 = NULL;
        ShowGUI=1; 
    }
    if(button(GenUIID(0), WinWidth/2-w/2, WinHeight/2+3.5*fH , w, h, "用户登录")) {
        selectedLabel1 = NULL;
        selectedLabel2 = NULL;
        ShowGUI=2; 
    }
    if(button(GenUIID(0), WinWidth/2-w/2, WinHeight/2, w, h, "管理员登录")) {
        selectedLabel1 = NULL;
        selectedLabel2 = NULL;
        ShowGUI=3;
    } 
    if(button(GenUIID(0), WinWidth/2-w/2, WinHeight/2-3.5*fH, w, h, "退出")) exit(-1);

   
    SetPenColor("Red");
    drawLabel(0, fH*2, "上一步菜单操作为：");
    SetPenColor("Black");
    drawLabel(0, fH*0.5, selectedLabel1);
    drawLabel(w/3, fH*0.5, selectedLabel2);
}

//游客界面
void VisitGUI(){
    double fH=GetFontHeight();//字高
    double w=WinWidth/9;//控件宽度
    double h=fH*2;//文本框高度
    double x=WinWidth/5*2;
    double y=WinHeight/5*3;
    int selection;//菜单选项
	static char* menuListBook[] = { "图书",
		"查询  | Ctrl-P" };
	static char* menuListHelp[] = { "帮助",
		"关于本软件",
		"使用方法"};
	static char * selectedLabel1 = NULL;
    static char * selectedLabel2 = NULL;

    drawMenuBar(0, WinHeight-fH*1.5, WinWidth, fH*1.5);//菜单栏

	//图书菜单
	selection = menuList(GenUIID(0), 0, WinHeight-fH*1.5, w, TextStringWidth(menuListBook[1])*1.2, fH*1.5, menuListBook, sizeof(menuListBook)/sizeof(menuListBook[0]));
	if( selection>0 ) {
        selectedLabel1 = menuListBook[0]; 
        selectedLabel2 = menuListBook[selection];
    }
	if( selection==1 ) {
        if(strcmp(FileNameCur, "")==0){
            SetPenColor("Black");
            drawLabel(WinWidth/3, WinHeight/2, "图书库暂未开放！");
        }
        else {
            ShowVisitSearch = 1;
            ShowAbout = 0;
            ShowUseWay = 0;
        }
	}

	if(ShowVisitSearch){
        CreateBookList(FileNameCur);
        BookSearchMode=3;
		ManagerSearchButtons();
    }

	// Help 菜单
	selection = menuList(GenUIID(0), w, WinHeight-fH*1.5, w, TextStringWidth(menuListHelp[1])*1.2, fH*1.5, menuListHelp, sizeof(menuListHelp)/sizeof(menuListHelp[0]));
	if( selection>0 ) {
        selectedLabel1 = menuListHelp[0]; 
        selectedLabel2 = menuListHelp[selection];
    }
    if (selection == 1) {
        ShowVisitSearch = 0;
         ShowAbout = 1;
         ShowUseWay = 0;
    }
    if (selection == 2) {
        ShowVisitSearch = 0;
        ShowAbout = 0;
        ShowUseWay = 1;
    }
    if (ShowAbout) {
        DrawShowAbout();
    }
    if (ShowUseWay) {
        DrawShowUseWay();
    }

    drawMenuBar(0, 0, WinWidth, fH*3);//上一步操作显示栏

    if(button(GenUIID(0), WinWidth-WinWidth/12-fH, fH*4 , WinWidth/12, h, "返回")) {
		ShowVisitSearch=0;
        ShowAbout = 0;
        ShowUseWay = 0;
        selectedLabel1 = NULL;
        selectedLabel2 = NULL;
        ShowGUI=0; 
    }    

    SetPenColor("Red");
    drawLabel(0, fH*2, "上一步菜单操作为：");
    SetPenColor("Black");
    drawLabel(0, fH*0.5, selectedLabel1);
    drawLabel(WinWidth/12, fH*0.5, selectedLabel2);
}

//用户界面
void UserGUI(){
	FILE *fp;
    double fH=GetFontHeight();//字高
    double w=WinWidth/9;//控件宽度
    double h=fH*2;//文本框高度
    double x=WinWidth/5*2;
    double y=WinHeight/5*3;
    int selection;//菜单选项
    static char* menuListUser[] = { "用户",
        "注册",
		"查看",
		"修改",
        "注销" };
	static char* menuListBook[] = { "图书",
		"查询  | Ctrl-P" };
	static char* menuListBR[] = { "借书/还书",
		"借书",
		"还书" };
	static char* menuListHelp[] = { "帮助",
		"关于本软件",
		"使用方法"};
	static char * selectedLabel1 = NULL;
    static char * selectedLabel2 = NULL;

    drawMenuBar(0, WinHeight-fH*1.5, WinWidth, fH*1.5);//菜单栏

    //用户菜单
    selection = menuList(GenUIID(0), 0, WinHeight-fH*1.5, w, TextStringWidth(menuListUser[1])*1.5, fH*1.5, menuListUser, sizeof(menuListUser)/sizeof(menuListUser[0]));
    if( selection>0 ) {
        selectedLabel1 = menuListUser[0]; 
        selectedLabel2 = menuListUser[selection];
    }

	if(selection==1){
        ShowAbout = 0;
        ShowUseWay = 0;
        ShowUserRegister=1;
        ShowUserMessage=0;
        ShowUserUpdate=0;
        ShowUserDelete=0;
        ShowUserBorrow=0;
        ShowUserReturn=0;
        ShowUserSearch=0;
	}
    if( selection==2 ) {
		if((fp=fopen("user.txt", "r+"))==NULL){
			SetPenColor("Black");
			drawLabel(WinWidth/2, WinHeight/2, "暂无用户！");
		}
        else{
			fclose(fp);
			ShowAbout = 0;
			ShowUseWay = 0;
			ShowUserRegister=0;
			ShowUserMessage=1;
			ShowUserUpdate=0;
			ShowUserDelete=0;
			ShowUserBorrow=0;
			ShowUserReturn=0;
			ShowUserSearch=0;
		}
    }
    if( selection==3 ) {
		if((fp=fopen("user.txt", "r+"))==NULL){
			SetPenColor("Black");
			drawLabel(WinWidth/2, WinHeight/2, "暂无用户！");
		}
        else{
			fclose(fp);
			ShowAbout = 0;
			ShowUseWay = 0;
			ShowUserRegister=0;
			ShowUserMessage=0;
			ShowUserUpdate=1;
			ShowUserDelete=0;
			ShowUserBorrow=0;
			ShowUserReturn=0;
			ShowUserSearch=0;
		}
    }
    if( selection==4 ) {
		if((fp=fopen("user.txt", "r+"))==NULL){
			SetPenColor("Black");
			drawLabel(WinWidth/2, WinHeight/2, "暂无用户！");
		}
        else{
			fclose(fp);
			ShowAbout = 0;
			ShowUseWay = 0;
			ShowUserRegister=0;
			ShowUserMessage=0;
			ShowUserUpdate=0;
			ShowUserDelete=1;
			ShowUserBorrow=0;
			ShowUserReturn=0;
			ShowUserSearch=0;
		}
    }


    if(ShowUserRegister){
        UserRegister();
    }
	if(ShowUserMessage){
		UserSearchMode=2;
		UserMessageShow();
	}
    if(ShowUserUpdate){
		CreateUserList();
		UserUpdateButtons();
    }
    if(ShowUserDelete){
		CreateUserList();
		UserDelete();
    }

	//图书菜单
	selection = menuList(GenUIID(0), w, WinHeight-fH*1.5, w, TextStringWidth(menuListBook[1])*1.2, fH*1.5, menuListBook, sizeof(menuListBook)/sizeof(menuListBook[0]));
	if( selection>0 ) {
        selectedLabel1 = menuListBook[0]; 
        selectedLabel2 = menuListBook[selection];
    }
	if( selection==1 ) {
        if(strcmp(FileNameCur, "")==0){
            SetPenColor("Black");
            drawLabel(WinWidth/2, WinHeight/2, "图书库暂未开放！");
        }
        else{     
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowUserRegister=0;
            ShowUserMessage=0;
            ShowUserUpdate=0;
            ShowUserDelete=0;
            ShowUserBorrow=0;
            ShowUserReturn=0;
            ShowUserSearch=1;
        }
    }

	if(ShowUserSearch){
        CreateBookList(FileNameCur);
        BookSearchMode=2;
        ManagerSearchButtons();
    }

	//借书/还书
	selection = menuList(GenUIID(0), 2*w, WinHeight-fH*1.5, w*1.5, TextStringWidth(menuListBR[1])*1.5, fH*1.5, menuListBR, sizeof(menuListBR)/sizeof(menuListBR[0]));
	if( selection>0 ) {
        selectedLabel1 = menuListBR[0]; 
        selectedLabel2 = menuListBR[selection];
    }
	if( selection==1 ) {
        if(strcmp(FileNameCur, "")==0){
            SetPenColor("Black");
            drawLabel(WinWidth/2, WinHeight/2, "图书库暂未开放！");
        }
		else if((fp=fopen("user.txt", "r+"))==NULL){
			SetPenColor("Black");
			drawLabel(WinWidth/2, WinHeight/2, "暂无用户！");
		}
        else{
			fclose(fp);
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowUserRegister=0;
            ShowUserMessage=0;
            ShowUserUpdate=0;
            ShowUserDelete=0;
            ShowUserBorrow=1;
            ShowUserReturn=0;
            ShowUserSearch=0;
        }
    }
	if( selection==2 ) {
        if(strcmp(FileNameCur, "")==0){
            SetPenColor("Black");
            drawLabel(WinWidth/2, WinHeight/2, "图书库暂未开放！");
        }
		else if((fp=fopen("user.txt", "r+"))==NULL){
			SetPenColor("Black");
			drawLabel(WinWidth/2, WinHeight/2, "暂无用户！");
		}
        else{
			fclose(fp);
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowUserRegister=0;
            ShowUserMessage=0;
            ShowUserUpdate=0;
            ShowUserDelete=0;
            ShowUserBorrow=0;
            ShowUserReturn=1;
            ShowUserSearch=0;
        }
    }

    if(ShowUserBorrow){
        CreateBookList(FileNameCur);
        CreateUserList();
        UserBorrow();
    }
    
    if(ShowUserReturn){
        CreateBookList(FileNameCur);
        CreateUserList();
        UserReturn();
    }


	// Help 菜单
	selection = menuList(GenUIID(0),3.5*w, WinHeight-fH*1.5, w, TextStringWidth(menuListHelp[1])*1.2, fH*1.5, menuListHelp, sizeof(menuListHelp)/sizeof(menuListHelp[0]));
	if( selection>0 ) {
        selectedLabel1 = menuListHelp[0]; 
        selectedLabel2 = menuListHelp[selection];
    }
    if (selection == 1) {
        ShowAbout = 1;
        ShowUseWay = 0;
        ShowUserRegister = 0;
        ShowUserMessage = 0;
        ShowUserUpdate = 0;
        ShowUserDelete = 0;
        ShowUserBorrow = 0;
        ShowUserReturn = 0;
        ShowUserSearch = 0;
    }
    if (selection == 2) {
        ShowAbout = 0;
        ShowUseWay = 1;
        ShowUserRegister = 0;
        ShowUserMessage = 0;
        ShowUserUpdate = 0;
        ShowUserDelete = 0;
        ShowUserBorrow = 0;
        ShowUserReturn = 0;
        ShowUserSearch = 0;
    }
    if (ShowAbout) {
        DrawShowAbout();
    }
    if (ShowUseWay) {
        DrawShowUseWay();
    }

    drawMenuBar(0, 0, WinWidth, fH*3);//上一步操作显示栏

    if(button(GenUIID(0), WinWidth-WinWidth/12-fH, fH*4 , WinWidth/12, h, "返回")) {
        ShowAbout = 0;
        ShowUseWay = 0;
        ShowUserRegister=0;
        ShowUserMessage=0;
        ShowUserUpdate=0;
        ShowUserDelete=0;
        ShowUserBorrow=0;
        ShowUserReturn=0;
        ShowUserSearch=0;
        selectedLabel1 = NULL;
        selectedLabel2 = NULL;
        ShowGUI=0; 
    }    

    //小图标区
    //搜索按钮
    x = 0;
    y = WinHeight/15*11-1.5*h;
    if(button(GenUIID(0) ,x, y, 1.5*h, 1.5*h, "")) {
        if(strcmp(FileNameCur, "")==0){
            SetPenColor("Black");
            drawLabel(WinWidth/2, WinHeight/2, "图书库暂未开放！");
        }
        else{
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowUserRegister=0;
            ShowUserMessage=0;
            ShowUserUpdate=0;
            ShowUserDelete=0;
            ShowUserBorrow=0;
            ShowUserReturn=0;
            ShowUserSearch=1;
        }
    } 
    MovePen(x+1.4*h,y+1*h);
    DrawArc(0.4*h,0,360);
    MovePen(x+1.25*h,y+1*h);
    DrawArc(0.25*h,0,360);
    MovePen(x+0.2*h,y+0.2*h);
    DrawLine(0.55*h,0.55*h);

    //换肤按钮
    x = 0;
    y = WinHeight/15*11-3*h;
    if(button(GenUIID(0) ,x, y, 1.5*h, 1.5*h, ""))    {  
        static int times = 0; 
        usePredefinedColors(++times);
   }
    MovePen(x+0.3*1.5*h,y+0.8*1.5*h);
    DrawLine(-0.2*1.5*h,-0.3*1.5*h);
    DrawLine(0.1*1.5*h,-0.1*1.5*h);
    DrawLine(0.1*1.5*h,0.067*1.5*h);
    DrawLine(0,-0.3*1.5*h);
    DrawLine(0.4*1.5*h,0);
    DrawLine(0,0.3*1.5*h);
    DrawLine(0.1*1.5*h,-0.067*1.5*h);
    DrawLine(0.1*1.5*h,0.1*1.5*h);
    DrawLine(-0.2*1.5*h,0.3*1.5*h);
    DrawLine(-0.4*1.5*h,0);

    //主页按钮
    x = 0;
    y = WinHeight/15*11-4.5*h;
    if(button(GenUIID(0) ,x, y, 1.5*h, 1.5*h, "")) {
        ShowAbout = 0;
        ShowUseWay = 0;
        ShowUserRegister=0;
        ShowUserMessage=0;
        ShowUserUpdate=0;
        ShowUserDelete=0;
        ShowUserBorrow=0;
        ShowUserReturn=0;
        ShowUserSearch=0;
        selectedLabel1 = NULL;
        selectedLabel2 = NULL;
        ShowGUI=0; 
    } 
    MovePen(x+0.5*1.5*h,y+0.8*1.5*h);
    DrawLine(-0.3*1.5*h,-0.3*1.5*h);
    DrawLine(0.6*1.5*h,0);
    DrawLine(-0.3*1.5*h,0.3*1.5*h);
    MovePen(x+0.35*1.5*h,y+0.5*1.5*h);
    DrawLine(0,-0.3*1.5*h);
    DrawLine(0.3*1.5*h,0);
    DrawLine(0,0.3*1.5*h);

    //返回按钮
    x = 0;
    y = WinHeight/15*11-6*h;
    if(button(GenUIID(0) ,x, y, 1.5*h, 1.5*h, "")) {
        ShowAbout = 0;
        ShowUseWay = 0;
        ShowUserRegister=0;
        ShowUserMessage=0;
        ShowUserUpdate=0;
        ShowUserDelete=0;
        ShowUserBorrow=0;
        ShowUserReturn=0;
        ShowUserSearch=0;
        selectedLabel1 = NULL;
        selectedLabel2 = NULL;
        ShowGUI=0; 
    } 
    MovePen(x+0.7*h,y+1.1*h);
    DrawLine(-0.5*h,-0.4*h);
    DrawLine(1.1*h,0);
    DrawLine(-1.1*h,0);
    DrawLine(0.5*h,-0.4*h);

    //注销按钮
    x = 0;
    y = WinHeight/15*11-7.5*h;
    if(button(GenUIID(0) ,x, y, 1.5*h, 1.5*h, ""))  exit(-1);
    MovePen(x+0.8*1.5*h,y+0.5*1.5*h);
    DrawArc(0.3*1.5*h,0,360); 

    SetPenColor("Red");
    drawLabel(0, fH*2, "上一步菜单操作为：");
    SetPenColor("Black");
    drawLabel(0, fH*0.5, selectedLabel1);
    drawLabel(WinWidth/12, fH*0.5, selectedLabel2);
}

//管理员登录界面
void ManagerLogGUI(){
    double fH=GetFontHeight();//字高
    double w=WinWidth/4;//文本框宽度
    double h=fH*2;//文本框高度
    double x=WinWidth/5*2;
    double y=WinHeight/5*3;
    int selection;//菜单选项
	static char* menuListHelp[] = { "帮助",
		"关于本软件",
		"使用方法", };
	static char * selectedLabel1 = NULL;
    static char * selectedLabel2 = NULL;
    static char ID[30]={'\0'};//管理员账号
    static char password[30]={'\0'};//管理员密码
    static char inputID[30]={'\0'};//输入账号
    static char inputPassword[30]={'\0'};//输入密码

    drawMenuBar(0, WinHeight-fH*1.5, WinWidth, fH*1.5);//菜单栏
	selection = menuList(GenUIID(0), 0, WinHeight-fH*1.5, w/3, TextStringWidth(menuListHelp[1])*1.2, fH*1.5, menuListHelp, sizeof(menuListHelp)/sizeof(menuListHelp[0]));
	if( selection>0 ) {
        selectedLabel1 = menuListHelp[0]; 
        selectedLabel2 = menuListHelp[selection];
    }
	if( selection==1 ) ;
    if( selection==2 ) ;

    drawMenuBar(0, 0, WinWidth, fH*3);//上一步操作显示栏

	SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("账号"), y+fH*0.9, "账号");
	if( textbox(GenUIID(0), x, y+fH*0.4, w, h, ID, sizeof(ID)) )
		sprintf(inputID,"%s", ID);

	SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("密码"), y-1.9*fH, "密码");
	if( textbox(GenUIID(0), x, y-2.6*fH, w, h, password, sizeof(password)) )
		sprintf(inputPassword,"%s", password);

    if(button(GenUIID(0), x+w/3*2, y-5.6*fH , w/3, h, "登录")) {
        if(strcmp(inputID, AdminID)==0 && strcmp(inputPassword, AdminPassword)==0){
            ShowGUI=4;//管理员账号密码匹配则登录
        }
        else{
            SetPenColor("Black");
            drawLabel(x, y-8.6*fH, "密码错误");
        }
    }

    if(button(GenUIID(0), WinWidth-w/3-fH, fH*4 , w/3, h, "返回")) {
        selectedLabel1 = NULL;
        selectedLabel2 = NULL;
        ShowGUI=0; 
    } 

    SetPenColor("Red");
    drawLabel(0, fH*2, "上一步菜单操作为：");
    SetPenColor("Black");
    drawLabel(0, fH*0.5, selectedLabel1);
    drawLabel(w/3, fH*0.5, selectedLabel2);
}

//管理员界面
void ManagerGUI(){
    FILE *fp;
    double fH=GetFontHeight();//字高
    double w=WinWidth/9;//控件宽度
    double h=fH*2;//文本框高度
    double x=WinWidth/5*2;
    double y=WinHeight/5*3;
    int selection;//菜单选项
    static char* menuListFile[] = { "文件",
		"新建  | Ctrl-N",
		"打开  | Ctrl-O",
		"保存  | Ctrl-S",
		"退出  | Ctrl-Q" };
	static char* menuListBook[] = { "图书",
		"新增  | Ctrl-A",
		"查询  | Ctrl-P",
		"修改  | Ctrl-R",
		"删除  | Ctrl-D",
		"查看全部图书" };
	static char* menuListBR[] = { "用户",
		"查看一个用户",
		"查看全部用户" };
    static char* menuListSort[] = { "排序",
        "按书名排序",
        "按图书编号排序",
        "按用户名排序",
		"按用户编号排序"};
    static char* menuListStatictics[] = { "统计",
        "图书借阅排行榜",
        "用户借阅排行榜"};
	static char* menuListHelp[] = { "帮助",
		"关于本软件",
		"使用方法"};
	static char * selectedLabel1 = NULL;
    static char * selectedLabel2 = NULL;


    drawMenuBar(0, WinHeight-fH*1.5, WinWidth, fH*1.5);//菜单栏

    //文件菜单
    selection = menuList(GenUIID(0), 0, WinHeight-fH*1.5, w, TextStringWidth(menuListFile[1])*1.2, fH*1.5, menuListFile, sizeof(menuListFile)/sizeof(menuListFile[0]));
    if( selection>0 ) {
        selectedLabel1 = menuListFile[0]; 
        selectedLabel2 = menuListFile[selection];
    }
    if( selection==1 ) {
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=1;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;
    }
    if( selection==2 ) {
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=1;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;
    }
    if( selection==3 ) {
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;           
            drawLabel(WinWidth/3, WinHeight/2, "保存成功！");
    }
    if( selection==4 ) exit(-1);

    //显示新建文件界面
    if(ShowFileNew){
        FileNew();
    }

    //显示打开文件界面
    if(ShowFileOpen){
        FileOpen();
        FileState = 1;
    }


	//图书菜单
	selection = menuList(GenUIID(0), w, WinHeight-fH*1.5, w, TextStringWidth(menuListBook[1])*1.5, fH*1.6, menuListBook, sizeof(menuListBook)/sizeof(menuListBook[0]));
	if( selection>0 ) {
        selectedLabel1 = menuListBook[0]; 
        selectedLabel2 = menuListBook[selection];
    }
	if( selection==1 ) {
        if(strcmp(FileNameCur, "")==0){
            drawLabel(WinWidth/3, WinHeight/2, "文件尚未打开，请打开文件！");
        }
        else {
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=1;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowOneUser=0;
            ShowAllUser=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;
        }
    }
	if( selection==2 ) {
        if(strcmp(FileNameCur, "")==0){
            drawLabel(WinWidth/3, WinHeight/2, "文件尚未打开，请打开文件！");
        }
        else {
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=1;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowOneUser=0;
            ShowAllUser=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;
        }
    }
	if( selection==3 ) {
        if(strcmp(FileNameCur, "")==0){
            drawLabel(WinWidth/3, WinHeight/2, "文件尚未打开，请打开文件！");
        }
        else {
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=1;
            ShowBookPrint=0;
            ShowOneUser=0;
            ShowAllUser=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;
        }
    }
	if( selection==4 ) {
        if(strcmp(FileNameCur, "")==0){
            drawLabel(WinWidth/3, WinHeight/2, "文件尚未打开，请打开文件！");
        }
        else {
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=1;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowOneUser=0;
            ShowAllUser=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;
        }
    }
	if( selection==5 )  {
        if(strcmp(FileNameCur, "")==0){
            drawLabel(WinWidth/3, WinHeight/2, "文件尚未打开，请打开文件！");
        }
        else {
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=1;
            ShowOneUser=0;
            ShowAllUser=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;
        }
    }

    if(ShowBookAdd){
        ManagerBookAdd();
    }
    if(ShowBookSearch){
        CreateBookList(FileNameCur);
        BookSearchMode=1;
        ManagerSearchButtons();
    }
	if(ShowBookUpdate){
        CreateBookList(FileNameCur);
        ManagerUpdateButtons();
    }
	if(ShowBookDelete){
        CreateBookList(FileNameCur);
        ManagerBookDelete();
    }
	if(ShowBookPrint){
        CreateBookList(FileNameCur);
        BookPrint();  
    }

	//用户
	selection = menuList(GenUIID(0), 2*w, WinHeight-fH*1.5, w, TextStringWidth(menuListBR[1])*1.2, fH*1.5, menuListBR, sizeof(menuListBR)/sizeof(menuListBR[0]));
	if( selection>0 ) {
        selectedLabel1 = menuListBR[0]; 
        selectedLabel2 = menuListBR[selection];
    }
	if( selection==1 ) {
        if( (fp=fopen("user.txt", "r+"))==NULL ){
            SetPenColor("Black");
            drawLabel(WinWidth/3, WinHeight/2, "暂无注册用户！");
        }
        else {
            fclose(fp);
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowOneUser=1;
            ShowAllUser=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;
        }
    }
	if( selection==2 ) {
        if( (fp=fopen("user.txt", "r+"))==NULL ){
            SetPenColor("Black");
            drawLabel(WinWidth/3, WinHeight/2, "暂无注册用户！");
        }
        else {
            fclose(fp);
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowOneUser=0;
            ShowAllUser=1;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;
        }
    }
	if(ShowOneUser){
		UserSearchMode=1;
		UserMessageShow();
	}
	if(ShowAllUser){
        UserPrint();
    }
    //排序
	selection = menuList(GenUIID(0), 3*w, WinHeight-fH*1.5, w, TextStringWidth(menuListSort[2])*1.3, fH*1.5, menuListSort, sizeof(menuListSort)/sizeof(menuListSort[0]));
	if( selection>0 ) {
        selectedLabel1 = menuListSort[0]; 
        selectedLabel2 = menuListSort[selection];
    }
	if( selection==1 )  {
        if(strcmp(FileNameCur, "")==0){
            SetPenColor("Black");
            drawLabel(WinWidth/3, WinHeight/2, "文件尚未打开，请打开文件！");
        }
        else {
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowOneUser=0;
            ShowAllUser=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=1;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;
        }
    }
	if( selection==2 )  {
        if(strcmp(FileNameCur, "")==0){
            SetPenColor("Black");
            drawLabel(WinWidth/3, WinHeight/2, "文件尚未打开，请打开文件！");
        }
        else {
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowOneUser=0;
            ShowAllUser=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=1;
            UserNameSort=0;
            UserIDSort=0;
        }
    }
    if( selection==3 ) {
        if( (fp=fopen("user.txt", "r+"))==NULL ){
            SetPenColor("Black");
            drawLabel(WinWidth/3, WinHeight/2, "暂无注册用户！");
        }
        else {
            fclose(fp);
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowOneUser=0;
            ShowAllUser=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=1;
            UserIDSort=0;
        }
    }
    if( selection==4 ) {
        if( (fp=fopen("user.txt", "r+"))==NULL ){
            SetPenColor("Black");
            drawLabel(WinWidth/3, WinHeight/2, "暂无注册用户！");
        }
        else {
            fclose(fp);
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowOneUser=0;
            ShowAllUser=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=1;
        }
    }
    if(BookNameSort){
        CreateBookList(FileNameCur);
        sort2();
    }
    if(BookIDSort){
        CreateBookList(FileNameCur);
        sort3();
    }
    if(UserNameSort){
        CreateUserList();
        sort4();
    }
    if(UserIDSort){
        CreateUserList();
        sort5();
    }
    //统计
	selection = menuList(GenUIID(0), 4*w, WinHeight-fH*1.5, w, TextStringWidth(menuListStatictics[1])*1.5, fH*1.5, menuListStatictics, sizeof(menuListStatictics)/sizeof(menuListStatictics[0]));
	if( selection>0 ) {
        selectedLabel1 = menuListStatictics[0]; 
        selectedLabel2 = menuListStatictics[selection];
    }
	if( selection==1 )  {
        if(strcmp(FileNameCur, "")==0){
            SetPenColor("Black");
            drawLabel(WinWidth/3, WinHeight/2, "文件尚未打开，请打开文件！");
        }
        else {
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowOneUser=0;
            ShowAllUser=0;
            ShowBookPop=1;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;
        }
    }
	if( selection==2 ) {
        if( (fp=fopen("user.txt", "r+"))==NULL ){
            SetPenColor("Black");
            drawLabel(WinWidth/3, WinHeight/2, "暂无注册用户！");
        }
        else {
            fclose(fp);
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=0;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowOneUser=0;
            ShowAllUser=0;
            ShowBookPop=0;
            ShowUserPop=1;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;
        }
    }
	if(ShowBookPop){
        CreateBookList(FileNameCur);
        sort0();
    }
	if(ShowUserPop){
        CreateUserList();
        sort1();
    }


	// Help 菜单
	selection = menuList(GenUIID(0),5*w, WinHeight-fH*1.5, w, TextStringWidth(menuListHelp[1])*1.2, fH*1.5, menuListHelp, sizeof(menuListHelp)/sizeof(menuListHelp[0]));
	if( selection>0 ) {
        selectedLabel1 = menuListHelp[0]; 
        selectedLabel2 = menuListHelp[selection];
    }
	if( selection==1 ) {
        ShowAbout = 1;
        ShowUseWay = 0;
        ShowFileNew = 0;
        ShowFileOpen = 0;
        ShowFileSave = 0;
        ShowFileSave = 0;
        ShowBookAdd = 0;
        ShowBookSearch = 0;
        ShowBookDelete = 0;
        ShowBookUpdate = 0;
        ShowBookPrint = 0;
        ShowOneUser = 0;
        ShowAllUser = 0;
        ShowBookPop = 0;
        ShowUserPop = 0;
        BookNameSort = 0;
        BookIDSort = 0;
        UserNameSort = 0;
        UserIDSort = 0;
    }
	if( selection==2 ) {
        ShowAbout = 0;
        ShowUseWay = 1;
        ShowFileNew = 0;
        ShowFileOpen = 0;
        ShowFileSave = 0;
        ShowFileSave = 0;
        ShowBookAdd = 0;
        ShowBookSearch = 0;
        ShowBookDelete = 0;
        ShowBookUpdate = 0;
        ShowBookPrint = 0;
        ShowOneUser = 0;
        ShowAllUser = 0;
        ShowBookPop = 0;
        ShowUserPop = 0;
        BookNameSort = 0;
        BookIDSort = 0;
        UserNameSort = 0;
        UserIDSort = 0;
    }

    if (ShowAbout) {
        DrawShowAbout();
    }
    if (ShowUseWay) {
        DrawShowUseWay();
    }
    drawMenuBar(0, 0, WinWidth, fH*3);//上一步操作显示栏

    //小图标区
    //搜索按钮
    x = 0;
    y = WinHeight/15*11-1.5*h;
    if(button(GenUIID(0) ,x, y, 1.5*h, 1.5*h, "")) {
            ShowAbout = 0;
            ShowUseWay = 0;
            ShowFileNew=0;
            ShowFileOpen=0;
            ShowFileSave=0;
            ShowFileSave=0;
            ShowBookAdd=0;
            ShowBookSearch=1;
            ShowBookDelete=0;
            ShowBookUpdate=0;
            ShowBookPrint=0;
            ShowOneUser=0;
            ShowAllUser=0;
            ShowBookPop=0;
            ShowUserPop=0;
            BookNameSort=0;
            BookIDSort=0;
            UserNameSort=0;
            UserIDSort=0;
    } 
    MovePen(x+1.4*h,y+1*h);
    DrawArc(0.4*h,0,360);
    MovePen(x+1.25*h,y+1*h);
    DrawArc(0.25*h,0,360);
    MovePen(x+0.2*h,y+0.2*h);
    DrawLine(0.55*h,0.55*h);

    //换肤按钮
    x = 0;
    y = WinHeight/15*11-3*h;
    if(button(GenUIID(0) ,x, y, 1.5*h, 1.5*h, ""))    {  
        static int times = 0; 
        usePredefinedColors(++times);
   }
    MovePen(x+0.3*1.5*h,y+0.8*1.5*h);
    DrawLine(-0.2*1.5*h,-0.3*1.5*h);
    DrawLine(0.1*1.5*h,-0.1*1.5*h);
    DrawLine(0.1*1.5*h,0.067*1.5*h);
    DrawLine(0,-0.3*1.5*h);
    DrawLine(0.4*1.5*h,0);
    DrawLine(0,0.3*1.5*h);
    DrawLine(0.1*1.5*h,-0.067*1.5*h);
    DrawLine(0.1*1.5*h,0.1*1.5*h);
    DrawLine(-0.2*1.5*h,0.3*1.5*h);
    DrawLine(-0.4*1.5*h,0);

    //主页按钮
    x = 0;
    y = WinHeight/15*11-4.5*h;
    if(button(GenUIID(0) ,x, y, 1.5*h, 1.5*h, "")) {
        ShowAbout = 0;
        ShowUseWay = 0;
        ShowFileNew=0;
        ShowFileOpen=0;
        ShowFileSave=0;
        ShowFileSave=0;
        ShowBookAdd=0;
        ShowBookSearch=0;
        ShowBookDelete=0;
        ShowBookUpdate=0;
        ShowBookPrint=0;
        ShowOneUser=0;
        ShowAllUser=0;
        ShowBookPop=0;
        ShowUserPop=0;
        BookNameSort=0;
        BookIDSort=0;
        UserNameSort=0;
        UserIDSort=0;
        selectedLabel1 = NULL;
        selectedLabel2 = NULL;
        ShowGUI=0; 
    } 
    MovePen(x+0.5*1.5*h,y+0.8*1.5*h);
    DrawLine(-0.3*1.5*h,-0.3*1.5*h);
    DrawLine(0.6*1.5*h,0);
    DrawLine(-0.3*1.5*h,0.3*1.5*h);
    MovePen(x+0.35*1.5*h,y+0.5*1.5*h);
    DrawLine(0,-0.3*1.5*h);
    DrawLine(0.3*1.5*h,0);
    DrawLine(0,0.3*1.5*h);

    //返回按钮
    x = 0;
    y = WinHeight/15*11-6*h;
    if(button(GenUIID(0) ,x, y, 1.5*h, 1.5*h, "")) {
        ShowAbout = 0;
        ShowUseWay = 0;
        ShowFileNew=0;
        ShowFileOpen=0;
        ShowFileSave=0;
        ShowFileSave=0;
        ShowBookAdd=0;
        ShowBookSearch=0;
        ShowBookDelete=0;
        ShowBookUpdate=0;
        ShowBookPrint=0;
        ShowOneUser=0;
        ShowAllUser=0;
        ShowBookPop=0;
        ShowUserPop=0;
        BookNameSort=0;
        BookIDSort=0;
        UserNameSort=0;
        UserIDSort=0;
        selectedLabel1 = NULL;
        selectedLabel2 = NULL;
        ShowGUI=3; 
    } 
    MovePen(x+0.7*h,y+1.1*h);
    DrawLine(-0.5*h,-0.4*h);
    DrawLine(1.1*h,0);
    DrawLine(-1.1*h,0);
    DrawLine(0.5*h,-0.4*h);

    //注销按钮
    x = 0;
    y = WinHeight/15*11-7.5*h;
    if(button(GenUIID(0) ,x, y, 1.5*h, 1.5*h, ""))  exit(-1);
    MovePen(x+0.8*1.5*h,y+0.5*1.5*h);
    DrawArc(0.3*1.5*h,0,360); 

    if(button(GenUIID(0), WinWidth-WinWidth/12-fH, fH*4 , WinWidth/12, h, "返回")) {
        ShowAbout = 0;
        ShowUseWay = 0;
        ShowFileNew=0;
        ShowFileOpen=0;
        ShowFileSave=0;
        ShowFileSave=0;
        ShowBookAdd=0;
        ShowBookSearch=0;
        ShowBookDelete=0;
        ShowBookUpdate=0;
        ShowBookPrint=0;
        ShowOneUser=0;
        ShowAllUser=0;
        ShowBookPop=0;
        ShowUserPop=0;
        BookNameSort=0;
        BookIDSort=0;
        UserNameSort=0;
        UserIDSort=0;
        selectedLabel1 = NULL;
        selectedLabel2 = NULL;
        ShowGUI=3; 
    }  

    SetPenColor("Red");
    drawLabel(0, fH*2, "上一步菜单操作为：");
    SetPenColor("Black");
    drawLabel(0, fH*0.5, selectedLabel1);
    drawLabel(WinWidth/12, fH*0.5, selectedLabel2);
}


//新建文件
void FileNew(){
    FILE *fp;
    static char FileName[30] = "";
    static char results[30] = "";

    SetPenColor("Black");
    drawLabel(WinWidth/3, WinHeight/3*2, "请输入后缀名为.txt的文件名");
	if(textbox(GenUIID(0), WinWidth/3, WinHeight/3*2-3*GetFontHeight(), WinWidth/4, 2*GetFontHeight(), FileName, sizeof(FileName)) )
		sprintf(results,"%s", FileName);
    if(button(GenUIID(0), WinWidth/2, WinHeight/3*2-6*GetFontHeight() , WinWidth/12, 2*GetFontHeight(), "确定")){
        fp = fopen(results, "w+");
        fprintf(fp, "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n", "图书编号", "书名", "作者", "关键字", "出版社", "发行日期", "总库存", "当前数量", "总借阅次数");
        fclose(fp);
        SetPenColor("Black");
        drawLabel(WinWidth/3, WinHeight/3*2-9*GetFontHeight(), "新建成功");
    }
}

//打开文件
void FileOpen(){
    FILE *fp;
    static char FileName[30] = "";
    static char results[30] = "";

    SetPenColor("Black");
    drawLabel(WinWidth/3, WinHeight/3*2, "请输入要打开的文件名");
	if(textbox(GenUIID(0), WinWidth/3, WinHeight/3*2-3*GetFontHeight(), WinWidth/4, 2*GetFontHeight(), FileName, sizeof(FileName)) )
		sprintf(results,"%s", FileName);
    if(button(GenUIID(0), WinWidth/2, WinHeight/3*2-6*GetFontHeight() , WinWidth/12, 2*GetFontHeight(), "确定")){
        if((fp = fopen(results, "r+"))==NULL){
            SetPenColor("Black");
            drawLabel(WinWidth/3, WinHeight/3*2-9*GetFontHeight(),"文件不存在！");
        }
        else{
            strcpy(FileNameCur, results);
            SetPenColor("Black");
            drawLabel(WinWidth/3, WinHeight/3*2-9*GetFontHeight(),"打开成功！");
            fclose(fp);
        }
    }
}

//新增图书
void ManagerBookAdd(){
    FILE *fp;
	static char input1[20] = "";
	static char input2[30] = "";
	static char input3[50] = "";
	static char input4[20] = "";
	static char input5[30] = "";
	static char input6[30] = "";
    static char input7[5] = "";
	static char ID[20] = "";
    static char Name[30] = "";
	static char KeyWord[50] = "";
    static char Author[20] = "";
    static char Publisher[30] = "";
    static char ReleaseDate[30];
    static char NumberAll[5] ="";
    static char BorrowTime[5] = "0";
	double fH = GetFontHeight();
	double h = fH*2; 
    double w=WinWidth/4;
	double x = 6*h;
	double y = WinWidth/2+1.8*h;

	SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("ID"), (y-=h*1.5)+fH*0.7, "ID");
	if( textbox(GenUIID(0), x, y, w, h, input1, sizeof(input1)))
		sprintf(ID,"%s", input1);

	SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("书名"), (y-=h*1.5)+fH*0.7, "书名");
	if( textbox(GenUIID(0), x, y, w, h, input2, sizeof(input2)))
		sprintf(Name,"%s", input2);

	SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("作者"), (y-=h*1.5)+fH*0.7, "作者");
	if( textbox(GenUIID(0), x, y, w, h, input3, sizeof(input3)))
		sprintf(Author,"%s", input3);

	SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("关键字"), (y-=h*1.5)+fH*0.7, "关键字");
	if( textbox(GenUIID(0), x, y, w, h, input4, sizeof(input4)))
		sprintf(KeyWord,"%s", input4);

	SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("出版社"), (y-=h*1.5)+fH*0.7, "出版社");
	if( textbox(GenUIID(0), x, y, w, h, input5, sizeof(input5)))
		sprintf(Publisher,"%s", input5);

	SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("出版日期"), (y-=h*1.5)+fH*0.7, "出版日期");
	if( textbox(GenUIID(0), x, y, w, h, input6, sizeof(input6)))
		sprintf(ReleaseDate,"%s", input6);
    
    SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("库存"), (y-=h*1.5)+fH*0.7, "库存");
	if( textbox(GenUIID(0), x, y, w, h, input7, sizeof(input7)))
		sprintf(NumberAll,"%s", input7);
    	
	if(button(GenUIID(0), x+w/2, y-=h*1.5, w/2, h, "新增")){
        CreateBookList(FileNameCur);
        if(SearchBook0(booklist, 3, ID)!=NULL){
            SetPenColor("Black");
            drawLabel(x, y-=h*2, "图书编号重复！");
        }
        else if (strlen(ID) != 8) {
            SetPenColor("Black");
            drawLabel(x, y -= h * 2, "请输入八位有效图书ID！");
        }
        else{
            fp = fopen(FileNameCur, "at+");
            fprintf(fp, "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n", ID, Name, Author, KeyWord, Publisher, ReleaseDate, NumberAll, NumberAll, BorrowTime);
            fclose(fp);
            SetPenColor("Black");
            drawLabel(x, y-=h*2, "新增成功！");
            strcpy(input1, "");
            strcpy(input2, "");
            strcpy(input3, "");
            strcpy(input4, "");
            strcpy(input5, "");
            strcpy(input6, "");
            strcpy(input7, "");
        }
	}
}

//管理员查询书籍按钮
void ManagerSearchButtons()
{
	double fH = GetFontHeight();
	double h = fH*2;  // 控件高度
	double x = 0;  
	double y = WinHeight/15*11; 
	double w = WinWidth/9; // 控件宽度
	static int AccordingToName=0;
	static int AccordingToID=0;
    static int AccordingToAuthor=0;
    static int AccordingToKeyWord=0;

	if(button(GenUIID(0), x+3*h, y , w, h, "按书号查询")) {
        AccordingToKeyWord=0;
		AccordingToName=0;
        AccordingToAuthor=0;
		AccordingToID=1;
	} 
	if(button(GenUIID(0), x+3*h, y-1.5*h, w, h, "按书名查询")) {
        AccordingToKeyWord=0;
		AccordingToID=0;
        AccordingToAuthor=0;
		AccordingToName=1; 
	}
	if(button(GenUIID(0), x+3*h, y-3*h, w, h, "按作者查询")) {
        AccordingToKeyWord=0;
		AccordingToID=0;
		AccordingToName=0; 
        AccordingToAuthor=1;
	}
	if(button(GenUIID(0), x+3*h, y-4.5*h, w, h, "按关键字查询")) {
		AccordingToID=0;
		AccordingToName=0; 
        AccordingToAuthor=0;
        AccordingToKeyWord=1;
    }
    if(AccordingToID) ManagerBookSearch(1);
	if(AccordingToName) ManagerBookSearch(2);
	if(AccordingToAuthor) ManagerBookSearch(3);
    if(AccordingToKeyWord) ManagerBookSearch(4);
}

//查询图书
void ManagerBookSearch(int n){
    static char input[80] = "";//预设书名
    static char results[200] = "";
    double fH = GetFontHeight();
    double h = fH*2; // 控件高度
    double w = WinWidth/4; // 控件宽度
    double x = WinWidth/3-1.5*h;
    double y = WinHeight/15*11;
    BookMessageList ptr=NULL;

    SetPenColor("Black"); 
    switch(n){
        case 1: drawLabel(x-fH/2-TextStringWidth("书号"), y+fH*0.7, "书号"); break;
        case 2: drawLabel(x-fH/2-TextStringWidth("书名"), y+fH*0.7, "书名"); break;
        case 3: drawLabel(x-fH/2-TextStringWidth("作者"), y+fH*0.7, "作者"); break;
        case 4: drawLabel(x-fH/2-TextStringWidth("关键字"), y+fH*0.7, "关键字"); break;
        default: break;
    }

    if( textbox(GenUIID(0), x, y, w, h, input, sizeof(input)))
        sprintf(results,"%s", input);
    else strcpy(results, input);

    //画查询图标按钮
    if(button(GenUIID(0), x+w+0.5*h, y, w/2, h, "查询")) {
        if(n==1){
        ptr = SearchBook0(booklist, 1, results);
        if(ptr==NULL){
            SetPenColor("Black"); 
            drawLabel(x, y-2*h+fH*0.7, "书籍不存在");
        }
        else
            ShowGUI = 7;
        
        }      
        else{
        ptr = SearchBook1(booklist, n-1, results);
        if(ptr->next==NULL){
            SetPenColor("Black"); 
            drawLabel(x, y-2*h+fH*0.7, "书籍不存在");
        }
        else
                ShowGUI = 7;
    }
    } 
}

//搜索结果
void SearchResultsGUI(){
    FILE* fa = NULL;
	double fH = GetFontHeight();
	double h = fH*2; // 控件高度
	double x = WinWidth/18;
	double y = WinHeight/15*14;
	static char ID[20] = "";//书籍编号
	static char Name[30] = "";//书名
	static char Author[20] = "";//作者，目前只实现了单一作者操作
	static char KeyWord[50] = "";//关键字
	static char Publisher[30] = "";//出版社
	static char ReleaseDate[30];//出版日期
	static char NumberAll[5] = "";
    static char Number[5] = "";
	static int i=0;
	static char* line, * record;
	static char buffer[1024];
	static char* result = NULL;
	static int j = 0;

	SetPenColor("Black");
	drawLabel(x, y, "图书编号");
	drawLabel(x+3*h, y, "书名");
	drawLabel(x+6*h, y, "作者");
	drawLabel(x+10*h, y, "关键字");
	drawLabel(x+16*h, y, "出版社");
	drawLabel(x+20*h, y, "出版日期");
	drawLabel(x+23*h, y, "总数量");
    drawLabel(x+25*h, y, "剩余数量");
	drawMenuBar(0, WinHeight-fH*1.5, WinWidth, fH*1.5);//菜单栏
	drawMenuBar(0, 0, WinWidth, fH*3);//上一步操作显示栏

	y = y-h;

	if ((fa = fopen("return.txt", "r+")) != NULL)
	{
		while ((line = fgets(buffer, sizeof(buffer), fa)) != NULL)
		{
		record = strtok(line, "\t");//以制表符分割读入的整行数据
		while (record != NULL)
		{
			switch (j) {
			case 0:strcpy(ID, record); break;
			case 1:strcpy(Name, record); break;
			case 2:strcpy(Author, record); break;
			case 3:strcpy(KeyWord, record); break;
			case 4:strcpy(Publisher, record); break;
			case 5:strcpy(ReleaseDate, record); break;
			case 6:strcpy(NumberAll, record); break;
            case 7:strcpy(Number, record); break;
            case 8:break;
			default:break;
			}
			record = strtok(NULL, "\t");
			j++;
		}
		SetPenColor("Black");
		drawLabel(x, y-i*h, ID);
		drawLabel(x+3*h, y-i*h, Name);
		drawLabel(x+6*h, y-i*h, Author);
		drawLabel(x+10*h, y-i*h, KeyWord);
		drawLabel(x+16*h, y-i*h, Publisher);
		drawLabel(x+20*h, y-i*h, ReleaseDate);
		drawLabel(x+23*h, y-i*h, NumberAll);
        drawLabel(x+25*h, y-i*h, Number);
		i++;
		j = 0;

		}
		fclose(fa);
		fa = NULL;
	}
	i=0;

	if(button(GenUIID(0), WinWidth-WinWidth/12-fH, fH*4 , WinWidth/12, h, "返回")) {
		remove("return.txt");
		switch(BookSearchMode){
			case 1:ShowGUI=4; break;
			case 2:ShowGUI=2; break;
			case 3:ShowGUI=1; break;
			default:break;
		}
	} 
}

//删除图书
void ManagerBookDelete(){

	static char input[80] = "";
	static char results[200] = "";
	static int DeleteMode=0;

	BookMessageList ptr = New(BookMessageList);
	BookMessageList p = New(BookMessageList);

	SetPenColor("Black");
	drawLabel(WinWidth/3, WinHeight/3*2, "请输入需要删除的图书编号");

	if (textbox(GenUIID(0), WinWidth/3, WinHeight/3*2-3*GetFontHeight(), WinWidth/4, 2*GetFontHeight(), input, sizeof(input)))
		sprintf(results, "%s", input);
	else strcpy(results, input);
	if (button(GenUIID(0), WinWidth/2, WinHeight/3*2-6*GetFontHeight() , WinWidth/12, 2*GetFontHeight(), "确定")){
		DeleteMode = 1;
	}
	if (DeleteMode) {
		ptr = SearchBook0(booklist, 3, results);
		if (ptr != NULL) {
		 DeleteBook(booklist, ptr);
		}
		SetPenColor("Black");
		drawLabel(WinWidth/2, WinHeight/3*2-9*GetFontHeight(), "删除成功");
	}

	DeleteMode = 0;
}

//修改图书按钮
void ManagerUpdateButtons(){
	double fH = GetFontHeight();
	double h = fH*2;  // 控件高度
	double x = 0;  
	double y = WinHeight/15*11; 
	double w = WinWidth/9; // 控件宽度
	static int AccordingToName=0;
    static int AccordingToAuthor=0;
    static int AccordingToKeyWord=0;
	static int AccordingToPublisher=0;
	static int AccordingToReleaseDate=0;
	static int AccordingToNumber=0;


	if(button(GenUIID(0), x+3*h, y, w, h, "修改书名")) {
        AccordingToKeyWord=0;
        AccordingToAuthor=0;
		AccordingToPublisher=0;
		AccordingToNumber=0;
		AccordingToReleaseDate=0;
		AccordingToName=1; 
	}

	if(button(GenUIID(0), x+3*h, y-1.5*h, w, h, "修改作者")) {
		AccordingToName=0; 
        AccordingToAuthor=1;
		AccordingToPublisher=0;
		AccordingToReleaseDate=0;
		AccordingToNumber=0;
        AccordingToKeyWord=0;
    }

	if(button(GenUIID(0), x+3*h, y-3*h, w, h, "修改关键字")) {
        AccordingToKeyWord=1;
		AccordingToName=0; 
		AccordingToPublisher=0;
		AccordingToReleaseDate=0;
		AccordingToNumber=0;
        AccordingToAuthor=0;
	}

	if(button(GenUIID(0), x+3*h, y-4.5*h, w, h, "修改出版社")) {
		AccordingToName=0; 
        AccordingToAuthor=0;
		AccordingToReleaseDate=0;
		AccordingToPublisher=1;
		AccordingToNumber=0;
        AccordingToKeyWord=0;
    }

	if(button(GenUIID(0), x+3*h, y-6*h, w, h, "修改出版日期")) {
		AccordingToName=0; 
        AccordingToAuthor=0;
		AccordingToReleaseDate=1;
		AccordingToPublisher=0;
		AccordingToNumber=0;
        AccordingToKeyWord=0;
    }

	if(button(GenUIID(0), x+3*h, y-7.5*h, w, h, "修改库存")) {
		AccordingToName=0; 
        AccordingToAuthor=0;
		AccordingToPublisher=0;
		AccordingToReleaseDate=0;
		AccordingToNumber=1;
        AccordingToKeyWord=0;
    }

	if(AccordingToName)
		ManagerBookUpdate(1);

	if(AccordingToAuthor)
		ManagerBookUpdate(2);

    if(AccordingToKeyWord)
        ManagerBookUpdate(3);

    if(AccordingToPublisher)
        ManagerBookUpdate(4);

    if(AccordingToReleaseDate)
        ManagerBookUpdate(5);

    if(AccordingToNumber)
        ManagerBookUpdate(6);
}

//修改图书
void ManagerBookUpdate(int n){
	static char input[80] = "";//id号输入
	static char input2[80] = "";//新信息输入
	static char results[200] = "";
	static char results2[200] = "";
	static char ID[20] = "";//书籍编号
    static char Name[30] = "";//书名
    static char Author[20] = "";//作者，目前只实现了单一作者操作
    static char KeyWord[50] = "";//关键字
    static char Publisher[30] = "";//出版社
    static char ReleaseDate[30];//出版日期
    static char NumberAll[5] = "";//借阅次数
	static int changeMode = 0;
	double fH = GetFontHeight();
	double h = fH * 2; // 控件高度
	double w = WinWidth / 4; // 控件宽度
	double x = WinWidth/3-1.5*h;
    double y = WinHeight/15*11;
	BookMessageList ptr = New(BookMessageList);
	BookMessageList p = New(BookMessageList);

    SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("输"), y+fH*0.7, "图书编号");

    switch(n){
        case 1: drawLabel(x-fH/2-TextStringWidth("新"), y-1.5*h+fH*0.7, "新书名"); break;
        case 2: drawLabel(x-fH/2-TextStringWidth("新"), y-1.5*h+fH*0.7, "新作者"); break;
        case 3: drawLabel(x-fH/2-TextStringWidth("新"), y-1.5*h+fH*0.7, "新关键字"); break;
		case 4: drawLabel(x-fH/2-TextStringWidth("新"), y-1.5*h+fH*0.7, "新出版社"); break;
		case 5: drawLabel(x-fH/2-TextStringWidth("新"), y-1.5*h+fH*0.7, "新出版日期"); break;
		case 6: drawLabel(x-fH/2-TextStringWidth("新"), y-1.5*h+fH*0.7, "新库存"); break;
        default: break;
    }

	if (textbox(GenUIID(0), x+TextStringWidth("新出版日期"), y, w, h, input, sizeof(input)))
		sprintf(results, "%s", input);
	else strcpy(results, input);

	if (textbox(GenUIID(0), x+TextStringWidth("新出版日期"), y-1.5*h, w, h, input2, sizeof(input2)))
		sprintf(results2, "%s", input2);
	else strcpy(results2, input2);

	if(button(GenUIID(0), x+w/2+TextStringWidth("新出版日期"), y-3*h, w/2, h, "确认")){
		changeMode = 1;
	}

	if (changeMode) {
		ptr = SearchBook0(booklist,3, results);
		if (ptr != NULL) {
			if (n == 1) {
				strcpy(ptr->Name, results2);
				p = UpdateBook(booklist,2 ,ptr);
			}
			if (n == 2) {
				strcpy(ptr->Author, results2);
				p = UpdateBook(booklist,2 ,ptr);
			}	
			if (n == 3) {
				strcpy(ptr->KeyWord, results2);
				p = UpdateBook(booklist,2, ptr);
			}	
			if (n == 4) {
				strcpy(ptr->Publisher, results2);
				p = UpdateBook(booklist,2, ptr);
			}	
			if (n == 5) {
				strcpy(ptr->ReleaseDate, results2);
				p = UpdateBook(booklist,2, ptr);
			}	
			if (n == 6) {
				strcpy(ptr->NumberAll, results2);
                strcpy(ptr->Number, results2);
				p = UpdateBook(booklist,2, ptr);
			}	
			SetPenColor("Black");
			drawLabel(WinWidth/2, WinHeight/2, "修改成功！");
		}
		changeMode = 0;
	}
}

//显示全部图书
void BookPrint(){
    FILE* fa = NULL;
	double fH = GetFontHeight();
	double h = fH*2; // 控件高度
	double x = WinWidth/12;
    double y = WinHeight/15*11;
	static char ID[20] = "";//书籍编号
    static char Name[30] = "";//书名
    static char Author[20] = "";//作者
    static char KeyWord[50] = "";//关键字
    static char Publisher[30] = "";//出版社
    static char ReleaseDate[30];//出版日期
    static char NumberAll[5] = "";//剩余数量
	static char Number[5] = "";
	static int i=0;
	static char* line, * record;
	static char buffer[1024];
	static char* result = NULL;
	static int j = 0;

	SetPenColor("Black");
    drawLabel(x, y, "图书编号");
    drawLabel(x+3*h, y, "书名");
    drawLabel(x+6*h, y, "作者");
    drawLabel(x+9*h, y, "关键字");
    drawLabel(x+12*h, y, "出版社");
    drawLabel(x+15*h, y, "出版日期");
    drawLabel(x+18*h, y, "总库存");
	drawLabel(x+21*h, y, "剩余数量");

    y = y-h;

	if ((fa = fopen(FileNameCur, "r+")) != NULL)
		{
			fgets(buffer, sizeof(buffer), fa);
			while ((line = fgets(buffer, sizeof(buffer), fa)) != NULL)
			{
				record = strtok(line, "\t");//以制表符分割读入的整行数据
				while (record != NULL)
				{
					switch (j) {
					case 0:strcpy(ID, record); break;
					case 1:strcpy(Name, record); break;
					case 2:strcpy(KeyWord, record); break;
					case 3:strcpy(Author, record); break;
					case 4:strcpy(Publisher, record); break;
					case 5:strcpy(ReleaseDate, record); break;
					case 6:strcpy(NumberAll, record); break;
					case 7:strcpy(Number, record); break;
                    case 8:break;
					default:break;
					}
					record = strtok(NULL, "\t");
					j++;
				}
				SetPenColor("Black");
				drawLabel(x, y-i*h, ID);
				drawLabel(x+3*h, y-i*h, Name);
				drawLabel(x+6*h, y-i*h, Author);
				drawLabel(x+9*h, y-i*h, KeyWord);
				drawLabel(x+12*h, y-i*h, Publisher);
				drawLabel(x+15*h, y-i*h, ReleaseDate);
				drawLabel(x+18*h, y-i*h, NumberAll);
				drawLabel(x+21*h, y-i*h, Number);
				i++;
				j = 0;

			}
			fclose(fa);
			fa = NULL;
		}
	i=0;
}

//用户注册
void UserRegister(){
    FILE *fp;
	double fH = GetFontHeight();
	double h = fH*2; // 文本框高度
    double w=WinWidth/4;//控件宽度
	double x = 6*h;
	double y = WinWidth/2+1.8*h;
    int selection;//菜单选项
	static char input1[20] = "";//
	static char input2[30] = "";//
	static char input3[5] = "";//
	static char input4[50] = "";//
	static char ID[20] = "";
	static char Name[30] = "";
	static char Gender[5] = "";
	static char WorkUnit[50] = "";

	SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("ID"), (y-=h*1.5)+fH*0.7, "ID");
	if( textbox(GenUIID(0), x, y, w, h, input1, sizeof(input1)))
		sprintf(ID,"%s", input1);

	SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("姓名"), (y-=h*1.5)+fH*0.7, "姓名");
	if( textbox(GenUIID(0), x, y, w, h, input2, sizeof(input2)))
		sprintf(Name,"%s", input2);

	SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("性别"), (y-=h*1.5)+fH*0.7, "性别");
	if( textbox(GenUIID(0), x, y, w, h, input3, sizeof(input3)))
		sprintf(Gender,"%s", input3);

	SetPenColor("Black"); 
	drawLabel(x-fH/2-TextStringWidth("工作单位"), (y-=h*1.5)+fH*0.7, "工作单位");
	if( textbox(GenUIID(0), x, y, w, h, input4, sizeof(input4)))
		sprintf(WorkUnit,"%s", input4);

	if(button(GenUIID(0), x+w/2, y-=h*1.5, w/2, h, "注册")){
        if((fp=fopen("user.txt", "r+"))==NULL){
            fp = fopen("user.txt", "w+");
            fprintf(fp, "%s\t%s\t%s\t%s\t%s\t%s\n", "用户编号", "姓名", "性别", "工作单位", "总借书量", "当前借书量");
            fprintf(fp, "%s\t%s\t%s\t%s\t%s\t%s\n", ID, Name, Gender, WorkUnit, "0", "0");
            fclose(fp);
            SetPenColor("Black");
            drawLabel(x, y-=h*2, "注册成功！");
        }
        else{
			fclose(fp);
            CreateUserList();
            if(SearchUser(userlist, ID)!=NULL){
                SetPenColor("Black");
                drawLabel(x, y-=h*2, "用户编号重复！");
            }
            else if (strlen(ID)!=10) {
                SetPenColor("Black");
                drawLabel(x, y -= h * 2, "请输入十位有效用户ID！");
            }
            else{
                fp = fopen("user.txt", "at+");
                fprintf(fp, "%s\t%s\t%s\t%s\t%s\t%s\n", ID, Name, Gender, WorkUnit, "0", "0");
                fclose(fp);
                SetPenColor("Black");
                drawLabel(x, y-=h*2, "注册成功！");
                strcpy(input1, "");
                strcpy(input2, "");
                strcpy(input3, "");
                strcpy(input4, "");
            }
        }
	}
}

//打印全部用户
void UserPrint(){
    FILE* fa = NULL;
	double fH = GetFontHeight();
	double h = fH*2;
	double x = WinWidth/12;
    double y = WinHeight/15*11;
	static char ID[20] = "";
    static char Name[30] = "";
    static char Gender[20] = "";
	static char WorkUnit[50] = "";
    static char BorrowTimeAll[30] = "";
    static char BorrowTimeNow[30] = "";
	static int i=0;
	static char* line, * record;
	static char buffer[1024];
	static char* result = NULL;
	static int j = 0;

	SetPointSize(4);
	SetPenColor("Black");
    drawLabel(x, y, "用户ID");
    drawLabel(x+4*h, y, "姓名");
    drawLabel(x+8*h, y, "性别");
    drawLabel(x+12*h, y, "工作单位");
    drawLabel(x+16*h, y, "总借书数");
    drawLabel(x+20*h, y, "当前借阅数");

    y = y-h;

	if ((fa = fopen("user.txt", "r+")) != NULL)
		{
			fgets(buffer, sizeof(buffer), fa);
			while ((line = fgets(buffer, sizeof(buffer), fa)) != NULL)
			{
				record = strtok(line, "\t");//以制表符分割读入的整行数据
				while (record != NULL)
				{
					switch (j) {
					case 0:strcpy(ID, record); break;
					case 1:strcpy(Name, record); break;
					case 2:strcpy(Gender, record); break;
					case 3:strcpy(WorkUnit, record);break;
					case 4:strcpy(BorrowTimeAll, record); break;
					case 5:strcpy(BorrowTimeNow, record); break;
					default:break;
					}
					record = strtok(NULL, "\t");
					j++;
				}
				SetPenColor("Black");
				drawLabel(x, y-i*h, ID);
				drawLabel(x+4*h, y-i*h, Name);
				drawLabel(x+8*h, y-i*h, Gender);
				drawLabel(x+12*h, y-i*h, WorkUnit);
				drawLabel(x+16*h, y-i*h, BorrowTimeAll);
				drawLabel(x+20*h, y-i*h, BorrowTimeNow);
				i++;
				j = 0;

			}
			fclose(fa);
			fa = NULL;
		}
	i=0;
}

//用户借书
void UserBorrow(){
    FILE *fw;
	FILE *fp;
	static char input1[80] = "";
	static char input2[80] = "";
	static char results1[200] = "";
	static char results2[200] = "";
	static char ID[20] = "";//书籍编号
	static char Name[30] = "";//书名
	static char Author2[500] = "";//作者
	static char Publisher[30] = "";//出版社
	static char ReleaseDate[30];//出版日期
	static char BorrowOrNot[300];
	static char Number1[5];
	static char Number2[5];
	static int searchMode = 0;
	double fH = GetFontHeight();
	double h = fH * 2; // 控件高度
	double w = WinWidth / 4; // 控件宽度
	double x = 16 * fH;
	double y = WinWidth / 3 * 2 - 3.6 * fH;
	int num, time,num2,time2,numall,numnow;
	struct BRTime date;
	BookMessageList ptr = New(BookMessageList);
	BookMessageList p = New(BookMessageList);
	UserMessageList ptr3 = New(UserMessageList);
	SetPenColor("Black");
	drawLabel(x - fH*1.5 - TextStringWidth("书名"), (y -= h * 1.5) + fH * 0.7, "用户ID");
	if (textbox(GenUIID(0), x, y, w, h, input1, sizeof(input1)))
	sprintf(results1, "%s", input1);
	else strcpy(results1, input1);

	SetPenColor("Black");
	drawLabel(x - fH*1.5 - TextStringWidth("书名"), (y -= h * 1.5) + fH * 0.7, "书名");
	if (textbox(GenUIID(0), x, y, w, h, input2, sizeof(input2)))
	sprintf(results2, "%s", input2);
	else strcpy(results2, input2);

	if (button(GenUIID(0), x + w + 0.5 * h, y, w / 2, h, "确认借书"))   searchMode = 1;

	if (searchMode) {
        if(strcmp(FileNameCur, "")==0){
            SetPenColor("Black");
            drawLabel( x , y-h,"管理员暂未开放借还书功能");
        }
        else{
            CreateUserList();
            CreateBookList(FileNameCur);
            ptr = SearchBook0(booklist, 2, results2);
            ptr3 = SearchUser(userlist, results1);
            if(ptr3==NULL){
                SetPenColor("Black");
                drawLabel( x + w + 0.5 * h, y-h,"用户不存在！");                
            }
            else if(ptr==NULL){
                SetPenColor("Black");
                drawLabel( x + w + 0.5 * h, y-h,"书籍不存在！");                     
            }
	        else{
                sprintf(ID, "书号：%s", ptr->ID);
                sprintf(Name, "书名：%s", ptr->Name);
                sprintf(Author2, "作者：%s", ptr->Author);
                sprintf(Publisher, "出版社：%s", ptr->Publisher);
                sprintf(ReleaseDate, "出版日期：%s", ptr->ReleaseDate);
                sprintf(Number1, "剩余数量：%s", ptr->Number);
                num = atoi(ptr->Number);
                numnow = atoi(ptr3->BorrowTimeNow);
                if (num > 0&&numnow<2) {
                    time = atoi(ptr->BorrowTime);
                    time++;
                    itoa(time, ptr->BorrowTime, 10);//该书借阅次数加一
                    num--;
                    itoa(num, ptr->Number, 10);//该书库存减一
                    numall = atoi(ptr3->BorrowTimeAll);
                    numall++;
                    itoa(numall, ptr3->BorrowTimeAll, 10);//总借书次数加一
            
                    numnow++;
                    itoa(numnow, ptr3->BorrowTimeNow, 10);//当前借书次数加一
                    sprintf(BorrowOrNot, "借书成功 剩余数量：%s", ptr->Number);
                    UpdateBook(booklist,1, ptr);
                    UpdateUser(userlist,1, ptr3);
                    date = GetTime();
                    
                    if ((fw = fopen("borrow.txt", "r+")) == NULL) {
                        fw = fopen("borrow.txt", "at+");
                        fprintf(fw, "%s\t%s\t%s\t%s\t%s\n", "用户ID", "图书ID", "书名", "借阅日期", "应还日期");
                    }
                    else {
                        fclose(fw);
                        fw = fopen("borrow.txt", "at+");
                    }
                    fprintf(fw, "%s\t%s\t%s\t%s-%s-%s\t%s-%s-%s\n", results1, ptr->ID, ptr->Name, date.BTime.year, date.BTime.month, date.BTime.day, date.RTime.year, date.RTime.month, date.RTime.day);
                    fclose(fw);
                }
                else if(num<=0) {
                    sprintf(BorrowOrNot, "库存为零借阅失败");
                }
                else if (numnow >= 2) {
                    sprintf(BorrowOrNot, "用户借书数量超过限制借阅失败");
                }
	}
        }
	    searchMode = 0;
	}
	drawLabel(x, y - fH * 3, ID);
	drawLabel(x, y - fH * 6, Name);
    drawLabel(x, y - fH * 9, Author2);
	drawLabel(x, y - fH * 12, Publisher);
	drawLabel(x, y - fH * 15, ReleaseDate);
	drawLabel(x, y - fH * 18, BorrowOrNot);
}

//获取借书和还书时间
struct BRTime GetTime(){
	int year, month, day;
	int year1, month1, day1;
	struct BRTime results;
	time_t timep;
	struct tm *p;
	time(&timep);
	p=gmtime(&timep);

	year=1900+p->tm_year;
	month=1+p->tm_mon;
	day=p->tm_mday;
    switch(month){
        case 1: 
            if(day+15>31) {day1 = day+15-31;month1 = month+1;}
            else {day1 = day+15;month1 = month;year1=year;}
            break;
        case 2:
            if(day+15>28){day1 = day+15-28;month1 = month+1;}
            else{day1 = day+15;month1 = month;year1=year;}
            break;
        case 3:
            if(day+15>31) {day1 = day+15-31;month1 = month+1;}
            else {day1 = day+15;month1 = month;year1=year;}
            break;
        case 4:
            if(day+15>30) {day1 = day+15-30;month1 = month+1;}
            else {day1 = day+15;month1 = month;year1=year;}
            break;
        case 5: 
            if(day+15>31) {day1 = day+15-31;month1 = month+1;}
            else {day1 = day+15;month1 = month;year1=year;}
            break;
        case 6:
            if(day+15>30){day1 = day+15-30;month1 = month+1;}
            else{day1 = day+15;month1 = month;year1=year;}
            break;
        case 7:
            if(day+15>31) {day1 = day+15-31;month1 = month+1;}
            else {day1 = day+15;month1 = month;year1=year;}
            break;
        case 8:
            if(day+15>31) {day1 = day+15-31;month1 = month+1;}
            else {day1 = day+15;month1 = month;year1=year;}
            break;
        case 9: 
            if(day+15>30) {day1 = day+15-30;month1 = month+1;}
            else {day1 = day+15;month1 = month;year1=year;}
            break;
        case 10:
            if(day+15>31){day1 = day+15-31;month1 = month+1;}
            else{day1 = day+15;month1 = month;year1=year;}
            break;
        case 11:
            if(day+15>30) {day1 = day+15-30;month1 = month+1;}
            else {day1 = day+15;month1 = month;year1=year;}
            break;
        case 12:
            if(day+15>31) {day1 = day+15-31;month1 = 1;year1=year+1;}
            else {day1 = day+15;month1 = month;year1=year;}
            break;
    }
    
	itoa(year, results.BTime.year, 10);
	itoa(day, results.BTime.day, 10);
	itoa(month, results.BTime.month, 10);

	itoa(year, results.RTime.year, 10);
	itoa(day1, results.RTime.day, 10);
	itoa(month1, results.RTime.month, 10);

	return results;
}

//用户还书
void UserReturn() {
    FILE *fw;
	FILE *fp;
	static char input1[80] = "";
	static char input2[80] = "";
	static char results1[200] = "";
	static char results2[200] = "";
	static char ID[20] = "";//书籍编号
	static char Name[300] = "";//书名
	static char Author[20] = "";//作者，目前只实现了单一作者操作
	static char Publisher[30] = "";//出版社
	static char ReleaseDate[30];//出版日期
	static char BorrowDate[30];//出版日期
	static char Number[10];
	static int searchMode = 0;
	double fH = GetFontHeight();
	double h = fH * 2; // 控件高度
	double w = WinWidth / 4; // 控件宽度
	double x = 16 * fH;
	double y = WinWidth / 3 * 2 - 3.6 * fH;
	int num;
	BookMessageList ptr = New(BookMessageList);
	BorrowMessageList ptr2 = New(BorrowMessageList);
	UserMessageList ptr4 = New(UserMessageList);
	int num4;
	SetPenColor("Black");
	drawLabel(x - fH*1.5 - TextStringWidth("书名"), (y -= h * 1.5) + fH * 0.7, "用户ID");
	if (textbox(GenUIID(0), x, y, w, h, input1, sizeof(input1)))
		sprintf(results1, "%s", input1);
	else strcpy(results1, input1);

	SetPenColor("Black");
	drawLabel(x - fH*1.5 - TextStringWidth("书名"), (y -= h * 1.5) + fH * 0.7, "书名");
	if (textbox(GenUIID(0), x, y, w, h, input2, sizeof(input2)))
		sprintf(results2, "%s", input2);
	else strcpy(results2, input2);


	if (button(GenUIID(0), x + w + 0.5 * h, y, w / 2, h, "确认还书"))   searchMode = 1;
	if (searchMode) {
        if(strcmp(FileNameCur, "")==0){
            SetPenColor("Black");
            drawLabel( x , y-h,"管理员暂未开放借还书功能");
        }
        else{
            CreateUserList();
            CreateBookList(FileNameCur);
            ptr = SearchBook0(booklist, 2, results2);
            ptr4 = SearchUser(userlist, results1);
            if(ptr4==NULL){
                SetPenColor("Black");
                drawLabel( x + w + 0.5 * h, y-h,"用户不存在！");                
            }
            else if(ptr==NULL){
                SetPenColor("Black");
                drawLabel( x + w + 0.5 * h, y-h,"书籍不存在！");                     
            }
		    else {
                sprintf(ID, "书号：%s", ptr->ID);
                sprintf(Name, "书名：%s", ptr->Name);
                sprintf(Author, "作者：%s", ptr->Author);
                sprintf(Publisher, "出版社：%s", ptr->Publisher);
                sprintf(ReleaseDate, "出版日期：%s", ptr->ReleaseDate);
                num = atoi(ptr->Number);
                num++;
                itoa(num, ptr->Number, 10);//该书库存加一
                num4 = atoi(ptr4->BorrowTimeNow);
                num4--;
                itoa(num4, ptr4->BorrowTimeNow, 10);
			
                sprintf(Number, "%s", "还书成功！");
                UpdateBook(booklist,2 ,ptr);
                UpdateUser(userlist,1, ptr4);
                if((fw=fopen("borrow.txt", "r+"))!=NULL){
                    fclose(fw);
                    CreateBorrowList("borrow.txt");
                    ptr2 = SearchBR(borrowlist, results1, ptr->ID);
                    sprintf(BorrowDate, "借阅日期：%s", ptr2->BorrowDate);
                    if(ptr2!=NULL) DeleteBR(borrowlist, ptr2);
			    }
            }
		}
		searchMode = 0;
	}
	drawLabel(x, y - fH * 3, ID);
	drawLabel(x, y - fH * 6, Name);
	drawLabel(x, y - fH * 9, Author);
	drawLabel(x, y - fH * 12, Publisher);
	drawLabel(x, y - fH * 15, ReleaseDate);
	drawLabel(x, y - fH * 18, Number);
	drawLabel(x, y - fH * 21, BorrowDate);
}

//用户删除
void UserDelete() {
    static char input[80] = "";
    static char results[200] = "";
    static int DeleteMode = 0;
    UserMessageList ptr = New(UserMessageList);

    SetPenColor("Black");
    drawLabel(WinWidth / 3, WinHeight / 3 * 2, "请输入需要注销的用户ID");

    if (textbox(GenUIID(0), WinWidth / 3, WinHeight / 3 * 2 - 3 * GetFontHeight(), WinWidth / 4, 2 * GetFontHeight(), input, sizeof(input)))
        sprintf(results, "%s", input);
    else strcpy(results, input);
    if (button(GenUIID(0), WinWidth / 2, WinHeight / 3 * 2 - 6 * GetFontHeight(), WinWidth / 12, 2 * GetFontHeight(), "确定")) {
        DeleteMode = 1;
    }
    if (DeleteMode) {
        ptr = SearchUser(userlist, results);
        if (ptr != NULL) {
            DeleteUser(userlist, ptr);
        }
        SetPenColor("Black");
        drawLabel(WinWidth / 2, WinHeight / 3 * 2 - 9 * GetFontHeight(), "删除成功");
    }
    DeleteMode = 0;
}

//用户修改按钮
void UserUpdateButtons()
{
    double fH = GetFontHeight();
    double h = fH * 2;  // 控件高度
    double x = 0;
    double y = WinHeight / 15 * 11;
    double w = WinWidth / 9; // 控件宽度
    static int accordingToName = 0;
    static int accordingToGender = 0;
    static int accordingToWorkUnit = 0;

    if (button(GenUIID(0), x + 3 * h, y, w, h, "修改姓名")) {
        accordingToGender = 0;
        accordingToWorkUnit = 0;
        accordingToName = 1;
    }

    if (button(GenUIID(0), x + 3 * h, y - 1.5 * h, w, h, "修改性别")) {
        accordingToName = 0;
        accordingToWorkUnit = 0;
        accordingToGender = 1;
    }

    if (button(GenUIID(0), x + 3 * h, y - 3 * h, w, h, "修改工作单位")) {
        accordingToName = 0;
        accordingToGender = 0;
        accordingToWorkUnit = 1;
    }

    if (accordingToName)
        UserUpdate(1);

    if (accordingToGender)
        UserUpdate(2);

    if (accordingToWorkUnit)
        UserUpdate(3);
}

//用户修改
void UserUpdate(int n)
{
    FILE *fp;
    static char input[80] = "";//id号输入
    static char input2[80] = "";//新信息输入
    static char results[200] = "";
    static char results2[200] = "";
    static char ID[30] = "";//帐号
    static char Name[30] = "";//姓名
    static char Gender[20] = "";//性别
    static char WorkUnit[30] = "";//工作区域
    static int changeMode = 0;
    double fH = GetFontHeight();
    double h = fH * 2; // 控件高度
    double w = WinWidth / 4; // 控件宽度
    double x = WinWidth / 3 - 1.5 * h;
    double y = WinHeight / 15 * 11;
    UserMessageList ptr = New(UserMessageList);
    UserMessageList p = New(UserMessageList);
    ptr = NULL;
    p = NULL;

    SetPenColor("Black");
    drawLabel(x - fH / 2 - TextStringWidth("输入"), y + fH * 0.7, "用户ID");

    switch (n) {
    case 1: drawLabel(x - fH / 2 - TextStringWidth("书号"), y - 1.5 * h + fH * 0.7, "新姓名"); break;
    case 2: drawLabel(x - fH / 2 - TextStringWidth("书名"), y - 1.5 * h + fH * 0.7, "新性别"); break;
    case 3: drawLabel(x - fH / 2 - TextStringWidth("作者"), y - 1.5 * h + fH * 0.7, "新工作单位"); break;
    default: break;
    }

    if (textbox(GenUIID(0), x + TextStringWidth("输入新"), y, w, h, input, sizeof(input)))
        sprintf(results, "%s", input);
    else strcpy(results, input);

    if (textbox(GenUIID(0), x + TextStringWidth("输入新"), y - 1.5 * h, w, h, input2, sizeof(input2)))
        sprintf(results2, "%s", input2);
    else strcpy(results2, input2);


    if (button(GenUIID(0), x + w / 2 + TextStringWidth("输入新"), y - h * 3, w / 2, h, "确认")) {
        changeMode = 1;
    }

    if (changeMode) {
        if((fp=fopen("user.txt", "r+"))!=NULL){
			fclose(fp);
            CreateUserList();
            ptr = SearchUser(userlist, results);
            if (ptr == NULL) {
                SetPenColor("Black");
                drawLabel(x, y - fH * 8, "用户不存在！");
            }
            else {
                if (n == 1) {
                    strcpy(ptr->Name, results2);
                    p = UpdateUser(userlist, 2, ptr);
                }
                else if (n == 2) {
                    strcpy(ptr->Gender, results2);
                    p = UpdateUser(userlist, 2, ptr);
                }
                else if (n == 3) {
                    strcpy(ptr->WorkUnit, results2);
                    p = UpdateUser(userlist, 2, ptr);
                }
                sprintf(ID, "ID：%s", p->ID);
                sprintf(Name, "姓名：%s", p->Name);
                sprintf(Gender, "性别：%s", p->Gender);
                sprintf(WorkUnit, "工作单位：%s", p->WorkUnit);
            }
           
        }
        else {
            
            SetPenColor("Black");
            drawLabel(x, y - fH * 8, "用户不存在！");
        } 
        
        changeMode = 0;
    }

    y = y - fH * 6;
    drawLabel(x, y - fH * 2, ID);
    drawLabel(x, y - fH * 4, Name);
    drawLabel(x, y - fH * 6, Gender);
    drawLabel(x, y - fH * 8, WorkUnit);
}

//用户个人信息查看
void UserMessageShow(){
    FILE *fp,fq;
	static char input[80] = "";//id号输入
	static char results[200] = "";
	static char ID[30] = "";//帐号
	static char Name[30] = "";//姓名
	static char Gender[20] = "";//性别
	static char WorkUnit[30] = "";//工作区域
	static char Password[30] = "";//密码
	double fH = GetFontHeight();
	double h = fH * 2; // 控件高度
	double w = WinWidth / 4; // 控件宽度
	double x = WinWidth/3-1.5*h;
    double y = WinHeight/15*11;
	UserMessageList ptr = New(UserMessageList);
	UserMessageList p = New(UserMessageList);
	ptr = NULL;
	p = NULL;

	SetPenColor("Black");
	drawLabel(x-fH/2-TextStringWidth("输入"), y+fH*0.7, "用户ID");
	if (textbox(GenUIID(0), x+TextStringWidth("输入新"), y, w, h, input, sizeof(input)))
		sprintf(results, "%s", input);
	else strcpy(results, input);
	if (button(GenUIID(0), x + w*1.2 + TextStringWidth("输入新"), y, w/2, h, "确认")) {
        if((fp=fopen("user.txt", "r+"))==NULL){
            SetPenColor("Black");
            drawLabel(x, y - fH * 8, "用户不存在！");
        }
        else {
            fclose(fp);
            CreateUserList();
            ptr = SearchUser(userlist, results);
            if(ptr==NULL){
                SetPenColor("Black");
                drawLabel(x, y - fH * 8, "用户不存在！");
            }
            else {
                if((fp=fopen("borrow.txt", "r+"))!=NULL){
					fclose(fp);
                    CreateBorrowList();
                    SearchBR1(borrowlist, results);
                }
                strcpy(UserIDCur, results);
                ShowGUI=8;
            }
        }
	}
}

//用户查询
void UserShow(){
    FILE* fa = NULL;
	FILE *fb=NULL;
	double fH = GetFontHeight();
	double h = fH*2; // 控件高度
	double x = WinWidth/10;
	double y = WinHeight/15*12;
	static char ID[30] = "";//帐号
	static char Name[30] = "";//姓名
	static char Gender[20] = "";//性别
	static char WorkUnit[30] = "";//工作区域
	static char Password[30] = "";//密码
	static char BookName[30] = "";
	static char BorrowDate[30] = "";
	static char ReturnDue[30] = "";
	static int i=5;
	static char* line, * record;
	static char buffer[1024];
	static char* result = NULL;
	static int j = 0;

	SetPenColor("Black");
	drawLabel(x, y, "ID");
	drawLabel(x, y-h, "姓名");
	drawLabel(x, y-2*h, "性别");
	drawLabel(x, y-3*h, "工作单位");
	drawLabel(x, y-4*h, "已借阅");
	drawLabel(x+3*h, y-4*h, "借阅日期");
	drawLabel(x+6*h, y-4*h, "应还日期");
	drawMenuBar(0, WinHeight-fH*1.5, WinWidth, fH*1.5);//菜单栏
	drawMenuBar(0, 0, WinWidth, fH*3);//上一步操作显示栏


	if ((fa = fopen("user.txt", "r+")) != NULL)
	{
		fgets(buffer, sizeof(buffer), fa);//跳过第一行，第一行为表头，不需要输出
		while ((line = fgets(buffer, sizeof(buffer), fa)) != NULL)
		{
			record = strtok(line, "\t");//以制表符分割读入的整行数据
			while (record != NULL)
			{
				switch (j) {
				case 0:strcpy(ID, record); break;
				case 1:strcpy(Name, record); break;
				case 2:strcpy(Gender, record); break;
				case 3:strcpy(WorkUnit, record); break;
				case 4:break;
				case 5:break;
				default:break;
				}
				record = strtok(NULL, "\t");
				j++;
			}
			if(strcmp(ID, UserIDCur)==0)
				break;
			j = 0;
		}
		fclose(fa);
		fa = NULL;
	}

	SetPenColor("Black");
	drawLabel(x+3*h, y, ID);
	drawLabel(x+3*h, y-h, Name);
	drawLabel(x+3*h, y-2*h, Gender);
	drawLabel(x+3*h, y-3*h, WorkUnit);


	j=0;

	if ((fb = fopen("return2.txt", "r+")) != NULL)
	{
		fgets(buffer, sizeof(buffer), fb);
		while ((line = fgets(buffer, sizeof(buffer), fb)) != NULL){
			record = strtok(line, "\t");//以制表符分割读入的整行数据
			while (record != NULL)
			{
				switch (j) {
				case 0:strcpy(BookName, record); break;
				case 1:strcpy(BorrowDate, record); break;
				case 2:strcpy(ReturnDue, record); break;
				default:break;
				}
				record = strtok(NULL, "\t");
				j++;
			}
			SetPenColor("Black");
			drawLabel(x, y-i*h, BookName);
			drawLabel(x+3*h, y-i*h, BorrowDate);
			drawLabel(x+6*h, y-i*h, ReturnDue);
			i++;
			j = 0;
		}
		fclose(fb);
		fb= NULL;
	}
	i=5;

	if(button(GenUIID(0), WinWidth-WinWidth/12-fH, fH*4 , WinWidth/12, h, "返回")) {
		remove("return2.txt");
		switch(UserSearchMode){
			case 1:ShowGUI=4;break;
			case 2:ShowGUI=2;break;
			default:break;
		}
	}
}

//图书受欢迎排行榜
void sort0(){
	double fH = GetFontHeight();
	double h = fH*2; // 控件高度
	double x = WinWidth/8;
    double y = WinHeight/15*11;
	static int i=0;
	BookMessageList p=NULL, q=NULL, t=NULL, pre=NULL, head=NULL, tail=NULL, p2=NULL;
	head = booklist;

	while(head->next!=tail){
		pre = head;
		p = head->next;
		while(p->next!=tail){
			if(atoi(p->BorrowTime)<atoi(p->next->BorrowTime)){
				t = p->next;
				pre->next = p->next;
				p->next = p->next->next;
				pre->next->next = p;
				p = t;
			}
			p = p->next;
			pre = pre->next;
		}
		tail = p;
	}

	SetPenColor("Black");
    drawLabel(x, y, "图书编号");
    drawLabel(x+4*h, y, "书名");
    drawLabel(x+8*h, y, "累计借阅数量");

    y = y-h;

	p2 = booklist->next;
	while(p2!=NULL){
            drawLabel(x, y-i*h, p2->ID);
            drawLabel(x+4*h, y-i*h, p2->Name);
            drawLabel(x+8*h, y-i*h, p2->BorrowTime);
            i++;
			p2 = p2->next;
	}
    i=0;
}

//用户借阅排行榜
void sort1(){
	double fH = GetFontHeight();
	double h = fH*2;
	double x = WinWidth/12;
    double y = WinHeight/15*11;
	static int i=0;
	UserMessageList p=NULL, q=NULL, t=NULL, pre=NULL, head=NULL, tail=NULL, p2=NULL;
	head = userlist;

	while(head->next!=tail){
		pre = head;
		p = head->next;
		while(p->next!=tail){
			if(atoi(p->BorrowTimeAll)<atoi(p->next->BorrowTimeAll)){
				t = p->next;
				pre->next = p->next;
				p->next = p->next->next;
				pre->next->next = p;
				p = t;
			}
			p = p->next;
			pre = pre->next;
		}
		tail = p;
	}

	SetPenColor("Black");
    drawLabel(x, y, "用户ID");
    drawLabel(x+4*h, y, "姓名");
    drawLabel(x+8*h, y, "性别");
    drawLabel(x+12*h, y, "总借阅量");

    y = y-h;

	p2 = userlist->next;
	while(p2!=NULL){
            drawLabel(x, y-i*h, p2->ID);
            drawLabel(x+4*h, y-i*h, p2->Name);
            drawLabel(x+8*h, y-i*h, p2->Gender);
            drawLabel(x+12*h, y-i*h, p2->BorrowTimeAll);
            i++;
            p2 = p2->next;
	}
    i=0;
}

//图书名称排行
void sort2(){
	double fH = GetFontHeight();
	double h = fH*2; // 控件高度
	double x = WinWidth/12;
    double y = WinHeight/15*11;
	static int i=0;

	BookMessageList p=NULL, q=NULL, t=NULL, pre=NULL, head=NULL, tail=NULL, p2=NULL;
	head = booklist;

	while(head->next!=tail){
		pre = head;
		p = head->next;
		while(p->next!=tail){
			if((strcmp(p->Name, p->next->Name))>0){
				t = p->next;
				pre->next = p->next;
				p->next = p->next->next;
				pre->next->next = p;
				p = t;
			}
			p = p->next;
			pre = pre->next;
		}
		tail = p;
	}

	SetPenColor("Black");
    drawLabel(x, y, "图书编号");
    drawLabel(x+3*h, y, "书名");
    drawLabel(x+6*h, y, "作者");
    drawLabel(x+12*h, y, "关键字");
    drawLabel(x+18*h, y, "出版社");
    drawLabel(x+22*h, y, "出版日期");
    y = y-h;
	p2 = booklist->next;
	while(p2!=NULL){
        SetPenColor("Black");
        drawLabel(x, y-i*h, p2->ID);
        drawLabel(x+3*h, y-i*h, p2->Name);
        drawLabel(x+6*h, y-i*h, p2->Author);
        drawLabel(x+12*h, y-i*h, p2->KeyWord);
        drawLabel(x+18*h, y-i*h, p2->Publisher);
        drawLabel(x+22*h, y-i*h, p2->ReleaseDate);
        i++;
        p2=p2->next;
	}
    i=0;
}

//图书ID排行
void sort3(){
	double fH = GetFontHeight();
	double h = fH*2; // 控件高度
	double x = WinWidth/12;
    double y = WinHeight/15*11;
	static int i=0;
	BookMessageList p=NULL, q=NULL, t=NULL, pre=NULL, head=NULL, tail=NULL, p2=NULL;
	head = booklist;

	while(head->next!=tail){
		pre = head;
		p = head->next;
		while(p->next!=tail){
			if((strcmp(p->ID, p->next->ID))>0){
				t = p->next;
				pre->next = p->next;
				p->next = p->next->next;
				pre->next->next = p;
				p = t;
			}
			p = p->next;
			pre = pre->next;
		}
		tail = p;
	}
	SetPenColor("Black");
    drawLabel(x, y, "图书编号");
    drawLabel(x+3*h, y, "书名");
    drawLabel(x+6*h, y, "作者");
    drawLabel(x+12*h, y, "关键字");
    drawLabel(x+18*h, y, "出版社");
    drawLabel(x+22*h, y, "出版日期");
    y = y-h;
	p2 = booklist->next;
	while(p2!=NULL){
        SetPenColor("Black");
        drawLabel(x, y-i*h, p2->ID);
        drawLabel(x+3*h, y-i*h, p2->Name);
        drawLabel(x+6*h, y-i*h, p2->Author);
        drawLabel(x+12*h, y-i*h, p2->KeyWord);
        drawLabel(x+18*h, y-i*h, p2->Publisher);
        drawLabel(x+22*h, y-i*h, p2->ReleaseDate);
        i++;
        p2=p2->next;
	}
    i=0;
}

//用户姓名排序
void sort4(){
	double fH = GetFontHeight();
	double h = fH*2;
	double x = WinWidth/12;
    double y = WinHeight/15*11;
	static int i=0;

	UserMessageList p=NULL, q=NULL, t=NULL, pre=NULL, head=NULL, tail=NULL, p2=NULL;
	head = userlist;

	while(head->next!=tail){
		pre = head;
		p = head->next;
		while(p->next!=tail){
			if((strcmp(p->Name, p->next->Name))>0){
				t = p->next;
				pre->next = p->next;
				p->next = p->next->next;
				pre->next->next = p;
				p = t;
			}
			p = p->next;
			pre = pre->next;
		}
		tail = p;
	}
	SetPenColor("Black");
    drawLabel(x, y, "用户ID");
    drawLabel(x+4*h, y, "姓名");
    drawLabel(x+8*h, y, "性别");
    drawLabel(x+12*h, y, "工作单位");

    y = y-h;

	p2 = userlist->next;
	while(p2!=NULL){
        SetPenColor("Black");
        drawLabel(x, y-i*h, p2->ID);
        drawLabel(x+4*h, y-i*h, p2->Name);
        drawLabel(x+8*h, y-i*h, p2->Gender);
        drawLabel(x+12*h, y-i*h, p2->WorkUnit);
        i++;
        p2=p2->next;
	}
    i=0;
}

//用户ID排序
void sort5(){
	double fH = GetFontHeight();
	double h = fH*2;
	double x = WinWidth/12;
    double y = WinHeight/15*11;
	static int i=0;
	UserMessageList p=NULL, q=NULL, t=NULL, pre=NULL, head=NULL, tail=NULL, p2=NULL;
	head = userlist;

	while(head->next!=tail){
		pre = head;
		p = head->next;
		while(p->next!=tail){
			if((strcmp(p->ID, p->next->ID))>0){
				t = p->next;
				pre->next = p->next;
				p->next = p->next->next;
				pre->next->next = p;
				p = t;
			}
			p = p->next;
			pre = pre->next;
		}
		tail = p;
	}

	SetPenColor("Black");
    drawLabel(x, y, "用户ID");
    drawLabel(x+4*h, y, "姓名");
    drawLabel(x+8*h, y, "性别");
    drawLabel(x+12*h, y, "工作单位");

    y = y-h;

	p2 = userlist->next;
	while(p2!=NULL){
        SetPenColor("Black");
        drawLabel(x, y-i*h, p2->ID);
        drawLabel(x+4*h, y-i*h, p2->Name);
        drawLabel(x+8*h, y-i*h, p2->Gender);
        drawLabel(x+12*h, y-i*h, p2->WorkUnit);
        i++;
        p2=p2->next;
	}
    i=0;
}

void DrawShowAbout() {
    double fH = GetFontHeight();//字高
    double w = WinWidth / 9;//控件宽度
    double h = fH * 2;//文本框高度
    double x = WinWidth / 5 * 2;
    double y = WinHeight / 5 * 3;
    SetPenColor("Black");
    drawLabel(x - 12 * fH, y + 3 * fH, "本软件名称为图书管理系统，为2020年浙江大学程序设计专题课程大作业。");
    drawLabel(x - 14 * fH, y + 1.5 * fH, "本软件分为多个界面，首先打开程序将进入主界面，在主界面可以选择进入游");
    drawLabel(x - 14 * fH, y, "客、用户、管理员三个界面。在游客界面中，可以进行图书查询，以及查看最");
    drawLabel(x - 14 * fH, y - 1.5 * fH, "受欢迎图书。在用户界面中，可以注册帐号、修改个人信息、查询图书、借还");
    drawLabel(x - 14 * fH, y - 3 * fH, "书。在管理员界面中，可以对文件进行操作，可以修改、新增、删除图书，可");
    drawLabel(x - 14 * fH, y - 4.5 * fH, "以查询用户信息，可以进行排序操作，可以看用户的借书排行榜以及书本被借");
    drawLabel(x - 14 * fH, y - 6 * fH, "次数的排行榜。");
}

void DrawShowUseWay() {
    double fH = GetFontHeight();//字高
    double w = WinWidth / 9;//控件宽度
    double h = fH * 2;//文本框高度
    double x = WinWidth / 5 * 2;
    double y = WinHeight / 5 * 3;
    SetPenColor("Black");
    drawLabel(x - 14 * fH, y + 3 * fH, "注意事项1：本软件必须由管理员打开图书库文件后才能进行操作。");
    drawLabel(x - 14 * fH, y + 1.5 * fH, "注意事项2：管理员登陆账号密码已预设，必须填写正确才可以通过管理员界面登录。");
    drawLabel(x - 14 * fH, y, "注意事项3：用户注册时需注意编号必须为十位数，否则会造成注册失败。");
    drawLabel(x - 14 * fH, y - 1.5 * fH, "注意事项4：新增图书时需注意编号必须为八位数，否则会造成增加失败。");
    drawLabel(x - 14 * fH, y - 3 * fH, "注意事项4：每位用户最多可同时借阅两本图书。");
    drawLabel(x - 14 * fH, y - 4.5 * fH, "注意事项5：当图书馆内无库存时，该书将不会被借出。");
}