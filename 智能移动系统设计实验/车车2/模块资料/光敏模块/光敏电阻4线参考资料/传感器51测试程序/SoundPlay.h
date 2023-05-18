/**************************************************************************
   
     					SOUND PLAY FOR 51MCU
  
               		COPYRIGHT (c)   2005 BY JJJ.
                       		--  ALL RIGHTS RESERVED  --
  
   File Name:       SoundPlay.h
   Author:          Jiang Jian Jun
   Created:         2005/5/16
   Modified:		NO
   Revision: 		1.0
  
*******************************************************************************/

/*说明**************************************************************************
 曲谱存贮格式 unsigned char code MusicName{音高，音长，音高，音长...., 0,0};	末尾:0,0 表示结束(Important)

 音高由三位数字组成：
 		个位是表示 1~7 这七个音符 
 		十位是表示音符所在的音区:1-低音，2-中音，3-高音;
 		百位表示这个音符是否要升半音: 0-不升，1-升半音。
 
 音长最多由三位数字组成： 
 		个位表示音符的时值，其对应关系是： 
 			|数值(n):  |0 |1 |2 |3 | 4 | 5 | 6 
 			|几分音符: |1 |2 |4 |8 |16 |32 |64 		音符=2^n
 		十位表示音符的演奏效果(0-2):  0-普通，1-连音，2-顿音
 		百位是符点位: 0-无符点，1-有符点

 调用演奏子程序的格式
 		Play(乐曲名,调号,升降八度,演奏速度);
	|乐曲名           : 要播放的乐曲指针,结尾以(0,0)结束;
	|调号(0-11)       :	是指乐曲升多少个半音演奏;
	|升降八度(1-3)	  : 1:降八度, 2:不升不降, 3:升八度;
	|演奏速度(1-12000):	值越大速度越快;

***************************************************************************/
#ifndef __SOUNDPLAY_H_REVISION_FIRST__
#define __SOUNDPLAY_H_REVISION_FIRST__

//**************************************************************************

#define SYSTEM_OSC 		12000000	//定义晶振频率12000000HZ
#define SOUND_SPACE 	4/5 		//定义普通音符演奏的长度分率,//每4分音符间隔
sbit    BeepIO    =   	P3^7;		//定义输出管脚

unsigned int  code FreTab[12]  = { 262,277,294,311,330,349,369,392,415,440,466,494 }; //原始频率表
unsigned char code SignTab[7]  = { 0,2,4,5,7,9,11 }; 								  //1~7在频率表中的位置
unsigned char code LengthTab[7]= { 1,2,4,8,16,32,64 };						
unsigned char Sound_Temp_TH0,Sound_Temp_TL0;	//音符定时器初值暂存 
unsigned char Sound_Temp_TH1,Sound_Temp_TL1;	//音长定时器初值暂存
//**************************************************************************
void InitialSound(void)
{
	BeepIO = 0;
	Sound_Temp_TH1 = (65535-(1/1200)*SYSTEM_OSC)/256;	// 计算TL1应装入的初值 	(10ms的初装值)
	Sound_Temp_TL1 = (65535-(1/1200)*SYSTEM_OSC)%256;	// 计算TH1应装入的初值 
	TH1 = Sound_Temp_TH1;
	TL1 = Sound_Temp_TL1;
	TMOD  |= 0x11;
	ET0    = 1;
	ET1	   = 0;
	TR0	   = 0;
	TR1    = 0;
	EA     = 1;
}

void BeepTimer0(void) interrupt 1	//音符发生中断
{
	BeepIO = !BeepIO;
	TH0    = Sound_Temp_TH0;
 	TL0    = Sound_Temp_TL0;
}
//**************************************************************************
void Play(unsigned char *Sound,unsigned char Signature,unsigned Octachord,unsigned int Speed)
{
	unsigned int NewFreTab[12];		//新的频率表
	unsigned char i,j;
	unsigned int Point,LDiv,LDiv0,LDiv1,LDiv2,LDiv4,CurrentFre,Temp_T,SoundLength;
	unsigned char Tone,Length,SL,SH,SM,SLen,XG,FD;
	for(i=0;i<12;i++) 				// 根据调号及升降八度来生成新的频率表 
	{
		j = i + Signature;
		if(j > 11)
		{
			j = j-12;
			NewFreTab[i] = FreTab[j]*2;
		}
		else
			NewFreTab[i] = FreTab[j];

		if(Octachord == 1)
			NewFreTab[i]>>=2;
		else if(Octachord == 3)
			NewFreTab[i]<<=2;
	}									
	
	SoundLength = 0;
	while(Sound[SoundLength] != 0x00)	//计算歌曲长度
	{
		SoundLength+=2;
	}

	Point = 0;
	Tone   = Sound[Point];	
	Length = Sound[Point+1]; 			// 读出第一个音符和它时时值
	
	LDiv0 = 12000/Speed;				// 算出1分音符的长度(几个10ms) 	
	LDiv4 = LDiv0/4; 					// 算出4分音符的长度 
	LDiv4 = LDiv4-LDiv4*SOUND_SPACE; 	// 普通音最长间隔标准 
	TR0	  = 0;
	TR1   = 1;
	while(Point < SoundLength)
	{
		SL=Tone%10; 								//计算出音符 
		SM=Tone/10%10; 								//计算出高低音 
		SH=Tone/100; 								//计算出是否升半 
		CurrentFre = NewFreTab[SignTab[SL-1]+SH]; 	//查出对应音符的频率 	
		if(SL!=0)
		{
			if (SM==1) CurrentFre >>= 2; 		//低音 
			if (SM==3) CurrentFre <<= 2; 		//高音
			Temp_T = 65536-(50000/CurrentFre)*10/(12000000/SYSTEM_OSC);//计算计数器初值
			Sound_Temp_TH0 = Temp_T/256; 
			Sound_Temp_TL0 = Temp_T%256; 
			TH0 = Sound_Temp_TH0;  
			TL0 = Sound_Temp_TL0 + 12; //加12是对中断延时的补偿 
		}
		SLen=LengthTab[Length%10]; 	//算出是几分音符
		XG=Length/10%10; 			//算出音符类型(0普通1连音2顿音) 
		FD=Length/100;
		LDiv=LDiv0/SLen; 			//算出连音音符演奏的长度(多少个10ms)
		if (FD==1) 
			LDiv=LDiv+LDiv/2;
		if(XG!=1)	
			if(XG==0) 				//算出普通音符的演奏长度 
				if (SLen<=4)	
					LDiv1=LDiv-LDiv4;
				else
					LDiv1=LDiv*SOUND_SPACE;
			else
				LDiv1=LDiv/2; 		//算出顿音的演奏长度 
		else
			LDiv1=LDiv;
		if(SL==0) LDiv1=0;
			LDiv2=LDiv-LDiv1; 		//算出不发音的长度 
	  	if (SL!=0)
		{
			TR0=1;
			for(i=LDiv1;i>0;i--) 	//发规定长度的音 
			{
				while(TF1==0);
				TH1 = Sound_Temp_TH1;
				TL1 = Sound_Temp_TL1;
				TF1=0;
			}
		}
		if(LDiv2!=0)
		{
			TR0=0; BeepIO=0;
			for(i=LDiv2;i>0;i--) 	//音符间的间隔
			{
				while(TF1==0);
				TH1 = Sound_Temp_TH1;
				TL1 = Sound_Temp_TL1;
				TF1=0;
			}
		}
		Point+=2; 
		Tone=Sound[Point];
		Length=Sound[Point+1];
	}
	BeepIO = 0;
}
//**************************************************************************
#endif