int BASE = 2 ;  //第一颗 LED 接的 I/O 脚
int NUM = 6;   //LED 的总数
int i=0;
void setup()
{
   for (int i = BASE; i < BASE + NUM; i ++) 
   {
     pinMode(i, OUTPUT);   //设定数字I/O脚为输出
   }
}

void loop()
{
   for (i = BASE; i < BASE + NUM; i ++) 
   {
     digitalWrite(i, LOW);    //设定数字I/O脚出为"低"，即顺序熄灭
     delay(200);        //延时
   }
   for (i = BASE; i < BASE + NUM; i ++) 
   {
     digitalWrite(i, HIGH);    //设定数字I/O脚输出为"低"，即顺序点亮
     delay(200);        //延时
   }  
}

