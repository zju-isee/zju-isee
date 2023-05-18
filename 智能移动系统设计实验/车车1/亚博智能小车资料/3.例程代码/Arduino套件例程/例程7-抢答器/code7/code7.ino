int redled=10;	//set IO 10 to red LED
int yellowled=9;//set IO 10 to yellow LED
int greenled=8;//set IO 10 to green LED
int redpin=7;    //red key pin  IO 7
int yellowpin=6;//yellow key pin  IO 6
int greenpin=5;//green key pin  IO 5
int red;    //变量声明
int yellow;//变量声明
int green;//变量声明
void setup()
{
  pinMode(redled,OUTPUT);    //set as output
  pinMode(yellowled,OUTPUT);  //set as output
  pinMode(greenled,OUTPUT);  //set as output
  pinMode(redpin,INPUT);     //set as input
  pinMode(yellowpin,INPUT);  //set as input
  pinMode(greenpin,INPUT);  //set as input
}
void loop()
{
  red=digitalRead(redpin);//读取按键状态
  if(red==LOW)			//按键状态为低
  { digitalWrite(redled,LOW);}//LED熄灭
  else				//按键状态为高
  { digitalWrite(redled,HIGH);}//LED点亮
  
  yellow=digitalRead(yellowpin);
  if(yellow==LOW)
  { digitalWrite(yellowled,LOW);}
  else
  { digitalWrite(yellowled,HIGH);}
  
  green=digitalRead(greenpin);
  if(green==LOW)
  { digitalWrite(greenled,LOW);}
  else
  { digitalWrite(greenled,HIGH);}
}

