module DECODE_MODULE(clk,reset,key_in,key_out,led);
    input clk,reset;
    input [3:0] key_in;
    output [3:0] key_out;
    output [4:0] led;

    reg [3:0] key_out;
    reg [4:0] led;
    reg [3:0] scanvalue;
    reg [7:0] combvalue;


    always @(posedge clk or negedge reset) //clk 为低频时钟源如128Hz\
    begin
        if(reset==0)
            begin
                scanvalue<=1;//scanvalue 记录扫描数据
                led<=5'b11111; //5 位 led 的亮灭显示对应所按下的键:其值为0时有效，LED 发亮
                combvalue<=0;//combvalue 为行扫描和列扫描的组合值
            end
        else
            begin//每若干ms进行一次键盘扫描
                key_out<=scanvalue;//输出扫描值: ey out 对应row 行
    //注意:对于未按下键时默认电平为0的阵列(如MAGIC3100)扫有效电平应取为1，例如0001:
    //对于未按下键时默认电平为1的阵列(如EDA-E )扫有效平应取为0，例如1110
    //请思为什么需要这样?
                case(scanvalue)
                    4'b0001:scanvalue<=4'b0010;
                    4'b0010:scanvalue<=4'b0100;
                    4'b0100:scanvalue<=4'b1000;
                    4'b1000:scanvalue<=4'b0001;
                    default:scanvalue<=4'b0001;
                endcase
                combvalue<={key_in,key_out};//key in 对应column列
                case(combvalue)
                    8'b00010001:led<=5'b11110; //对应键盘“1”
                    8'b00100001:led<=5'b11101;//对应键盘“2”
                    8'b01000001:led<=5'b11100;//对应键盘“3”
                    8'b10000001:led<=5'b11011;//对应键盘“X”
                    8'b00010010:led<=5'b11010;//对应键盘“4”
                    8'b00100010:led<=5'b11001; //对应键盘“5”
                    8'b01000010:led<=5'b11000;//对应键盘“6”
                    8'b10000010:led<=5'b10111;//对应键盘“Y”
                    8'b00010100:led<=5'b10110;//对应键盘“7”
                    8'b00100100:led<=5'b10101;//对应键盘“8”
                    8'b01000100:led<=5'b10100;//对应键盘“9”
                    8'b10000100:led<=5'b10011;//对应键盘“Z”
                    8'b00011000:led<=5'b10010;//对应键盘“0”
                    8'b00101000:led<=5'b10001;//对应键盘“+”
                    8'b01001000:led<=5'b10000;//对应键盘“_”/
                    8'b10001000:led<=5'b01111; //对应键盘“=”
                    default: led<=5'b11111;//无键盘按下，全部LED 灯都不亮
                endcase
            end
    end

endmodule
