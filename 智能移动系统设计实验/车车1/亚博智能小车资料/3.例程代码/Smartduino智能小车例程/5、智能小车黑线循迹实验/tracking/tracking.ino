//============================亚博科技===========================
//  智能小车黑线循迹实验
//===============================================================
//#include <Servo.h> 
int Left_motor_back=8;     //左电机后退(IN1)
int Left_motor_go=9;     //左电机前进(IN2)
int Right_motor_go=10;    // 右电机前进(IN3)
int Right_motor_back=11;    // 右电机后退(IN4)

int key=A2;//定义按键 数字7 接口
//int beep=12;//定义蜂鸣器 数字12 接口

const int SensorRight = A3;   	//右循迹红外传感器(P3.2 OUT1)
const int SensorLeft = A4;     	//左循迹红外传感器(P3.3 OUT2)

int SL;    //左循迹红外传感器状态
int SR;    //右循迹红外传感器状

void setup()
{
  //初始化电机驱动IO为输出方式
  pinMode(Left_motor_go,OUTPUT); // PIN 8 (PWM)
  pinMode(Left_motor_back,OUTPUT); // PIN 9 (PWM)
  pinMode(Right_motor_go,OUTPUT);// PIN 10 (PWM) 
  pinMode(Right_motor_back,OUTPUT);// PIN 11 (PWM)
  pinMode(key,INPUT);//定义按键接口为输入接口
//  pinMode(beep,OUTPUT);
  pinMode(SensorRight, INPUT); //定义右循迹红外传感器为输入
  pinMode(SensorLeft, INPUT); //定义左循迹红外传感器为输入
  Serial.begin(9600);
}

//=======================智能小车的基本动作=========================
void run(int time)     // 前进
//void run()
{
  //Serial.println("run!");
  digitalWrite(Right_motor_go,HIGH);  // 右电机前进
  digitalWrite(Right_motor_back,LOW);     
  analogWrite(Right_motor_go,115);//PWM比例0~255调速，左右轮差异略增减
  analogWrite(Right_motor_back,0);
  digitalWrite(Left_motor_go,HIGH);  // 左电机前进
  digitalWrite(Left_motor_back,LOW);
  analogWrite(Left_motor_go,100);//PWM比例0~255调速，左右轮差异略增减
  analogWrite(Left_motor_back,0);
  delay(time * 100);   //执行时间，可以调整  
}

void brake(int time)  //刹车，停车
//void brake()
{
  digitalWrite(Right_motor_go,LOW);
  digitalWrite(Right_motor_back,LOW);
  digitalWrite(Left_motor_go,LOW);
  digitalWrite(Left_motor_back,LOW);
  delay(time * 100);//执行时间，可以调整  
}

void left(int time)         //左转(左轮不动，右轮前进)
//void left()
{
  //Serial.println("Leeeeeeeeeft!");
  digitalWrite(Right_motor_go,HIGH);	// 右电机前进
  digitalWrite(Right_motor_back,LOW);
  analogWrite(Right_motor_go,50); 
  analogWrite(Right_motor_back,0);//PWM比例0~255调速
  digitalWrite(Left_motor_go,LOW);   //左轮后退
  digitalWrite(Left_motor_back,LOW);
  analogWrite(Left_motor_go,0); 
  analogWrite(Left_motor_back,0);//PWM比例0~255调速
  //delay(time * 100);	//执行时间，可以调整  
}

void spin_left(int time)         //左转(左轮后退，右轮前进)
{
  digitalWrite(Right_motor_go,HIGH);	// 右电机前进
  digitalWrite(Right_motor_back,LOW);
  analogWrite(Right_motor_go,200); 
  analogWrite(Right_motor_back,0);//PWM比例0~255调速
  digitalWrite(Left_motor_go,LOW);   //左轮后退
  digitalWrite(Left_motor_back,HIGH);
  analogWrite(Left_motor_go,0); 
  analogWrite(Left_motor_back,200);//PWM比例0~255调速
  delay(time * 100);	//执行时间，可以调整  
}

void right(int time)        //右转(右轮不动，左轮前进)
//void right()
{
  //Serial.println("Riiiiiiiiiight!");
  digitalWrite(Right_motor_go,LOW);   //右电机后退
  digitalWrite(Right_motor_back,LOW);
  analogWrite(Right_motor_go,0); 
  analogWrite(Right_motor_back,0);//PWM比例0~255调速
  digitalWrite(Left_motor_go,HIGH);//左电机前进
  digitalWrite(Left_motor_back,LOW);
  analogWrite(Left_motor_go,100); 
  analogWrite(Left_motor_back,0);//PWM比例0~255调速
  delay(time * 100);	//执行时间，可以调整  
}

void spin_right(int time)        //右转(右轮后退，左轮前进)
{
  digitalWrite(Right_motor_go,LOW);   //右电机后退
  digitalWrite(Right_motor_back,HIGH);
  analogWrite(Right_motor_go,0); 
  analogWrite(Right_motor_back,200);//PWM比例0~255调速
  digitalWrite(Left_motor_go,HIGH);//左电机前进
  digitalWrite(Left_motor_back,LOW);
  analogWrite(Left_motor_go,200); 
  analogWrite(Left_motor_back,0);//PWM比例0~255调速
  delay(time * 100);	//执行时间，可以调整    
}

//void back(int time)          //后退
void back(int time)
{
  digitalWrite(Right_motor_go,LOW);  //右轮后退
  digitalWrite(Right_motor_back,HIGH);
  analogWrite(Right_motor_go,0);
  analogWrite(Right_motor_back,150);//PWM比例0~255调速
  digitalWrite(Left_motor_go,LOW);  //左轮后退
  digitalWrite(Left_motor_back,HIGH);
  analogWrite(Left_motor_go,0);
  analogWrite(Left_motor_back,150);//PWM比例0~255调速
  delay(time * 100);     //执行时间，可以调整  
}
//==========================================================

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
    delay(10);	//延时10ms
    val=digitalRead(key);//读取数字7 口电平值赋给val
    if(val==HIGH)  //第二次判断按键是否被按下
    {
      //digitalWrite(beep,HIGH);		//蜂鸣器响
      //while(!digitalRead(key))	//判断按键是否被松开
       // digitalWrite(beep,LOW);		//蜂鸣器停止
        break;
    }
   // else
     // digitalWrite(beep,LOW);//蜂鸣器停止
  }
}

void loop()
{ 
  keysacn();//调用按键扫描函数  
  while(1)
  {
  //有信号为LOW  没有信号为HIGH
  SR = digitalRead(SensorRight);//有信号表明在白色区域，车子底板上L3亮；没信号表明压在黑线上，车子底板上L3灭
  SL = digitalRead(SensorLeft);//有信号表明在白色区域，车子底板上L2亮；没信号表明压在黑线上，车子底板上L2灭
  
  //Serial.print("SL=");Serial.print(SL);Serial.print("   SR=");Serial.println(SR);
  
  //黑色，SR/SL为1，灯灭；白色，SR/SL为0，灯亮
  
  if ((SL==LOW&&SR==LOW)||(SL==HIGH&&SR==HIGH))
    run(0.01);   //调用前进函数
  else if (SL == LOW & SR == HIGH)
    right(0.01);
  else if (SL == HIGH & SR == LOW) 
    left(0.01);
  //brake(1);
  }
}
