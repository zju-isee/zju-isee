
/*****************************************************************************  
*   编写时间： 2011.07.07
*   作    者： 雁翎电子
*	版    本： V1.0
*   函数功能： 无源蜂鸣器测试-世上只有妈妈好			   			            
*   使用说明： 
******************************************************************************/   
#include <reg52.h>   
#define uchar unsigned char 
sbit      beep=P0^4;  	//定义蜂鸣器输出端口
uchar timer0h,timer0l,time;

                         //世上只有妈妈好  数据表
code uchar sszymmh[]={6,2,3,5,2,1,3,2,2,5,2,2,1,3,2,6,2,1,5,2,1,
                      6,2,4,3,2,2,5,2,1,6,2,1,5,2,2,3,2,2,1,2,1,
                      6,1,1,5,2,1,3,2,1,2,2,4,2,2,3,3,2,1,5,2,2,
                      5,2,1,6,2,1,3,2,2,2,2,2,1,2,4,5,2,3,3,2,1,
                      2,2,1,1,2,1,6,1,1,1,2,1,5,1,6,0,0,0 
                                      };
                         // 音阶频率表 高八位
code uchar FREQH[]={0xF2,0xF3,0xF5,0xF5,0xF6,0xF7,0xF8, 
                    0xF9,0xF9,0xFA,0xFA,0xFB,0xFB,0xFC,0xFC, //1,2,3,4,5,6,7,8,i
                    0xFC,0xFD,0xFD,0xFD,0xFD,0xFE,
                    0xFE,0xFE,0xFE,0xFE,0xFE,0xFE,0xFF,} ;
                         // 音阶频率表 低八位
code uchar FREQL[]={0x42,0xC1,0x17,0xB6,0xD0,0xD1,0xB6,
                    0x21,0xE1,0x8C,0xD8,0x68,0xE9,0x5B,0x8F, //1,2,3,4,5,6,7,8,i
                    0xEE,0x44, 0x6B,0xB4,0xF4,0x2D, 
                    0x47,0x77,0xA2,0xB6,0xDA,0xFA,0x16,};
void delay(uchar t)		  // 延时函数 
{
	uchar t1;
	unsigned long t2;
	for(t1=0;t1<t;t1++)
	{
		for(t2=0;t2<8000;t2++);
	}
	TR0=0;
}
void song()				 //  音乐处理函数
{
	TH0=timer0h;
	TL0=timer0l;
	TR0=1;
	delay(time);                       
}
/******************************************************************
                  			主函数                                      
******************************************************************/
void main(void)
{
	uchar k,i;
	TMOD=1; 			//置CT0定时工作方式1
	EA=1;
	ET0=1;				//IE=0x82 //CPU开中断,CT0开中断 
	while(1)
	{
		i=0;  
		while(i<100)				  //音乐数组长度 ，唱完从头再来  
		{              
			k=sszymmh[i]+7*sszymmh[i+1]-1;
			timer0h=FREQH[k];
			timer0l=FREQL[k];
			time=sszymmh[i+2];
			i=i+3;
			song();
		}
	} 
}
void t0int() interrupt 1		//定时器中断函数
{
	TR0=0;
	beep=!beep;
	TH0=timer0h;
	TL0=timer0l;
	TR0=1;
}