//connect 74hc595 pin10:MR--->VCC; Pin13:OE--->GND
int latchPin = 5;//to 595 pin12
int clockPin = 4;//to 595 pin11
int dataPin = 2; //to 595 pin14
void setup ()
{
  pinMode(latchPin,OUTPUT);
  pinMode(clockPin,OUTPUT);
  pinMode(dataPin,OUTPUT); //让三个脚都是输出状态
}
void loop()
{
  for(int a=0; a<256; a++)//这个循环的意思是让a这个变量+1一直加到到256，每次循环都进行下面的活动
  {
    digitalWrite(latchPin,LOW); //将ST_CP口上面加低电平让芯片准备好接收数据
    q
    /*dataPin：数据输出引脚，数据的每一位将逐次输出。引脚模式需要设置成输出。
      clockPin：时钟输出引脚，为数据输出提供时钟，引脚模式需要设置成输出。
      bitOrder：数据位移顺序选择位，该参数为byte类型，有两种类型可选择，分别是高位先入MSBFIRST和低位先入LSBFIRST。
      a：所要输出的数据值。*/
    digitalWrite(latchPin,HIGH); //将ST_CP这个针脚恢复到高电平
    delay(1000); //暂停1秒钟让你看到效果
  }  
}
