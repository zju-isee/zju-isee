int flame=A5;//声明模拟口A5
 int Beep=8;//声明数字口8
 int val=0;//定义变量
void setup() 
{
	pinMode(Beep,OUTPUT);//数字口输出模式
	pinMode(flame,INPUT);//模拟口输入模式
	Serial.begin(9600);//波特率9600 
	val=analogRead(flame);//读取一次模拟口电压
}
 
void loop() 
{  
	Serial.println(analogRead(flame));//串口发送模拟电压值
	if((analogRead(flame)-val)>=600)//判断模拟电压值是否大于600
		digitalWrite(Beep,HIGH); 
        else
                digitalWrite(Beep,LOW);
 }
