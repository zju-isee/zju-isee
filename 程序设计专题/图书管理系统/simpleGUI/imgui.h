//===========================================================================
//
//  版权所有者： 刘新国，浙江大学计算机科学与技术学院
//                       CAD&CG国家重点实验室
//               xgliu@cad.zju.edu.cn
//  最近修改：2019年2月28日 
//            添加了控件的颜色和填充的设置，
//            以及设置颜色的例子（在函数demoGuiALL.c的drawButtons函数里）
//  最近修改：2019年2月26日 
//            添加了演示文本编辑演示
//            添加了动画演示
//            添加了textbox 文本输入控件
//            简化了菜单处理
//            改 uiGetInput 为 uiGetMouse,uiGetKey,uiGetKeyboard
//  最近修改：2019年2月18日
//  初次创建：2018年4月，用于<<程序设计专题>>课程教学
//
//===========================================================================

#ifndef ____ui_button_h______
#define ____ui_button_h______


//===========================================================================
//
//   [L:16-1][N:16-1]
//        XOR
//   [F:32 --------1]
// 
// Generate a *fake* unique ID for gui controls at compiling/run time
//
#define GenUIID(N) ( ((__LINE__<<16) | ( N & 0xFFFF))^((long)&__FILE__) )
//
// GenUIID(0) will give a unique ID at each source code line. 
// If you need one UI ID per line, just call GenUIID with 0
//
//               GenUIID(0)
//
// But, two GenUIID(0) calls at the same line will give the same ID.
//
// So, in a while/for loop body, GenUIID(0) will give you the same ID.
// In this case, you need call GenUIID with different N parameter: 
//
//               GenUIID(N)
//
//===========================================================================

/* 函数名：	InitGUI
 *
 * 功能：初始化工作
 *
 * 用法：在窗口创建或字体设置之后调用
 */
void InitGUI();

/* 函数名：	uiGetMouse
 *			uiGetKeyboard
 *			uiGetChar
 *
 * 功能：获得用户的鼠标/键盘/文本的输入
 *
 * 用法：在鼠标/键盘/文本输入的回调函数中使用 
 *
 *		void MouseEventProcess(int x, int y, int button, int event)
 *		{
 *			uiGetMouse(x,y,button,event); 
 *			...其他代码...
 *		}
 *
 *		void KeyboardEventProcess(int key, int event)
 *		{
 *			uiGetKeyboard(key,event); 
 *			...其他代码...
 *		}
 *
 *		void CharEventProcess(char ch)
 *		{
 *			uiGetChar(ch); 
 *			...其他代码...
 *		}
 */
void uiGetMouse(int x, int y, int button, int event);
void uiGetKeyboard(int key, int event);
void uiGetChar(int ch);


/* 
 * 函数名：button
 *
 * 功能：显示一个按钮（button）
 *
 * 用法：if( button(GenUUID(0),x,y,w,h,label) ) {
 *           执行语句，响应用户按下该按钮
 *       }
 *
 *   id  - 唯一号
 *   x,y - 位置
 *   w,h - 宽度和高度
 *   label - 按钮上的文字标签
 *
 * 返回值
 *   0 - 用户没有点击（按下并释放）按钮  
 *   1 - 点击了按钮
 */
int button(int id, double x, double y, double w, double h, char *label);


/* 
 * 函数名：menuList
 *
 * 功能：显示一组菜单
 *
 * 用法：choice = menuList(GenUUID(0),x,y,w,h,labels,n);
 *
 *   id  - 菜单的唯一号
 *   x,y - 菜单的位置
 *   w,h - 菜单项的大小
 *   wlist - 菜单列表的宽度
 *   labels[] - 标签文字，[0]是菜单类别，[1...n-1]是菜单列表
 *   n   - 菜单项的个数
 *
 * 返回值
 *   -1    - 用户没有点击（按下并释放）按钮  
 *   >=0   - 用户选中的菜单项 index （在labels[]中）
 *
 * 应用举例：

	char * menuListFile[] = {"File",  
		"Open  | Ctrl-O",  // 快捷键必须采用[Ctrl-X]格式，放在字符串的结尾
		"Close",           
		"Exit   | Ctrl-E"};// 快捷键必须采用[Ctrl-X]格式，放在字符串的结尾

	int selection;

	selection = menuList(GenUIID(0), x, y, w, wlist, h, menuListFile, sizeof(menuListFile)/sizeof(menuListFile[0]));

	if( selection==3 )
		exit(-1); // user choose to exit

 */
int  menuList(int id, double x, double y, double w, double wlist, double h, char *labels[], int n);
// 用菜单的颜色，画一个矩形，位置(x,y),宽高(w,h)
// 一般 w 等于窗口的宽度，h 和菜单项的高度匹配
void drawMenuBar(double x, double y, double w, double h); 

/* 
 * 函数名：textbox
 *
 * 功能：显示一个文本编辑框，显示和编辑文本字符串
 *
 * 用法：textbox(GenUUID(0),x,y,w,h,textbuf,buflen);
 *       或者
         if( textbox(GenUUID(0),x,y,w,h,textbuf,buflen) ) {
 *           文本字符串被编辑修改了，执行相应语句
 *       }
 *
 *   id  - 唯一号，一般用GenUUID(0), 或用GenUUID（k)（k是循环变量）
 *   x,y - 文本框位置
 *   w,h - 文本框的宽度和高度
 *   textbuf - 被编辑的文本字符串（以\0结尾）
 *   buflen - 可存储的文本字符串的最大长度
 * 返回值
 *   0 - 文本没有被编辑
 *   1 - 被编辑了
 */
int textbox(int id, double x, double y, double w, double h, char textbuf[], int buflen);

/*
 * 设置控件的颜色
 *  
 * 函数和功能
 *      setButtonColors   - 设置按钮颜色
 *      setMenuColors     - 设置菜单颜色
 *      setTextBoxColors  - 设置编辑框颜色    
 * 参数
 *      frame/label       - 控件框/文字标签的颜色
 *      hotFrame/hotLabel - 鼠标划过时，控件框/文字标签的颜色
 *      fillflag          - 是否填充背景。0 - 不填充，1 - 填充
 * 说明
 *      当某个颜色字符串为空时，对应的颜色不做设置
 */
void setButtonColors (char *frame, char*label, char *hotFrame, char *hotLabel, int fillflag);
void setMenuColors   (char *frame, char*label, char *hotFrame, char *hotLabel, int fillflag);
void setTextBoxColors(char *frame, char*label, char *hotFrame, char *hotLabel, int fillflag);

// 使用预定义的颜色组合
void usePredefinedColors(int k);
void usePredefinedButtonColors(int k);
void usePredefinedMenuColors(int k);
void usePredefinedTexBoxColors(int k);


/* 显示字符串标签 */
void drawLabel(double x, double y, char *label);

/* 画一个矩形 */
void drawRectangle(double x, double y, double w, double h, int fillflag);

/* 显示带字符串标签的矩形
 * 
 * xalignment - 标签和矩形的对齐方式
 *              'L' - 靠左
 *			    'R' - 靠右
 *              其他- 居中
 *
 * fillflag - 1 填充
 *            0 不填充
 */
void drawBox(double x, double y, double w, double h, int fillflag, char *label, char xalignment, char *labelColor);

#endif // define ____ui_button_h______
