int redled =10; //定义数字10 接口
int yellowled =7; //定义数字7 接口
int greenled =4; //定义数字4 接口
void setup()
{
  pinMode(redled, OUTPUT);//定义红色小灯接口为输出接口
  pinMode(yellowled, OUTPUT); //定义黄色小灯接口为输出接口
  pinMode(greenled, OUTPUT); //定义绿色小灯接口为输出接口
}
void loop()
{
  digitalWrite(redled, HIGH);//点亮红色小灯
  delay(1000);//延时1 秒
  digitalWrite(redled, LOW); //熄灭红色小灯
  digitalWrite(yellowled, HIGH);//点亮黄色小灯
  delay(200);//延时0.2 秒
  digitalWrite(yellowled, LOW);//熄灭黄色小灯
  digitalWrite(greenled, HIGH);//点亮绿色小灯
  delay(1000);//延时1 秒
  digitalWrite(greenled, LOW);//熄灭绿色小灯
}

