/******************************************************************************************
程序名：检查小车行使距离-LCD1602
编写人：Yayi
论坛：rtrobot.org　　　                                                
/******************************************************************************************/

#include <STC12C5A60S2.H>//头文件
#include <LCD1602.h>

sbit IN1=P1^0;
sbit IN2=P1^1;
sbit IN3=P1^2;
sbit IN4=P1^3;

unsigned int motor1=0;	 //计左电机码盘脉冲值
unsigned int motor2=0;	 //计右电机码盘脉冲值

void Forward(void)
{
        IN1=1;
        IN2=0;
        IN3=0;
        IN4=1;
}

/*********************************************************************************************
外部中断INT0、INT1初始化函数
/********************************************************************************************/
void INT_init (void)
{
	EA = 1;			//中断总开关  
	EX0 = 1; 		//允许外部中断0中断
	IT0 = 1; 		//1：下沿触发  0：低电平触发
	EX1 = 1;
	IT1	= 1;
}

/*********************************************************************************************
主程序
/********************************************************************************************/
void main(void)
{		
	LCD1602_Init();
	LCD1602_Frist();
	INT_init();
	Forward();
	while (1)
	{
		print(line_one,1,'M');
		print(line_one,2,'o');
		print(line_one,3,'t');
		print(line_one,4,'o');
		print(line_one,5,'r');
		print(line_one,6,'1');
		print(line_one,7,':');
		print(line_one,8,motor1/1000+0x30);
		print(line_one,9,motor1/100%10+0x30);
		print(line_one,10,motor1/10%10+0x30);
		print(line_one,11,motor1%10+0x30);
		print(line_one,12,'C');
		print(line_one,13,'M');

		print(line_two,1,'M');
		print(line_two,2,'o');
		print(line_two,3,'t');
		print(line_two,4,'o');
		print(line_two,5,'r');
		print(line_two,6,'2');
		print(line_two,7,':');
		print(line_two,8,motor2/1000+0x30);
		print(line_two,9,motor2/100%10+0x30);
		print(line_two,10,motor2/10%10+0x30);
		print(line_two,11,motor2%10+0x30);
		print(line_two,12,'C');
		print(line_two,13,'M');
		DELAY_MS(250);
		LCD1602_WriteCMD(CMD_clear);
		}
}

/*********************************************************************************************
外部中断INT0计算电机1的脉冲
/********************************************************************************************/
void intersvr1(void) interrupt 0 using 1
{
	motor1++;	
	if(motor1>=9999)
		motor1=0;	
}
/*********************************************************************************************
外部中断INT1计算电机2的脉冲
/********************************************************************************************/
void intersvr2(void) interrupt 2 using 3
{
	motor2++;
	if(motor2>=9999)
		motor2=0;
}