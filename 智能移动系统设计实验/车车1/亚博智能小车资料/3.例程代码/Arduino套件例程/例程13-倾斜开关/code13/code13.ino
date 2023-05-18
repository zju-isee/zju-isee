int switchpin = 5;
int ledpin = 8;
int val = 0;
void setup() 
{ 
pinMode(ledpin,OUTPUT);//数字IO8 输出模式
Serial.begin(9600);//设置串口波特率为9600
} 
void loop() 
{ 
        val = analogRead(switchpin);
	if(val>512)//模拟电压值512正好电压是2.5V 
		digitalWrite(ledpin,HIGH);//大于2.5V，拉高
	else//小于等于
		digitalWrite(ledpin,LOW);//拉低 
        Serial.println(val);
} 
