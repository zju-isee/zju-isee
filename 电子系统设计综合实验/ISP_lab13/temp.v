module LCD(reset_n,clk_50m,lcd_rs,lcd_rw,lcd_en,lcd_d);
input clk_50m,reset_n;
output lcd_rs,lcd_rw,lcd_en;
output [7:0] lcd_d;

reg clkhz,lcd_rs,lcd_rw;
reg [5:0] disp_count;
reg [7:0] lcd_d,state;
reg [255:0] data_in_buf;
reg [19:0] cnt;


parameter CLEAR         =8'b00000001;//清屏
parameter SETDDRAM      =8'b00000010;//设置 DDRAM地址
parameter SETFUNCTION   =8'b00000100;//工作方式设置
parameter SWITCHMODE    =8'b00001000;//显示状态设置
parameter SETMODE       =8'b00010000;//输入方式设置
parameter RETURNCURSOR  =8'b00100000;//光标归位
parameter SHIFT         =8'b01000000;//换行
parameter WRITERAM      =8'b10000000;//写DDRAM
parameter CUR_INC       =1;//完成一个字符码传送后，地址计数器AC自动加1
parameter CUR_NOSHIFT   =0; //显示不发生移位
parameter OPEN_DISPLAY  =1;//开显示
parameter OPEN_CUR      =0;//光标不显示
parameter BLANK_CUR     =0;//光标不闪烁
parameter DATAWIDTH8    =1;//数据总线的宽度设置为8位
parameter DATAWIDTH4    =0;//数据总线的宽度设置为4位
parameter TWOLINE       =1;//显示行数为2行
parameter ONELINE       =0;//显示行数为1行
parameter FONT5X10      =1;//显示格式为5*10点阵
parameter FONT5X8       =0;//显示格式为5*8点阵
parameter DATA_IN       ="    01234567        89ABCEDF    ";
//此 DATA_IN的前面4个字符、中间8个字符及后面4个字符均为空格
//注意:此句更换不同显示内容时可能超规模（占用宏单元个数超过LC4256V的256个)
//从50MHz系统时钟得到低频时钟clkhz
always @(posedge clk_50m)
    begin
        if(cnt==20'hfffff)
            begin
                cnt<=0;
                clkhz<=~clkhz;
            end
        else
            cnt<=cnt+1;
    end
assign lcd_en=clkhz;
//1602工作状态机
always @(posedge clkhz or negedge reset_n)
    if(!reset_n)//异步复位
        begin
            lcd_rs<=0;
            lcd_rw<=0;//写指令寄存器
            lcd_d<=8'b0000_0001;//清屏指令
            state<=CLEAR;
            disp_count<=6'b0;
        end
    else
        begin
            case(state)
                CLEAR://清屏
                    begin
                        lcd_rs<=0;
                        lcd_rw<=0;//写指令寄存器
                        lcd_d<=8'b0000_0001;//清屏指令
                        data_in_buf<=DATA_IN;
                        state<=SETDDRAM;
                    end
                SETDDRAM://地址设置
                    begin
                        lcd_rs<=0;
                        lcd_rw<=0;
                        lcd_d<=8'b1000_0000;//起始地址
                        state<=SETFUNCTION;
                    end
                SETFUNCTION://工作方式设置
                    begin
                        lcd_rs<=0;
                        lcd_rw<=0;
                        lcd_d[7:5]<=3'b001;
                        lcd_d[4]<=DATAWIDTH8;
                        lcd_d[3]<=TWOLINE;
                        lcd_d[2]<=FONT5X8;
                        lcd_d[1:0]<=2'b00;
                        state<=SWITCHMODE;
                    end
                SWITCHMODE://显示开关控制
                    begin
                        lcd_rs<=0;
                        lcd_rw<=0;
                        lcd_d[7:3]<=5'b00001;
                        lcd_d[2]<=OPEN_DISPLAY;
                        lcd_d[1]<=OPEN_CUR;
                        lcd_d[0]<=BLANK_CUR;
                        state<=SETMODE;
                    end
                SETMODE://设置输入模式
                    begin
                        lcd_rs<=0;
                        lcd_rw<=0;
                        lcd_d[7:2]<=6'b000001;
                        lcd_d[1]<=CUR_INC;
                        lcd_d[0]<=CUR_NOSHIFT;state<=WRITERAM;
                    end
                RETURNCURSOR://光标归位
                    begin
                        lcd_rs<=0;
                        lcd_rw<=0;
                        lcd_d<=8'b00000010;//归位指令设地址计数器AC=O;
                        //把光标及光标所在的字符回原点;DDRAM内容不变
                        state<=WRITERAM;
                    end
                SHIFT://换行后写DDRAM显示第二行第一个字符
                    begin
                        lcd_rs<=1;//数据
                        lcd_rw<=0;
                        lcd_d<=data_in_buf[255:248];
                        data_in_buf<=(data_in_buf<<8);//移位准备显示下一个字符
                        disp_count<=disp_count+1'b1;//已显示字符个数计数值加1
                        state<=WRITERAM;
                    end
                WRITERAM://写 DDRAM显示
                    begin
                        lcd_rs<=1;
                        lcd_rw<=0;
                        if(disp_count==32)
                            begin
                            disp_count<=4'b0;
                            state<=CLEAR;//显示完32个字符重新清屏显示
                            end
                        else if(disp_count==16)//16时先换行再写DDRAM显示，注意要做两件事
                            begin
                            lcd_rs<=0;//指令
                            lcd_rw<=0;
                            lcd_d<=8'b11000000; //16个字符发完换到第二行，地址40H
                            state<=SHIFT;
                            end
                        else
                            begin
                            lcd_d<=data_in_buf[255:248];
                            data_in_buf<=(data_in_buf<<8);
                            disp_count<=disp_count+1'b1;
                            state<=WRITERAM;
                            end
                    end
            endcase
        end

endmodule

