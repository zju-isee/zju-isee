#include <IRremote.h>//包含红外库
int RECV_PIN = 11;//端口声明
int LED1 = 2;
int LED2 = 3;
int LED3 = 4;
int LED4 = 5;
int LED5 = 6;
int LED6 = 7;
long on1  = 0x00FF6897;//编码示例,与发送匹配用
long off1 = 0x00ff30CF;
long on2 = 0x00FF9867;
long off2 = 0x00FF18E7;
long on3 = 0x00FFB04F;
long off3 = 0x00FF7A85;
long on4 = 0x00FF10EF;
long off4 = 0x00FF42BD;
long on5 = 0x00FF38C7;
long off5 = 0x00FF4AB5;
long on6 = 0x00FF5AA5;
long off6 = 0x00FF52AD;
IRrecv irrecv(RECV_PIN);
decode_results results;//结构声明
// Dumps out the decode_results structure.
// Call this after IRrecv::decode()
// void * to work around compiler issue
//void dump(void *v) {
//  decode_results *results = (decode_results *)v
void dump(decode_results *results)
{
	int count = results->rawlen;
	if (results->decode_type == UNKNOWN) 
	{
		Serial.println("Could not decode message");
	} 
	else 
	{
		if (results->decode_type == NEC) 
		{
			Serial.print("Decoded NEC: ");
		} 
		else if (results->decode_type == SONY) 
				{
					Serial.print("Decoded SONY: ");
				} 
				else if (results->decode_type == RC5) 
						{
							Serial.print("Decoded RC5: ");
						} 
						else if (results->decode_type == RC6) 
								{
									Serial.print("Decoded RC6: ");
								}
		Serial.print(results->value, HEX);
		Serial.print(" (");
		Serial.print(results->bits, DEC);
		Serial.println(" bits)");
	}
		Serial.print("Raw (");
		Serial.print(count, DEC);
		Serial.print("): ");

	  	for (int i = 0; i < count; i++) 
	     {
			if ((i % 2) == 1) 
			{
				Serial.print(results->rawbuf[i]*USECPERTICK, DEC);
			} 
			else  
			{
				Serial.print(-(int)results->rawbuf[i]*USECPERTICK, DEC);
			}
			Serial.print(" ");
		}
		Serial.println("");
}

void setup()
{
	pinMode(RECV_PIN, INPUT);   //端口模式，输入
	pinMode(LED1, OUTPUT);//端口模式，输出
	pinMode(LED2, OUTPUT);//端口模式，输出
	pinMode(LED3, OUTPUT);//端口模式，输出
	pinMode(LED4, OUTPUT);//端口模式，输出
	pinMode(LED5, OUTPUT);//端口模式，输出
	pinMode(LED6, OUTPUT);//端口模式，输出
	pinMode(13, OUTPUT);////端口模式，输出
	Serial.begin(9600);	//波特率9600
	irrecv.enableIRIn(); // Start the receiver
}

int on = 0;
unsigned long last = millis();

void loop() 
{
  if (irrecv.decode(&results)) //调用库函数：解码
   {
    // If it's been at least 1/4 second since the last
    // IR received, toggle the relay
    if (millis() - last > 250) 
      {
       on = !on;
       digitalWrite(13, on ? HIGH : LOW);
       dump(&results);
      }
    if (results.value == on1 )
       digitalWrite(LED1, HIGH);
    if (results.value == off1 )
       digitalWrite(LED1, LOW); 
    if (results.value == on2 )
       digitalWrite(LED2, HIGH);
    if (results.value == off2 )
       digitalWrite(LED2, LOW); 
    if (results.value == on3 )
       digitalWrite(LED3, HIGH);
    if (results.value == off3 )
       digitalWrite(LED3, LOW);
    if (results.value == on4 )
       digitalWrite(LED4, HIGH);
    if (results.value == off4 )
       digitalWrite(LED4, LOW); 
    if (results.value == on5 )
       digitalWrite(LED5, HIGH);
    if (results.value == off5 )
       digitalWrite(LED5, LOW); 
    if (results.value == on6 )
       digitalWrite(LED6, HIGH);
    if (results.value == off6 )
       digitalWrite(LED6, LOW);        
    last = millis();      
    irrecv.resume(); // Receive the next value
  }
}
