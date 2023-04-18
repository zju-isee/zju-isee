#define SEG_A 2  //Arduino Pin2--->SegLed Pin11
#define SEG_B 3  //Arduino Pin3--->SegLed Pin7
#define SEG_C 4  //Arduino Pin4--->SegLed Pin4
#define SEG_D 5  //Arduino Pin5--->SegLed Pin2
#define SEG_E 6  //Arduino Pin6--->SegLed Pin1
#define SEG_F 7  //Arduino Pin7--->SegLed Pin10
#define SEG_G 8  //Arduino Pin8--->SegLed Pin5    
#define SEG_H 9  //Arduino Pin9--->SegLed Pin3

#define COM1 10  //Arduino Pin10--->SegLed Pin12
#define COM2 11  //Arduino Pin11--->SegLed Pin9
#define COM3 12  //Arduino Pin12--->SegLed Pin8
#define COM4 13  //Arduino Pin13--->SegLed Pin6


unsigned char table[10][8] =                
{
	{0,	0,	1,	1,	1,	1,	1,	1},			//0
	{0,	0,	0,	0,	0,	1,	1,	0},			//1
	{0,	1,	0,	1,	1,	0,	1,	1},			//2
	{0,	1,	0,	0,	1,	1,	1,	1},			//3
	{0,	1,	1,	0,	0,	1,	1,	0},			//4
	{0,	1,	1,	0,	1,	1,	0,	1},			//5
	{0,	1,	1,	1,	1,	1,	0,	1},			//6
	{0,	0,	0,	0,	0,	1,	1,	1},			//7
	{0,	1,	1,	1,	1,	1,	1,	1},			//8
	{0,	1,	1,	0,	1,	1,	1,	1}			//9
};

void setup()
{
	pinMode(SEG_A,OUTPUT);		//设置为输出引脚
	pinMode(SEG_B,OUTPUT);
	pinMode(SEG_C,OUTPUT);
	pinMode(SEG_D,OUTPUT);
	pinMode(SEG_E,OUTPUT);
	pinMode(SEG_F,OUTPUT);
	pinMode(SEG_G,OUTPUT);
	pinMode(SEG_H,OUTPUT);

	pinMode(COM1,OUTPUT);
	pinMode(COM2,OUTPUT);
	pinMode(COM3,OUTPUT);
	pinMode(COM4,OUTPUT);
}

void loop()
{
	Display(1,1);			//第1位显示1
	delay(500);
	Display(2,2);			//第2位显示2
	delay(500);
	Display(3,3);			//第3位显示3
	delay(500);
	Display(4,4);			//第4位显示4
	delay(500);
}

void Display(unsigned char com,unsigned char num)
{
	digitalWrite(SEG_A,LOW);			//去除余晖
	digitalWrite(SEG_B,LOW);
	digitalWrite(SEG_C,LOW);
	digitalWrite(SEG_D,LOW);
	digitalWrite(SEG_E,LOW);
	digitalWrite(SEG_F,LOW);
	digitalWrite(SEG_G,LOW);
	digitalWrite(SEG_H,LOW);

	switch(com)						//选通位选
	{
		case 1:
			digitalWrite(COM1,LOW);		//选择位1
			digitalWrite(COM2,HIGH);
			digitalWrite(COM3,HIGH);
			digitalWrite(COM4,HIGH);
			break;
		case 2:
			digitalWrite(COM1,HIGH);
			digitalWrite(COM2,LOW);		//选择位2
			digitalWrite(COM3,HIGH);
			digitalWrite(COM4,HIGH);
			break;
		case 3:
			digitalWrite(COM1,HIGH);
			digitalWrite(COM2,HIGH);
			digitalWrite(COM3,LOW);		//选择位3
			digitalWrite(COM4,HIGH);
			break;
		case 4:
			digitalWrite(COM1,HIGH);
			digitalWrite(COM2,HIGH);
			digitalWrite(COM3,HIGH);
			digitalWrite(COM4,LOW);		//选择位4
			break;
		default:break;
	}

	digitalWrite(SEG_A,table[num][7]);			//a查询码值表
	digitalWrite(SEG_B,table[num][6]);
	digitalWrite(SEG_C,table[num][5]);
	digitalWrite(SEG_D,table[num][4]);
	digitalWrite(SEG_E,table[num][3]);
	digitalWrite(SEG_F,table[num][2]);
	digitalWrite(SEG_G,table[num][1]);
	digitalWrite(SEG_H,table[num][0]);
}
