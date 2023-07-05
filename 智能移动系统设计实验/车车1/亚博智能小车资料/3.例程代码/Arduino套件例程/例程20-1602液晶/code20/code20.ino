#include <LiquidCrystal.h> //申明1602液晶的函数库
//申明1602液晶的引脚所连接的Arduino数字端口，8线或4线数据模式，任选其一
LiquidCrystal lcd(12,11,10,9,8,7,6,5,4,3,2);   //8数据口模式连线声明
//LiquidCrystal lcd(12,11,10,5,4,3,2); //4数据口模式连线声明
int i;
void setup()
{
  lcd.begin(16,2);      //初始化1602液晶工作                       模式
                       //定义1602液晶显示范围为2行16列字符
  while(1)
  {
    lcd.home();        //把光标移回左上角，即从头开始输出   
    lcd.print("Hello World"); //显示
    lcd.setCursor(0,1);   //把光标定位在第1行，第0列
    lcd.print("Welcome to BST-Arduino");       //显示
    delay(500);
    for(i=0;i<3;i++)
    {
      lcd.noDisplay();
      delay(500);
      lcd.display();
      delay(500);
    }
    for(i=0;i<24;i++)
    {
      lcd.scrollDisplayLeft();
      delay(500);
    }
    lcd.clear();
    lcd.setCursor(0,0);        //把光标移回左上角，即从头开始输出   
    lcd.print("Hi,"); //显示
    lcd.setCursor(0,1);   //把光标定位在第1行，第0列
    lcd.print("Arduino is fun");       //显示
    delay(2000);
  }
}
void loop()
{}//初始化已完成显示，主循环无动作
