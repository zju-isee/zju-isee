//============================亚博科技===========================
//  智能小车前后左右综合实验
//===============================================================
//#include <Servo.h> 
int Left_motor_back=8;     //左电机后退(IN1)
int Left_motor_go=9;     //左电机前进(IN2)

int Right_motor_go=10;    // 右电机前进(IN3)
int Right_motor_back=11;    // 右电机后退(IN4)

void setup()
{
  //初始化电机驱动IO为输出方式
  pinMode(Left_motor_go,OUTPUT); // PIN 8 (PWM)
  pinMode(Left_motor_back,OUTPUT); // PIN 9 (PWM)
  pinMode(Right_motor_go,OUTPUT);// PIN 10 (PWM) 
  pinMode(Right_motor_back,OUTPUT);// PIN 11 (PWM)
}
void run(int time)     // 前进
{
  digitalWrite(Right_motor_go,HIGH);  // 右电机前进
  digitalWrite(Right_motor_back,LOW);     
  analogWrite(Right_motor_go,200);//PWM比例0~255调速，左右轮差异略增减
  analogWrite(Right_motor_back,0);
  digitalWrite(Left_motor_go,HIGH);  // 左电机前进
  digitalWrite(Left_motor_back,LOW);
  analogWrite(Left_motor_go,200);//PWM比例0~255调速，左右轮差异略增减
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

void left(int time)         //左转(左轮不动，右轮前进)
{
  digitalWrite(Right_motor_go,HIGH);	// 右电机前进
  digitalWrite(Right_motor_back,LOW);
  analogWrite(Right_motor_go,200); 
  analogWrite(Right_motor_back,0);//PWM比例0~255调速
  digitalWrite(Left_motor_go,LOW);   //左轮不动
  digitalWrite(Left_motor_back,LOW);
  analogWrite(Left_motor_go,0); 
  analogWrite(Left_motor_back,0);//PWM比例0~255调速
  delay(time * 100);	//执行时间，可以调整  
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
{
  digitalWrite(Right_motor_go,LOW);   //右电机不动
  digitalWrite(Right_motor_back,LOW);
  analogWrite(Right_motor_go,0); 
  analogWrite(Right_motor_back,0);//PWM比例0~255调速
  digitalWrite(Left_motor_go,HIGH);//左电机前进
  digitalWrite(Left_motor_back,LOW);
  analogWrite(Left_motor_go,200); 
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

void back(int time)          //后退
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

void loop()
{
  delay(2000); //延时2s后启动
  back(10); //后退1s
  brake(5);//停止0.5s
  run(10);//前进1s
  brake(5);//停止0.5s
  left(10);//向左转1s
  right(10);//向右转1s
  spin_right(20); //向右旋转2s
  spin_left(20);//向左旋转2s
  brake(5);//停车
}


