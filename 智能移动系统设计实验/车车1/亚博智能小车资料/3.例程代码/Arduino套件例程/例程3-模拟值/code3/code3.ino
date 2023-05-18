int potpin=0;//指定模拟端口A0
int ledpin=13;//指定LED端口 13
int val=0;//声明临时变量
void setup()
{
  pinMode(ledpin,OUTPUT);//设置端口13为输出模式
  Serial.begin(9600);//设置串口波特率为9600
}
void loop()
{
  digitalWrite(ledpin,HIGH);//拉高端口13，LED点亮
  delay(50);//延时0.05秒
  digitalWrite(ledpin,LOW);//拉低端口13，关闭LED
  delay(50);//延时0.05 秒
  val=analogRead(potpin);//读取A0口的电压值并赋值到val
  Serial.println(val);//串口发送val值
}
