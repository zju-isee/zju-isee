`timescale 100ns / 1ns

module button_press_tb;
  reg clk,ButtonIn,reset,pulse1kHz;
  wire ButtonOut;
  parameter delay=5;//仿真的时候设置为1MHz的clk，则为500ns clk反一次
  //每次按键时间长度>40ms(40ms/500ns=8*10^4个时间单位),前5ms(10^4个时间单位)和后5ms(10^4个时间单位)是抖动
  //而对于1kHz的pulse1kHz,1ms=2000个时间单位，前1998个时间单位为0,后2个为1
   initial begin
      clk = 0;	reset=1;	ButtonIn = 1; pulse1kHz=0;
      #(delay+1) reset=0;
      #(delay*10000)//先留白一段时间   
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
       #(delay*60000) //按键稳定时间
         repeat (1000)//按键后抖动
            begin
            #(delay*5) ButtonIn=0;
            #(delay*5) ButtonIn=1;
          end
       #(delay*50000) //休息时间
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
       #(delay*10000) 
       $stop;
      end
 //     
    always #(delay) clk=~clk;
    always 
    begin
      pulse1kHz=0;
      #(delay*1998);
      pulse1kHz=1;
      #(delay*2);
    end
 //

button button_inst(
  .clk(clk),
  .reset(reset),
  .ButtonIn(ButtonIn),
  .ButtonOut(ButtonOut),
  .pulse1kHz(pulse1kHz)
   );

endmodule
