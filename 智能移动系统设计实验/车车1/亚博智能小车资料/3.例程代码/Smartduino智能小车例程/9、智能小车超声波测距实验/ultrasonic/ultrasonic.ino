//============================亚博科技===========================
//  智能小车超声波测距实验
//===============================================================
#include <LiquidCrystal.h> //申明1602液晶的函数库
//申明1602液晶的引脚所连接的Arduino数字端口，8线或4线数据模式，任选其一
//LiquidCrystal lcd(12,11,10,9,8,7,6,5,4,3,2);   //8数据口模式连线声明
LiquidCrystal lcd(13,12,6,5,4,3); //4数据口模式连线声明 

int Echo = A1;  // Echo回声脚(P2.0)
int Trig =A0;  //  Trig 触发脚(P2.1)

int Distance = 0;

void setup()
{
  Serial.begin(9600);     // 初始化串口
  //初始化电机驱动IO为输出方式
  //初始化超声波引脚
  pinMode(Echo, INPUT);    // 定义超声波输入脚
  pinMode(Trig, OUTPUT);   // 定义超声波输出脚
  lcd.begin(16,2);      //初始化1602液晶工作                       模式
  //定义1602液晶显示范围为2行16列字符  
}


void Distance_test()   // 量出前方距离 
{
  digitalWrite(Trig, LOW);   // 给触发脚低电平2μs
  delayMicroseconds(2);
  digitalWrite(Trig, HIGH);  // 给触发脚高电平10μs，这里至少是10μs
  delayMicroseconds(10);
  digitalWrite(Trig, LOW);    // 持续给触发脚低电
  float Fdistance = pulseIn(Echo, HIGH);  // 读取高电平时间(单位：微秒)
  Fdistance= Fdistance/58;       //为什么除以58等于厘米，  Y米=（X秒*344）/2
  // X秒=（ 2*Y米）/344 ==》X秒=0.0058*Y米 ==》厘米=微秒/58
  Serial.print("Distance:");      //输出距离（单位：厘米）
  Serial.println(Fdistance);         //显示距离
  Distance = Fdistance;
}  

void loop()
{
  Distance_test();
  if((2<Distance)&(Distance<400))//超声波测距范围2cm到400cm
  {
    lcd.home();        //把光标移回左上角，即从头开始输出   
    lcd.print("    Distance: ");       //显示
    lcd.setCursor(6,2);   //把光标定位在第2行，第6列
    lcd.print(Distance);       //显示距离
    lcd.print("cm");        //显示
  }
  else
  {
    lcd.home();        //把光标移回左上角，即从头开始输出  
    lcd.print("!!! Out of range");       //显示超出距离
  }
  delay(250);
  lcd.clear();
}
