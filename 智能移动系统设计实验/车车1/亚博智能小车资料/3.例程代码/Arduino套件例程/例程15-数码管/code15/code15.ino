int a=7;//数字IO口7 连接数码管a段
int b=6;//数字IO口6 连接数码管b段
int c=5;// 数字IO口5 连接数码管c段
int d=11;// 数字IO口11 连接数码管d段
int e=10;// 数字IO口10 连接数码管e段
int f=8;//数字IO口8 连接数码管f段
int g=9;// 数字IO口9连接数码管g段
int dp=4;// 数字IO口4 连接数码管小数点段
void digital_1(void) //显示数字1
{
	unsigned char j;
	digitalWrite(c,HIGH);//点亮c段
	digitalWrite(b,HIGH);//点亮b段
	for(j=7;j<=11;j++)//7~11口相应段拉低：a,f,g,e,d
		digitalWrite(j,LOW);
	digitalWrite(dp,LOW);//小数点不点亮
}
void digital_2(void) //显示数字2
{
unsigned char j;
digitalWrite(b,HIGH);
digitalWrite(a,HIGH);
for(j=9;j<=11;j++)
digitalWrite(j,HIGH);
digitalWrite(dp,LOW);
digitalWrite(c,LOW);
digitalWrite(f,LOW);
}
void digital_3(void) //显示数字3
{
unsigned char j;
digitalWrite(g,HIGH);
digitalWrite(d,HIGH);
for(j=5;j<=7;j++)
digitalWrite(j,HIGH);
digitalWrite(dp,LOW);
digitalWrite(f,LOW);
digitalWrite(e,LOW);
}
void digital_4(void) //显示数字4
{
digitalWrite(c,HIGH);
digitalWrite(b,HIGH);
digitalWrite(f,HIGH);
digitalWrite(g,HIGH);
digitalWrite(dp,LOW);
digitalWrite(a,LOW);
digitalWrite(e,LOW);
digitalWrite(d,LOW);
}
void digital_5(void) //显示数字5
{
unsigned char j;
for(j=7;j<=9;j++)
digitalWrite(j,HIGH);
digitalWrite(c,HIGH);
digitalWrite(d,HIGH);
digitalWrite(dp,LOW);
digitalWrite(b,LOW);
digitalWrite(e,LOW);
}
void digital_6(void) //显示数字6
{
unsigned char j;
for(j=7;j<=11;j++)
digitalWrite(j,HIGH);
digitalWrite(c,HIGH);
digitalWrite(dp,LOW);
digitalWrite(b,LOW);
}
void digital_7(void) //显示数字7
{
unsigned char j;
for(j=5;j<=7;j++)
digitalWrite(j,HIGH);
digitalWrite(dp,LOW);
for(j=8;j<=11;j++)
digitalWrite(j,LOW);
}
void digital_8(void) //显示数字8
{
unsigned char j;
for(j=5;j<=11;j++)
digitalWrite(j,HIGH);
digitalWrite(dp,LOW);
}

void digital_9(void) //显示数字9
{
digitalWrite(a,HIGH);
digitalWrite(b,HIGH);
digitalWrite(c,HIGH);
digitalWrite(d,HIGH);
digitalWrite(e,LOW);
digitalWrite(f,HIGH);
digitalWrite(g,HIGH);
digitalWrite(dp,HIGH);
}
void setup()
{
	int i;//变量声明
	for(i=4;i<=11;i++)
		pinMode(i,OUTPUT);//设置4-11为输出口
}
void loop()
{
  while(1)
  {
    digital_1();//显示数字1
    delay(1000);//延时1s
    digital_2();//显示数字2
    delay(1000); //延时1s
    digital_3();//显示数字3
    delay(1000); //延时1s
    digital_4();//显示数字4
    delay(1000); //延时1s
    digital_5();//显示数字5
    delay(1000); //延时1s
    digital_6();//显示数字6
    delay(1000); //延时1s
    digital_7();//显示数字7
    delay(1000); //延时1s
    digital_8();//显示数字8
    delay(1000); //延时1s
    digital_9();//显示数字9
    delay(1000); //延时1s
  }
}
