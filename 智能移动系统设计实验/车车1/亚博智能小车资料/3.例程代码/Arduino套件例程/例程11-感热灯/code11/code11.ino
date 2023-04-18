int potpin=0;//设置模拟端口A0
int ledpin=11;//设置数字端口11 ，后面用作PWM输出
int val=0;//声明变量val
void setup()
{
	pinMode(ledpin,OUTPUT);//设置数字11为输出模式
	Serial.begin(9600);//设定波特率为9600
}
void loop()
{
	val=analogRead(potpin);//读取A0的模拟电压值，并赋值到val
	val = 245- val/2;
        if(val < 0)
          val = 0;
	Serial.println(val);
	analogWrite(ledpin,val);// PWM输出驱动LED
	delay(100);//延时100ms
}
