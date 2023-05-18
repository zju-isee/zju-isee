//#define __DEBUG__//条件编译
#include <SoftwareSerial.h>
#include <TaskScheduler.h>
#include <MsTimer2.h>

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
  int left_speed_forward = 100;//各个轮子的速度                              //
  int right_speed_forward = 100;                                             //
  int left_speed_back = 0;                                                 //
  int right_speed_back = 0;                                                //                           
                                                                           //
const int forward_led=6;//前灯                                             //
const int l_led=12;//左灯                                                  //
const int r_led=13;//右灯                                                  //
                                                                           //
const int r_wheel=2;//右轮转速                                             //
const int l_wheel=3;//左轮转速                                             //
                                                                           //
const int light_sensor=A1;//光照传感                                       //
const int temp_sensor=A2;//温度传感                                        //
//——————————————————————————————————————————————————————————————————————————

int isMusicPlay=0;//music是否播放的flag
int whichMusic=0;
String command; //接收的指令
String State;   //温度_速度_光强


unsigned int motor1=0;   //计左电机码盘脉冲值
unsigned int motor2=0;   //计右电机码盘脉冲值
unsigned int speed1=0;   //计左电机速度值
unsigned int speed2=0;   //计右电机速度值

 int counter;
 bool counterflag=false;
 int counterl;
 bool counterlflag=false;
 
 bool ll=false;
 bool rr=false;
 bool bb=false;

 bool light_open=false;
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

#define NOTE_C0   0
#define NOTE_CL1 131
#define NOTE_CL2 147
#define NOTE_CL3 165
#define NOTE_CL4 175
#define NOTE_CL5 196
#define NOTE_CL6 221
#define NOTE_CL7 248

#define NOTE_C1 262
#define NOTE_C2 294
#define NOTE_C3 330
#define NOTE_C4 350
#define NOTE_C5 393
#define NOTE_C6 441
#define NOTE_C7 495

#define NOTE_CH1 525
#define NOTE_CH2 589
#define NOTE_CH3 661
#define NOTE_CH4 700
#define NOTE_CH5 786
#define NOTE_CH6 882
#define NOTE_CH7 990

int table[22]={none,L1,L2,L3,L4,L5,L6,L7,M1,M2,M3,M4,M5,M6,M7,H1,H2,H3,H4,H5,H6,H7};
int table2[22]={NOTE_C0,NOTE_CL1,NOTE_CL2,NOTE_CL3,NOTE_CL4,NOTE_CL5,NOTE_CL6,NOTE_CL7,NOTE_C1,NOTE_C2,NOTE_C3,NOTE_C4,NOTE_C5,NOTE_C6,NOTE_C7,NOTE_CH1,NOTE_CH2,NOTE_CH3,NOTE_CH4,NOTE_CH5,NOTE_CH6,NOTE_CH7};
//该部分是定义是把每个音符和频率值对应起来，由于两首乐曲使用两个不同的调，因此需要两个频率对照表

//
int note=0;
int lenth1;
int lenth2;
/*
 * music1是《蜜雪冰城》，music2是《遇见》，music3是《最伟大的作品》
 * 经过测试，动态内存占用率>85%时会导致运行问题，且乐曲存放将消耗大量动态内存，
 * 因此music2被注释掉以确保足够的空间
 */
//频谱'
char music1[]="589:<<=<:9889::989098:<<=<:9889::9980;;<==<<:89089:<<=<:9889::9988";
//char music2[]="000<::<99:99880876787889::00<::<99:998808767877889800<=>;:98><::<99";
//char music3[]="0:=AA@B0:=@@?A0:=??>@0???@>0:=AA@@E?EA@A?0?>?A@=0:?>=0:=:A@B0:=@@?A0:=";
//节拍
char music_delay1[] ="100112010010011113100112010010011113331133111131001111100100111003";
//char music_delay2[] ="3333333333333333333333333333333333333333333333333333333333333333333";
//char music_delay3[] ="44443142222314222231422223142222311522231422223142231D222231422223142222";
//_________________________________________________________________________


//================================任-务-日-程==============================
void change_speed(){

  
  static bool continuous_0=false;
  String Left = command.substring(command.indexOf('_')+1,command.indexOf('!'));//获取子字符串
  String Right = command.substring(command.indexOf('!')+1);
  int ltemp=Left.toInt();
  int rtemp=Right.toInt();
  /*Serial.println(ltemp);
  Serial.println(rtemp);
  Serial.println("________");*/

  if(ltemp==0&&rtemp==0)
  {
    if(continuous_0==true) return;
    else 
    {
      continuous_0=true;
      counter=0;
      }
   }
  else 
  {
    if(continuous_0==true)
      continuous_0=false;
    }
  
    
  if(ltemp>=0){
    left_speed_back=0;
    left_speed_forward = ltemp;//字符串转换成整型数据
    counterflag=false;
    counterlflag=false;
  }else{
    left_speed_forward=0;
    left_speed_back = -1*ltemp;
    counterlflag=true;
  }
  
  if(rtemp>=0){
    right_speed_back=0;
    right_speed_forward = rtemp;
    counterflag=false;
    counterlflag=false;
  }else{
    counterflag=true;
    right_speed_forward=0;
    right_speed_back = -1*rtemp;
  }

  if(counterlflag&&counterflag)
  {
    counterlflag=(right_speed_back<left_speed_back)?false:true;
    counterflag=(right_speed_back>left_speed_back)?false:true;
  }

  forward(1);
  return;
}

void Parse()
{
    //Serial.println(command);
    //Serial.println(command[0]);
    switch(command[0])
      {
        case 'b':
          isMusicPlay=1;
          note=0;
          break;
        case 'z':
          isMusicPlay=0;
          note=0;
          break;
        case 'n':
          whichMusic=(whichMusic<1)?(whichMusic+1):0;
          break;
        case 'c':
          change_speed();
          command="";
          break;
        default:
          break;
      }
      return;
}

char c;
void UpdateState()
{
  //Serial.println("======ask for commmand");
  while(BT.available())
  {
      c=BT.read();
      //Serial.println("print");
      if(c=='*')
      {
        Parse();      
      }
      else
      {
        command=command+c;
      }
        
  }
  
}

void UploadState()
{
    //Serial.println("_______message send!__________");
    float temp=analogRead(temp_sensor)*500.0/1024.0;
    
    int speed_av,len,light;
    len=State.length();
    speed_av = (speed1+speed2)/2;
    light = analogRead(light_sensor);
    
    if(510-light < 0) light = 0;
    else light = 510-light;

    if(light<350) light_open=true;//当光强小于350，使所有灯恒亮
    else light_open=false;

    String string1 = String(speed_av);
    String string2 = String(temp);
    String string3 = String(light);
    /*Serial.println(speed_av);
    Serial.println(temp);
    Serial.println(light);*/
    State = String(string1+'_'+string2+'_'+string3);
    
//  Serial.println(State);
//  BT.print(len);
    BT.println(State);

//  Serial.println("message Send");
//  Serial.print("message lenth");
//  Serial.println(len);+
  
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
  
  pinMode(Buzzer,OUTPUT); // PIN 7 (PWM)
  digitalWrite(Buzzer,HIGH);
  lenth1=sizeof(music1) / sizeof(music1[0]);
  //lenth2=sizeof(music3) / sizeof(music3[0]);
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
  switch (command[0])
  {
    case 'w':
      forward(2);//前进1s
      break;
    case 'x':
      back(2); //后退1s
      break;
    case 'a':
      left(2); //向左转1s
      break;
    case 'd':
      right(2);//向右转1s
      break;
    case 'q':
      spinLeft(0.7);
      break;
    case 'e':
      spinRight(0.7);
      break;
    case 's':
      brake(2);//停车
      break;
    case 'l':
      if(!rr)
        R_led_open();
      else
        R_led_close();
      rr=!rr;
      break;
    case 'j':
      if(!ll)
        L_led_open();
      else
        L_led_close();
      ll=!ll;
      break;
    case 'k':
      if(!bb)
        B_led_open();
      else
        B_led_close();
      bb=!bb;
      break;
    default:
      break;
  }
  command="";  
  /*Serial.print("isMusicPlay=");
  Serial.println(isMusicPlay);*/
    
  if(isMusicPlay==1)
  {
    playMusic();
  }
  else
    digitalWrite(Buzzer,HIGH);

}
//================================音-乐-播-放================================

  
void playMusic()
{
  switch(whichMusic)
  {
    case 0:
      tone(Buzzer, table[(music1[note]-48)]);   //驱动蜂鸣器
      delay((music_delay1[note]-'0'+1) * 100); //节拍实现
      noTone(Buzzer);   //停止蜂鸣器
      note=note+1;
      if(note==lenth1)  note=0;
      break;
   /* case 1:
      tone(Buzzer, table2[music3[note]-48]);   //驱动蜂鸣器
      delay((music_delay3[note]-'0'+1) * 135); //节拍实现
      noTone(Buzzer);   //停止蜂鸣器
      note=note+1;
      if(note==lenth2)  note=0;
      break;*/
    }
  
}

//================================运-动-控-制===============================-

void forward(int time)     // 前进
{
  /*Serial.println(right_speed_forward);
  Serial.println(right_speed_back);
  Serial.println(left_speed_forward);
  Serial.println(left_speed_back);
  Serial.println("=========================");*/
  L_led_open();
  R_led_open();
  B_led_close();
  #ifndef __DEBUG__left_speed_forward
  analogWrite(Right_motor_go,right_speed_forward);//PWM比例0~255调速
  if(!counterflag)
    analogWrite(Right_motor_back,right_speed_back);
  else
  {
    if(counter==right_speed_back>>6)
    {
      digitalWrite(Right_motor_back,LOW);
      counter=0;
      //Serial.println("pause");
    }
    else
    {
      digitalWrite(Right_motor_back,HIGH);
      counter=counter+1;
      //Serial.println(counter);
     }
  }

  if(!counterlflag)
    analogWrite(Left_motor_back,left_speed_back);
   else
  {
    if(counterl>=left_speed_back>>6)
    {
      digitalWrite(Left_motor_back,LOW);
      counterl=0;
      //Serial.println("pause");
    }
    else
    {
      digitalWrite(Left_motor_back,HIGH);
      counterl=counterl+1;
      //Serial.println(counter);
     }
  }
  analogWrite(Left_motor_go,left_speed_forward);//PWM比例0~255调速
  
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
  L_led_close();
  R_led_close();
  B_led_open();
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
  L_led_open();
  R_led_close();
  B_led_close();
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
  L_led_open();
  R_led_close();
  B_led_close();
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
  L_led_close();
  R_led_open();
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
  L_led_close();
  R_led_open();
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
  L_led_close();
  R_led_close();
  B_led_open();
  #ifndef __DEBUG__
//  Serial.println(1);
  analogWrite(Right_motor_go,0);
  digitalWrite(Right_motor_back,HIGH);
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
//===============================车灯函数================================
void L_led_open()
{
  digitalWrite(l_led,HIGH);
}
void R_led_open()
{
  digitalWrite(r_led,HIGH);
}
void B_led_open()
{
  digitalWrite(forward_led,HIGH);
}
void L_led_close()
{
  digitalWrite(l_led,(!light_open)?LOW:HIGH);
}
void R_led_close()
{
  digitalWrite(r_led,(!light_open)?LOW:HIGH);
}
void B_led_close()
{
  digitalWrite(forward_led,(!light_open)?LOW:HIGH);
  }
