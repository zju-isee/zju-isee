//============================亚博科技========================================
//  智能小车红外遥控实验
//  实验中所用接收红外信号为配送遥控器的信号，也可打印出信号数值，配合其他红外信号控制
//  参考4.视频教程\Arduino套件视频\视频教程\例程19-红外遥控.mp4
//  本实验不可调节电机速度，调节pwm值会影响红外的信号接收
//=============================================================================
#include <IRremote.h>//包含红外库
#include <TaskScheduler.h>
int RECV_PIN = A5;//端口声明
IRrecv irrecv(RECV_PIN);
decode_results results;//结构声明
int on = 0;//标志位
unsigned long last = millis();
int flag = 0;
int flag_change=0;
#include <LiquidCrystal.h> //申明1602液晶的函数库
LiquidCrystal lcd(13,12,6,5,4,3); //4数据口模式连线声明

long run_car = 0x00FF18E7;//按键2
long back_car = 0x00FF4AB5;//按键8
long left_car = 0x00FF10EF;//按键4
long right_car = 0x00FF5AA5;//按键6
long stop_car = 0x00FF38C7;//按键5
long left_turn = 0x00ff30CF;//按键1
long right_turn = 0x00FF7A85;//按键3
long tracking = 0x00ff42bd;   //按键7 控制主动循迹
long avoidance = 0x00ff52ad; //案件9 控制避障
long remote_control = 0x00ffa857;  //三角按键 红外控制

//==============================
int Left_motor_back=8;     //左电机后退(IN1)
int Left_motor_go=9;     //左电机前进(IN2)
int Right_motor_go=10;    // 右电机前进(IN3)
int Right_motor_back=11;    // 右电机后退(IN4)

int Echo = A1;  // Echo回声脚(P2.0)
int Trig =A0;  //  Trig 触发脚(P2.1)
const int SensorRight = A3;     //右循迹红外传感器(P3.2 OUT1)
const int SensorLeft = A4;      //左循迹红外传感器(P3.3 OUT2)
int key=A2;//定义按键 数字7 接口
int beep=12;//定义蜂鸣器 数字12 接口

int SL;    //左循迹红外传感器状态
int SR;    //右循迹红外传感器状态

int Front_Distance = 0;
int Left_Distance = 0;
int Right_Distance = 0;

int servopin=2;//设置舵机驱动脚到数字口2
int myangle;//定义角度变量
int pulsewidth;//定义脉宽变量 
int val;

//===========================================================
void flagUpdate()
{
    Serial.println("task execute");
      flag_change=0;
     if (irrecv.decode(&results)) //调用库函数：解码
     {
        Serial.println("flag changed");
        flag_change=1;
                
        // If it's been at least 1/4 second since the last
        // IR received, toggle the relay
        if (millis() - last > 250) //确定接收到信号
        {
          on = !on;//标志位置反
          digitalWrite(13, on ? HIGH : LOW);//板子上接收到信号闪烁一下led
          dump(&results);//解码红外信号
        }
        
        if(results.value==tracking)
          {flag=1;}//按键7
        else if(results.value==avoidance)
          {flag=2;} //按键9 
        else
        {
          if(results.value==remote_control)
          {flag=0;}//按键三角，自由控制
        } 

        if(flag_change)
        {
          last = millis();      
          irrecv.resume(); // Receive the next value
        }
     }
     Serial.println("task end!");
     return;
  }
Task FlagTask(10,TASK_FOREVER,&flagUpdate);
Scheduler Sch;

void setup()
{
  //初始化电机驱动IO为输出方式
  pinMode(Left_motor_go,OUTPUT); // PIN 8 (PWM)
  pinMode(Left_motor_back,OUTPUT); // PIN 9 (PWM)
  pinMode(Right_motor_go,OUTPUT);// PIN 10 (PWM) 
  pinMode(Right_motor_back,OUTPUT);// PIN 11 (PWM)
  pinMode(13, OUTPUT);////端口模式，输出
  pinMode(SensorRight, INPUT); //定义右循迹红外传感器为输入
  pinMode(SensorLeft, INPUT); //定义左循迹红外传感器为输入
  pinMode(key,INPUT);//定义按键接口为输入接口
  pinMode(beep,OUTPUT);
  Serial.begin(9600);	//波特率9600
  irrecv.enableIRIn(); // Start the receiver

  lcd.begin(16,2);      //初始化1602液晶工作模式
  //定义1602液晶显示范围为2行16列字符  
  pinMode(servopin,OUTPUT);//设定舵机接口为输出接口

  Sch.init();
  Sch.addTask(FlagTask);
  FlagTask.enable();
}

//==========================digital_move=========================

void digital_run(int time)     // 前进
{
  digitalWrite(Right_motor_go,HIGH);  // 右电机前进
  digitalWrite(Right_motor_back,LOW);     

  digitalWrite(Left_motor_go,HIGH);  // 左电机前进
  digitalWrite(Left_motor_back,LOW);

  delay(time * 100);   //执行时间，可以调整  
}

void digital_left(int time)         //左转(左轮不动，右轮前进)
{
  digitalWrite(Right_motor_go,HIGH);  // 右电机前进
  digitalWrite(Right_motor_back,LOW);
  digitalWrite(Left_motor_go,LOW);   //左轮不动
  digitalWrite(Left_motor_back,LOW);
  delay(time * 100);  //执行时间，可以调整  
}

void digital_spin_left(int time)         //左转(左轮后退，右轮前进)
{
  digitalWrite(Right_motor_go,HIGH);  // 右电机前进
  digitalWrite(Right_motor_back,LOW);
  digitalWrite(Left_motor_go,LOW);   //左轮后退
  digitalWrite(Left_motor_back,HIGH);
  delay(time * 100);  //执行时间，可以调整  
}

void digital_right(int time)        //右转(右轮不动，左轮前进)
{
  digitalWrite(Right_motor_go,LOW);   //右电机不动
  digitalWrite(Right_motor_back,LOW);
  digitalWrite(Left_motor_go,HIGH);//左电机前进
  digitalWrite(Left_motor_back,LOW);
  delay(time * 100);  //执行时间，可以调整  
}

void digital_spin_right(int time)        //右转(右轮后退，左轮前进)
{
  digitalWrite(Right_motor_go,LOW);   //右电机后退
  digitalWrite(Right_motor_back,HIGH);
  digitalWrite(Left_motor_go,HIGH);//左电机前进
  digitalWrite(Left_motor_back,LOW);
  delay(time * 100);  //执行时间，可以调整  
}

void digital_back(int time)          //后退
{
  digitalWrite(Right_motor_go,LOW);  //右轮后退
  digitalWrite(Right_motor_back,HIGH);
  digitalWrite(Left_motor_go,LOW);  //左轮后退
  digitalWrite(Left_motor_back,HIGH);
  delay(time * 100);     //执行时间，可以调整  
}

//===================analog_move===========================

void run(int time)     // 前进
{
  analogWrite(Right_motor_go,120);//PWM比例0~255调速，左右轮差异略增减
  analogWrite(Right_motor_back,0);
  analogWrite(Left_motor_go,110);//PWM比例0~255调速，左右轮差异略增减
  analogWrite(Left_motor_back,0);
  delay(time * 100);   //执行时间，可以调整  
}


void brake(int time)         //刹车，停车
{
  digitalWrite(Right_motor_go,LOW);
  digitalWrite(Right_motor_back,LOW);
  digitalWrite(Left_motor_go,LOW);
  digitalWrite(Left_motor_back,LOW);
  delay(time * 100);//执行时间，可以调整  
}

void left(float time)         //左转(左轮不动，右轮前进)
{
  analogWrite(Right_motor_go,90); 
  analogWrite(Right_motor_back,0);//PWM比例0~255调速
  analogWrite(Left_motor_go,0); 
  analogWrite(Left_motor_back,0);//PWM比例0~255调速
  delay(time * 100);	//执行时间，可以调整  
  analogWrite(Right_motor_go,0); 
}

void spin_left(int time)         //左转(左轮后退，右轮前进)
{
  //digitalWrite(Right_motor_go,HIGH);	// 右电机前进
  //digitalWrite(Right_motor_back,LOW);
  analogWrite(Right_motor_go,200); 
  analogWrite(Right_motor_back,0);//PWM比例0~255调速
  //digitalWrite(Left_motor_go,LOW);   //左轮后退
  //digitalWrite(Left_motor_back,HIGH);
  analogWrite(Left_motor_go,0); 
  analogWrite(Left_motor_back,200);//PWM比例0~255调速
  delay(time * 100);	//执行时间，可以调整  
}


void right(float time)        //右转(右轮不动，左轮前进)
{
  analogWrite(Right_motor_go,0); 
  analogWrite(Right_motor_back,0);//PWM比例0~255调速
  analogWrite(Left_motor_go,100); 
  analogWrite(Left_motor_back,0);//PWM比例0~255调速
  delay(time * 100);	//执行时间，可以调整  
  analogWrite(Left_motor_go,0); 
}

void spin_right(int time)        //右转(右轮后退，左轮前进)
{
  //digitalWrite(Right_motor_go,LOW);   //右电机后退
  //digitalWrite(Right_motor_back,HIGH);
  analogWrite(Right_motor_go,0); 
  analogWrite(Right_motor_back,200);//PWM比例0~255调速
  //digitalWrite(Left_motor_go,HIGH);//左电机前进
  //digitalWrite(Left_motor_back,LOW);
  analogWrite(Left_motor_go,200); 
  analogWrite(Left_motor_back,0);//PWM比例0~255调速
  delay(time * 100);	//执行时间，可以调整  
}



void back(int time)          //后退
{
  //digitalWrite(Right_motor_go,LOW);  //右轮后退
  //digitalWrite(Right_motor_back,HIGH);
  analogWrite(Right_motor_go,0);
  analogWrite(Right_motor_back,150);//PWM比例0~255调速
  //digitalWrite(Left_motor_go,LOW);  //左轮后退
  //digitalWrite(Left_motor_back,HIGH);
  analogWrite(Left_motor_go,0);
  analogWrite(Left_motor_back,150);//PWM比例0~255调速
  delay(time * 100);     //执行时间，可以调整  
}

void dump(decode_results *results)
{
  int count = results->rawlen;
  if (results->decode_type == UNKNOWN) 
  {
    //Serial.println("Could not decode message");
    brake(1);
  } 
//串口打印，调试时可以打开，实际运行中会影响反应速度，建议屏蔽
/*
  else 
  {

    if (results->decode_type == NEC) 
    {
      Serial.print("Decoded NEC: ");
    } 
    else if (results->decode_type == SONY) 
    {
      Serial.print("Decoded SONY: ");
    } 
    else if (results->decode_type == RC5) 
    {
      Serial.print("Decoded RC5: ");
    } 
    else if (results->decode_type == RC6) 
    {
      Serial.print("Decoded RC6: ");
    }
    Serial.print(results->value, HEX);
    Serial.print(" (");
    Serial.print(results->bits, DEC);
    Serial.println(" bits)");
    
  }
  Serial.print("Raw (");
  Serial.print(count, DEC);
  Serial.print("): ");

  for (int i = 0; i < count; i++) 
  {
    if ((i % 2) == 1) 
    {
      Serial.print(results->rawbuf[i]*USECPERTICK, DEC);
    } 
    else  
    {
      Serial.print(-(int)results->rawbuf[i]*USECPERTICK, DEC);
    }
    Serial.print(" ");
  }
  Serial.println("");
*/
}

void keysacn()//按键扫描
{
  int val;
  val=digitalRead(key);//读取数字7 口电平值赋给val
  while(!digitalRead(key))//当按键没被按下时，一直循环
  {
    val=digitalRead(key);//此句可省略，可让循环跑空
  }
  while(digitalRead(key))//当按键被按下时
  {
    delay(10);  //延时10ms
    val=digitalRead(key);//读取数字7 口电平值赋给val
    if(val==HIGH)  //第二次判断按键是否被按下
    {
      digitalWrite(beep,HIGH);    //蜂鸣器响
      while(!digitalRead(key))  //判断按键是否被松开
        digitalWrite(beep,LOW);   //蜂鸣器停止
    }
    else
      digitalWrite(beep,LOW);//蜂鸣器停止
  }
}

//======================舵--机--控--制===========================
void servopulse(int servopin,int myangle)/*定义一个脉冲函数，用来模拟方式产生PWM值*/
{
  pulsewidth=(myangle*11)+500;//将角度转化为500-2480 的脉宽值
  digitalWrite(servopin,HIGH);//将舵机接口电平置高
  delayMicroseconds(pulsewidth);//延时脉宽值的微秒数
  digitalWrite(servopin,LOW);//将舵机接口电平置低
  delay(20-pulsewidth/1000);//延时周期内剩余时间
}
//======================距--离--感--应=============================

float Distance_test()   // 量出前方距离 
{
  digitalWrite(Trig, LOW);   // 给触发脚低电平2μs
  delayMicroseconds(2);
  digitalWrite(Trig, HIGH);  // 给触发脚高电平10μs，这里至少是10μs
  delayMicroseconds(10);
  digitalWrite(Trig, LOW);    // 持续给触发脚低电
  float Fdistance = pulseIn(Echo, HIGH);  // 读取高电平时间(单位：微秒)
  Fdistance= Fdistance/58;       //为什么除以58等于厘米，  Y米=（X秒*344）/2
  // X秒=（ 2*Y米）/344 ==》X秒=0.0058*Y米 ==》厘米=微秒/58
  //Serial.print("Distance:");      //输出距离（单位：厘米）
  //Serial.println(Fdistance);         //显示距离
  return Fdistance;
}
//==================-显-示-=============================
void Display_mode(int Mode)
{
  lcd.home();
  if(!Mode)
  {
    lcd.print("Free Control");
    lcd.setCursor(6,2);   //把光标定位在第2行，第6列
    lcd.print("Mode");
    }
  else
  {
    lcd.print("Tracking");
    lcd.setCursor(6,2);   //把光标定位在第2行，第6列
    lcd.print("Mode");
    }
}

void Distance_display(int Distance)//显示距离
{
  if((2<Distance)&(Distance<400))
  {
    lcd.home();        //把光标移回左上角，即从头开始输出   
    lcd.print("    Distance: ");       //显示
    lcd.setCursor(6,2);   //把光标定位在第2行，第6列
    lcd.print(Distance);       //显示距离
    lcd.print("cm");          //显示
  }
  else
  {
    lcd.home();        //把光标移回左上角，即从头开始输出  
    lcd.print("!!! Out of range");       //显示
  }
  delay(50);
}

//=====================距-离-检-测========================
void front_detection()
{
  //此处循环次数减少，为了增加小车遇到障碍物的反应速度
  for(int i=0;i<=5;i++) //产生PWM个数，等效延时以保证能转到响应角度
  {
    servopulse(servopin,70);//模拟产生PWM
  }
  Front_Distance = Distance_test();
  //Serial.print("Front_Distance:");      //输出距离（单位：厘米）
 // Serial.println(Front_Distance);         //显示距离
 //Distance_display(Front_Distance);
}

void left_detection()
{
  for(int i=0;i<=15;i++) //产生PWM个数，等效延时以保证能转到响应角度
  {
    servopulse(servopin,145);//模拟产生PWM
  }
  Left_Distance = Distance_test();
  //Serial.print("Left_Distance:");      //输出距离（单位：厘米）
  //Serial.println(Left_Distance);         //显示距离
}

void right_detection()
{
  for(int i=0;i<=15;i++) //产生PWM个数，等效延时以保证能转到响应角度
  {
    servopulse(servopin,5);//模拟产生PWM
  }
  Right_Distance = Distance_test();
  //Serial.print("Right_Distance:");      //输出距离（单位：厘米）
  //Serial.println(Right_Distance);         //显示距离
}



void loop()
{
  keysacn();
  //Serial.println("key pressed");
  while(1)
  {
    //Serial.println("begin Cycle");
     Sch.execute();  // 执行被调度的任务，用调度器时放上这一句即可   
     switch(flag)
     {
        case 0://自由控制
            
            //Serial.println(results.value);
            
            Display_mode(0);
               //Serial.println("Free Control!!!");
            if (results.value == run_car )//按键2
            {
              run(0);//前进
              //Serial.println("  run!!!");
              }
            if (results.value == back_car )//按键8
              digital_back(0);//后退
            if (results.value == left_car )//按键4
              digital_left(0);//左转
            if (results.value == right_car )//按键6
              digital_right(0);//右转
            if (results.value == stop_car )//按键5
            {
              brake(0);//停车
              //Serial.println("!!!!Stop!!!");
              } 
            if (results.value == left_turn )//按键1
            {
              digital_spin_left(0);//左旋转
              //Serial.println("          Left!!!");
              } 
            if (results.value == right_turn )//按键3
              digital_spin_right(0);//右旋转
            break;
        case 1://循迹
            Display_mode(1);
            //Serial.println("        Tracking!");
            SR = digitalRead(SensorRight);//有信号表明在白色区域，车子底板上L3亮；没信号表明压在黑线上，车子底板上L3灭
            SL = digitalRead(SensorLeft);//有信号表明在白色区域，车子底板上L2亮；没信号表明压在黑线上，车子底板上L2灭
            //黑色，SR/SL为1，灯灭；白色，SR/SL为0，灯亮
            if (SL == LOW&&SR==LOW)
              run(0);   //调用前进函数
            else if (SL == LOW & SR == HIGH)
              right(0.3);
            else if (SL == HIGH & SR == LOW) 
              left(0.3);
            else // 都是黑色, 停止
              brake(0);
            break;
        case 2://避障
            //Serial.println("                  Avoiding!");
            front_detection();//测量前方距离
            if(Front_Distance < 32)//当遇到障碍物时
            {
              digital_back(2);//后退减速
              brake(2);//停下来做测距
              
              left_detection();//测量左边距障碍物距离
              Distance_display(Left_Distance);//液晶屏显示距离
              //irrecv.resume();
              //if (irrecv.decode(&results)) break;
              right_detection();//测量右边距障碍物距离
              Distance_display(Right_Distance);//液晶屏显示距离
              //irrecv.resume();
              //if (irrecv.decode(&results)) break;
              
              if((Left_Distance < 35 ) &&( Right_Distance < 35 ))//当左右两侧均有障碍物靠得比较近
                digital_spin_left(0.7);//旋转掉头
              else if(Left_Distance > Right_Distance)//左边比右边空旷
              {      
                digital_left(3);//左转
                brake(1);//刹车，稳定方向
              }
              else//右边比左边空旷
              {
                digital_right(3);//右转
                brake(1);//刹车，稳定方向
              }
             }
            else
            {
              digital_run(0); //无障碍物，直行     
            }
            break;
      }
      

        
      
  }
}
