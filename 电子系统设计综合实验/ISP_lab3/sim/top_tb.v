//仿真的时候，请把clk_gen.v中的分频器的6000改为1000！（因为仿真文件的clk为了方便设置为1MHz，而板子是6MHz）

`timescale 100ns / 1ns

module top_level_tb;
  reg clk,ButtonIn,resetIn,clk_low;
  wire LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4, light_win;
  parameter delay=5;//仿真的时候设置为1MHz的clk，则为500ns clk反一次
  //每次按键时间长度>40ms(40ms/500ns=8*10^4个时间单位),前5ms(10^4个时间单位)和后5ms(10^4个时间单位)是抖动
  //而对于1kHz的pulse1kHz,1ms=2000个时间单位，前1998个时间单位为0,后2个为1
  //clk_low=128Hz,1/128=7.8ms=7800us=78000个100ns,故78000/5=15600个时间单位,每7800个时间单位反一次。
   initial begin
      clk = 0;clk_low=0;resetIn=0;ButtonIn = 1;
      #(delay*5+1) resetIn=0;
      #(delay*1) resetIn=1;
      #(delay*10000)//先留白一段时间   

      //取第1次随机数
       repeat (1000) //按键前抖动
         begin
           #(delay*5) ButtonIn=1;
           #(delay*5) ButtonIn=0;
         end
       #(delay*60000) //按键稳定时间
         repeat (1000)//按键后抖动
            begin
            #(delay*5) ButtonIn=0;
            #(delay*5) ButtonIn=1;
          end
       #(delay*50000) //休息时间

       //取第2次随机数
          repeat (1000) //按键前抖动
         begin
           #(delay*5) ButtonIn=1;
           #(delay*5) ButtonIn=0;
         end
       #(delay*60000) //按键稳定时间
         repeat (1000)//按键后抖动
            begin
            #(delay*5) ButtonIn=0;
            #(delay*5) ButtonIn=1;
          end
       #(delay*64033) //休息时间

       //取第3次随机数
          repeat (1000) //按键前抖动
         begin
           #(delay*5) ButtonIn=1;
           #(delay*5) ButtonIn=0;
         end
       #(delay*63664) //按键稳定时间
         repeat (1000)//按键后抖动
            begin
            #(delay*5) ButtonIn=0;
            #(delay*5) ButtonIn=1;
          end
       #(delay*50003) //休息时间

       //按一次复位键
          repeat (1000) //按键前抖动
         begin
           #(delay*5) resetIn=1;
           #(delay*5) resetIn=0;
         end
       #(delay*60000) //按键稳定时间
         repeat (1000)//按键后抖动
            begin
            #(delay*5) resetIn=0;
            #(delay*5) resetIn=1;
          end
      #(delay*64033) //休息时间

      //取第4次随机数
          repeat (1000) //按键前抖动
         begin
           #(delay*5) ButtonIn=1;
           #(delay*5) ButtonIn=0;
         end
       #(delay*63664) //按键稳定时间
         repeat (1000)//按键后抖动
            begin
            #(delay*5) ButtonIn=0;
            #(delay*5) ButtonIn=1;
          end
       $stop;
      end
 //     
    always #(delay) clk=~clk;
    always #(delay*7800) clk_low=~clk_low;
 //

top_level #(.sim(1)) top_level_inst(
    .clk(clk),
    .clk_low(clk_low),
    .resetIn(resetIn),
    .ButtonIn(ButtonIn),
    .LED_A(LED_A),
    .LED_B(LED_B),
    .LED_C(LED_C),
    .LED_D(LED_D),
    .LED_E(LED_E),
    .LED_F(LED_F),
    .LED_G(LED_G),
    .LED_VCC1(LED_VCC1),
    .LED_VCC2(LED_VCC2),
    .LED_VCC3(LED_VCC3),
    .LED_VCC4(LED_VCC4),
    .light_win(light_win));

endmodule
