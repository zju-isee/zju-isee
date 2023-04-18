#define __DEBUG__//条件编译

#include <SoftwareSerial.h>
#include <TaskScheduler.h>
SoftwareSerial BT(4,5);
//_________________________________________________________________________
                                                                           //
const int Buzzer = 7; //定义蜂鸣器接口                                      //
                                                                           //
const int Left_motor_back=8;     //左电机后退(IN1)                          //
const int Left_motor_go=9;     //左电机前进(IN2)                            //
const int Right_motor_go=10;    // 右电机前进(IN3)                          //
const int Right_motor_back=11;    // 右电机后退(IN4)                        //
                                                                           //
const int forward_led=6;//前灯                                             //
const int l_led=13;//左灯                                                  //
const int r_led=12;//右灯                                                  //
                                                                           //
const int r_wheel=2;//右轮转速                                             //
const int l_wheel=3;//左轮转速                                             //
                                                                           //
const int light_sensor=A1;//光照传感                                       //
const int temp_sensor=A2;//温度传感                                        //
//——————————————————————————————————————————————————————————————————————————

int isMusicPlay=0;//music是否播放的flag
int whichMusic=1;
char command;
String State;

unsigned int motor1=0;   //计左电机码盘脉冲值
unsigned int motor2=0;   //计右电机码盘脉冲值
unsigned int speed1=0;   //计左电机速度值
unsigned int speed2=0;   //计右电机速度值

//__________________________________乐________曲__________________________
#define none 0

#define L1 262
#define L2 294
#define L3 330
#define L4 349   //低
#define L5 392
#define L6 440
#define L7 494

#define M1 523
#define M2 587
#define M3 659
#define M4 698    //中
#define M5 784
#define M6 880
#define M7 988

#define H1 1046
#define H2 1109
#define H3 1318
#define H4 1397   //高
#define H5 1568
#define H6 1760
#define H7 1976
int note=0;
int lenth1;
//频谱
int music1[] = {
  L5, M1, M2,
  M3, M5, M5, M6, M5, M3, M2, M1, M1, M2,
  M3, M3, M2, M1, M2, none, M2, M1,
  M3, M5, M5, M6, M5, M3, M2, M1, M1, M2,
  M3, M3, M2, M2, M1, none,
  M4, M4, M5, M6, M6,
  M5, M5, M3, M1, M2, none, M1, M2,
  M3, M5, M5, M6, M5, M3, M2, M1, M1, M2,
  M3, M3, M2, M2, M1, M1
};
//节拍
float music1_delay[] = {
  0.5, 0.25, 0.25,
  0.5, 0.5, 0.75, 0.25, 0.5, 0.25, 0.25, 0.5, 0.25, 0.25,
  0.5, 0.5, 0.5, 0.5, 1, 0.5, 0.25, 0.25,
  0.5, 0.5, 0.75, 0.25, 0.5, 0.25, 0.25, 0.5, 0.25, 0.25,
  0.5, 0.5, 0.5, 0.5, 1, 1,
  1, 0.5, 0.5, 1, 1,
  0.5, 0.5, 0.5, 0.5, 1, 0.5, 0.25, 0.25,
  0.5, 0.5, 0.5, 0.5, 0.5, 0.25, 0.25, 0.5, 0.25, 0.25,
  0.5, 0.5, 0.5, 0.25, 0.25, 1
};
//_________________________________________________________________________


//================================任-务-日-程==============================
void UpdateState()
{
  //Serial.println("======ask for commmand");
  if(BT.available())
  {
      command= BT.read();
      Serial.print("Bluetooth received=");
      Serial.println(command);
      switch(command)
      {
        case 'b':
          isMusicPlay=1;
          break;
        case 'z':
          isMusicPlay=0;
          break;
        case 'n':
          break;
        default:
          break;
      }
  }
  
}

void UploadState()
{
    float temp=analogRead(temp_sensor)*500.0/1024.0;
    int speed_av,len;
    len=State.length();
    
    BT.print(len);
    BT.print(State);
    
    BT.print()
    Serial.println("message Send");
    Serial.print("message lenth");
    Serial.println(len);
  
}
Task Control(10,TASK_FOREVER,&UpdateState);
Task Upload(100,TASK_FOREVER,&UploadState);
Scheduler Sch;
//===============================蓝-牙-初-始-化==================================
/*int BT_init()
{

  if(!BT.available())
  {
    Serial.println("Not Available!");
    return 0;
    }
  BT.print("AT");
  if(strcmp(BT.read(),"OK"))
  {
     BT.print("AT+NAMEhaha");
     if(strcmp(BT.read(),"haha"))
     {
      Serial.println("Name Reset success");
      return 1;
     }
     else
     {
      Serial.println("Name Reset Failed");
      return 0;
     }
        
  }
  else
    return 0;
  
}*/

//==============================主======程=======序==========================
void setup()
{
  BT.begin(9600);//启动软件串口
  Serial.begin(9600);
  
  pinMode(Left_motor_go,OUTPUT); // PIN 8 (PWM)
  pinMode(Left_motor_back,OUTPUT); // PIN 9 (PWM)
  pinMode(Right_motor_go,OUTPUT);// PIN 10 (PWM) 
  pinMode(Right_motor_back,OUTPUT);// PIN 11 (PWM)
  
  pinMode(Buzzer,OUTPUT); // PIN 6 (PWM)

  lenth1=sizeof(music1) / sizeof(music1[0]);
  /*while(1)
  {
    if(!BT_init())
    {
      
      tone(Buzzer,H1);
      delay(50);
      noTone(Buzzer);
      tone(Buzzer,H1);
      delay(50); 
      noTone(Buzzer);
      delay(1000);
      continue;
    }
    else
      break;
  }*/
  Sch.init();
  Sch.addTask(Control);
  Sch.addTask(Upload);
  Control.enable();
  Upload.enable();

  attachInterrupt(0,left_motor, RISING);  //D2对应左轮
  attachInterrupt(1,right_motor,RISING);  //D3对应右轮
  MsTimer2::set(1000, flash);  // 中断设置函数，每 500ms 进入一次中断
  MsTimer2::start();    //开始计时
}

void loop()
{
  Sch.execute();
  switch (command)
  {
    case 'w':
      digitalWrite(7,LOW);
      forward(10);//前进1s
      break;
    case 'x':
      back(10); //后退1s
      break;
    case 'a':
      left(10); //向左转1s
      break;
    case 'd':
      right(10);//向右转1s
      break;
    case 'q':
      spinLeft(0.7);
      break;
    case 'e':
      spinRight(0.7);
      break;
    case 's':
      brake(5);//停车
      break;
  }
  /*Serial.print("isMusicPlay=");
  Serial.println(isMusicPlay);*/
  
  if(isMusicPlay==1)
  {
    playMusic1();
    }
    
  

  
}
//================================音-乐-播-放================================

  
void playMusic1()
{
  
  tone(Buzzer, music1[note]);   //驱动蜂鸣器
  delay(music1_delay[note] * 500); //节拍实现
  noTone(Buzzer);   //停止蜂鸣器
  
  note=note+1;
  if(note==lenth1)  note=0;
  
}

//================================运-动-控-制===============================-

void forward(int time)     // 前进
{
  #ifndef __DEBUG__
  analogWrite(Right_motor_go,130);//PWM比例0~255调速，左右轮差异略增减
  analogWrite(Right_motor_back,0);
  analogWrite(Left_motor_go,110);//PWM比例0~255调速，左右轮差异略增减
  analogWrite(Left_motor_back,0);
  delay(time * 100);   //执行时间，可以调整  
  #else
  int forward_music[3]={M1,M2,M3};
  for(int i=0;i<3;i++)
  {
    tone(Buzzer,forward_music[i]);
    delay(200);
    noTone(Buzzer);
  }
  #endif
  
}
void brake(int time)         //刹车，停车
{
  #ifndef __DEBUG__
  digitalWrite(Right_motor_go,LOW);
  digitalWrite(Right_motor_back,LOW);
  digitalWrite(Left_motor_go,LOW);
  digitalWrite(Left_motor_back,LOW);
  delay(time * 100);//执行时间，可以调整  
  #else
  int brake_music[3]={M3,M2,M1};
  for(int i=0;i<3;i++)
  {
    tone(Buzzer,brake_music[i]);
    delay(200);
    noTone(Buzzer);
  }
  #endif
}
void left(int time)         //左转(左轮不动，右轮前进)
{
  #ifndef __DEBUG__
  analogWrite(Right_motor_go,90); 
  analogWrite(Right_motor_back,0);//PWM比例0~255调速
  analogWrite(Left_motor_go,0); 
  analogWrite(Left_motor_back,0);//PWM比例0~255调速
  delay(time * 100);  //执行时间，可以调整  
  #else
  int left_music[1]={L1};
  for(int i=0;i<1;i++)
  {
    tone(Buzzer,left_music[i]);
    delay(200);
    noTone(Buzzer);
  }
  #endif
}
void spinLeft(int time)         //左转(左轮后退，右轮前进)
{
  #ifndef __DEBUG__
  analogWrite(Right_motor_go,200); 
  analogWrite(Right_motor_back,0);//PWM比例0~255调速
  analogWrite(Left_motor_go,0); 
  analogWrite(Left_motor_back,200);//PWM比例0~255调速
  delay(time * 100);  //执行时间，可以调整  
  #else
  int spinl_music[3]={L1,L1,L1};
  for(int i=0;i<3;i++)
  {
    tone(Buzzer,spinl_music[i]);
    delay(200);
    noTone(Buzzer);
  }
  #endif
}
void right(int time)        //右转(右轮不动，左轮前进)
{
  #ifndef __DEBUG__
  analogWrite(Right_motor_go,0); 
  analogWrite(Right_motor_back,0);//PWM比例0~255调速
  analogWrite(Left_motor_go,90); 
  analogWrite(Left_motor_back,0);//PWM比例0~255调速
  delay(time * 100);  //执行时间，可以调整  
  #else
  int right_music[1]={H7};
  for(int i=0;i<1;i++)
  {
    tone(Buzzer,right_music[i]);
    delay(200);
    noTone(Buzzer);
  }
  #endif
}
void spinRight(int time)        //右转(右轮后退，左轮前进)
{
  #ifndef __DEBUG__
  analogWrite(Right_motor_go,0); 
  analogWrite(Right_motor_back,200);//PWM比例0~255调速
  analogWrite(Left_motor_go,200); 
  analogWrite(Left_motor_back,0);//PWM比例0~255调速
  delay(time * 100);  //执行时间，可以调整
   #else
  int spinr_music[3]={H7,H7,H7};
  for(int i=0;i<3;i++)
  {
    tone(Buzzer,spinr_music[i]);
    delay(200);
    noTone(Buzzer);
  }
  #endif  
}
void back(int time)          //后退
{
  #ifndef __DEBUG__
  analogWrite(Right_motor_go,0);
  analogWrite(Right_motor_back,150);//PWM比例0~255调速
  analogWrite(Left_motor_go,0);
  analogWrite(Left_motor_back,150);//PWM比例0~255调速
  delay(time * 100);     //执行时间，可以调整  
  #else
  int back_music[2]={M1,M1};
  for(int i=0;i<2;i++)
  {
    tone(Buzzer,back_music[i]);
    delay(200);
    noTone(Buzzer);
  }
  #endif  
}
//=================================触-发-函-数===============================
void left_motor()  //触发函数
{
  motor1++; 
}

void right_motor()  //触发函数
{
  motor2++; 
}

void flash()//计算速度的触发函数
{
  speed1=motor1;
  speed2=motor2;
  motor1=0;    //重新定义motor1的值
  motor2=0;   //重新定义motor1的值
}
