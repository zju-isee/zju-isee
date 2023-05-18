#include <SoftwareSerial.h>   // 软件串口
SoftwareSerial BT(0,1); // 8设为单片机的接受端RX，接蓝牙的TX;9为单片机的发送端TX，所以接蓝牙的RX
char val;  //存储数据
void setup() {
  Serial.begin(9600);   // 和电脑连接的串口波特率
  Serial.println("BT is ready!");
  BT.begin(9600);
}
 
void loop() {
  if (Serial.available()) {
    val = Serial.read();
    BT.print(val);
  }
  if (BT.available()) {
    val = BT.read();
    Serial.print(val);
  }
}
