module CALCULATE(clk,reset,key_in,PointTime,led_int_Data0,led_int_Data1,led_int_Data2,key_out);

    input clk,reset;
    input [3:0] key_in;
    output PointTime;
    output [3:0] led_int_Data0;
    output [3:0] led_int_Data1;
    output [3:0] led_int_Data2;
    output [3:0] key_out;



    reg [16:0] timecnt;
    reg time10ms;
    reg [3:0] scanvalue;
    reg [3:0] flag_Data;
    reg flag_Over;
    reg [1:0] flag_Cal;
    reg [7:0] int_Data0;
    reg [7:0] int_Data1;
    reg  PointTime;
    reg [7:0] int_Data;
    reg [3:0] key_out;
    reg [3:0] led_int_Data0,led_int_Data1,led_int_Data2;


    //产生10ms时钟的进程
    always @(posedge clk or negedge reset) //clk 为系统时钟信号 6MHz
    begin
        if(reset==1'b0)timecnt<=0; //timecnt 为分频计数器，用来得到10ms 时钟
        else if(timecnt==29999)
            begin
                time10ms<=~time10ms; //timel0ms 为10ms 时钟
                timecnt<=0;
            end
        else timecnt<=timecnt+1;
    end
    //键盘扫描进程
    always @(posedge time10ms or negedge reset)
    begin
        if(reset==0)
            begin
                scanvalue<=1;//scanvalue 用于记录扫描数据
                flag_Data<=0;//flag Data 为输入数据顺序标志
                flag_Over<=0;//flag Over 为完成计算标志
                flag_Cal<=0;//flag Cal用于标记运算方式，1一加法，2一减法
                int_Data0<=0;
                int_Data1<=0;//int Data0 和int Datal为待运算的两个整数
                PointTime<=1;//PintTime 为数码管中间的“;”，在这里用于指示“+”或“_”运算符的输入
                led_int_Data2<=10;
                //led int Data2 为送去第2 个数码管显示的数据，为 10 表示正数不显示，为11 表示负数显示“
                int_Data<=0;//int Data 为运算结果
            end
        else
            begin
                key_out<=scanvalue;//输出扫描值
                case(scanvalue)//扫描值移位
                    4'b0001: scanvalue<=4'b0010;
                    4'b0010: scanvalue<=4'b0100;
                    4'b0100: scanvalue<=4'b1000;
                    4'b1000: scanvalue<=4'b0001;
                    default: scanvalue<=4'b0001;
                endcase
                case({key_in,key_out})//铺译扫描结果
                    8'b00010001://对应键盘“1”
                        begin
                            case(flag_Data)
                                0: begin led_int_Data2<=10;int_Data0<=1;int_Data<=1;flag_Data<=1; end //第 1 个数
                                2: begin int_Data1<=1;int_Data<=1;flag_Data<=3; end //第 2个数default::
                            endcase
                        end
                    8'b00100001://对应键盘“2”
                        begin
                            case(flag_Data)
                                0: begin led_int_Data2<=10;int_Data0<=2;int_Data<=2;flag_Data<=1; end //第 1个数
                                2: begin int_Data1<=2;int_Data<=2;flag_Data<=3;end //第2个数
                                default:;
                            endcase
                        end
                    //对应键盘“3”到“g”及“0”的源代码与1和2类似，注意行列扫描码的不同即可，故略
                    8'b01000001://对应键盘“3”
                        begin
                            case(flag_Data)
                                0: begin led_int_Data2<=10;int_Data0<=3;int_Data<=3;flag_Data<=1; end //第 1个数
                                2: begin int_Data1<=3;int_Data<=3;flag_Data<=3;end //第2个数
                                default:;
                            endcase
                        end
                    8'b00010010://对应键盘“4”
                        begin
                            case(flag_Data)
                                0: begin led_int_Data2<=10;int_Data0<=4;int_Data<=4;flag_Data<=1; end //第 1个数
                                2: begin int_Data1<=4;int_Data<=4;flag_Data<=3;end //第2个数
                                default:;
                            endcase
                        end
                    8'b00100010://对应键盘“5”
                        begin
                            case(flag_Data)
                                0: begin led_int_Data2<=10;int_Data0<=5;int_Data<=5;flag_Data<=1; end //第 1个数
                                2: begin int_Data1<=5;int_Data<=5;flag_Data<=3;end //第2个数
                                default:;
                            endcase
                        end
                    8'b01000010://对应键盘“6”
                        begin
                            case(flag_Data)
                                0: begin led_int_Data2<=10;int_Data0<=6;int_Data<=6;flag_Data<=1; end //第 1个数
                                2: begin int_Data1<=6;int_Data<=6;flag_Data<=3;end //第2个数
                                default:;
                            endcase
                        end
                    8'b00010100://对应键盘“7”
                        begin
                            case(flag_Data)
                                0: begin led_int_Data2<=10;int_Data0<=7;int_Data<=7;flag_Data<=1; end //第 1个数
                                2: begin int_Data1<=7;int_Data<=7;flag_Data<=3;end //第2个数
                                default:;
                            endcase
                        end
                    8'b00100100://对应键盘“8”
                        begin
                            case(flag_Data)
                                0: begin led_int_Data2<=10;int_Data0<=8;int_Data<=8;flag_Data<=1; end //第 1个数
                                2: begin int_Data1<=8;int_Data<=8;flag_Data<=3;end //第2个数
                                default:;
                            endcase
                        end
                    8'b01000100://对应键盘“9”
                        begin
                            case(flag_Data)
                                0: begin led_int_Data2<=10;int_Data0<=9;int_Data<=9;flag_Data<=1; end //第 1个数
                                2: begin int_Data1<=9;int_Data<=9;flag_Data<=3;end //第2个数
                                default:;
                            endcase
                        end
                    8'b00011000://对应键盘“0”
                        begin
                            case(flag_Data)
                                0: begin led_int_Data2<=10;int_Data0<=0;int_Data<=0;flag_Data<=1; end //第 1个数
                                2: begin int_Data1<=0;int_Data<=0;flag_Data<=3;end //第2个数
                                default:;
                            endcase
                        end
                    8'b10000001://对应键盘“X”
                        begin
                            if(flag_Data == 1) begin flag_Cal<=3; PointTime <= 0; flag_Data<=2; end
                            end
                    8'b10000010:;//对应键盘“Y”
                    8'b10000100://对应键盘“Z”，复位
                        begin
                            flag_Over<=0;
                            flag_Data<=0;
                            int_Data0<=0;
                            int_Data1<=0;
                            PointTime<=1;
                            led_int_Data2<=10;
                            int_Data<=0;
                        end
                    8'b00101000://对应键盘“+”，准备做加法
                        begin
                            if(flag_Data==1) begin flag_Cal<=1;PointTime<=0;flag_Data<=2;end
                        end
                    8'b01001000://对应键盘“-“，准各做减法
                        begin
                            if(flag_Data==1) begin flag_Cal<=2;PointTime<=0;flag_Data<=2; end
                        end
                    8'b10001000://对应键盘“=”，进行运算
                        begin
                            case(flag_Cal)
                                1: begin int_Data<=int_Data0+int_Data1;led_int_Data2<=10; end //加法
                                2: begin
                                    if(int_Data0>=int_Data1)
                                        begin
                                            int_Data<=int_Data0-int_Data1;led_int_Data2<=10;//减法，差为正数，第 2个数码管不显示表示正数《为 10 时设计译码使对应数码管全暗)
                                        end
                                    else
                                        begin
                                            int_Data<=int_Data1-int_Data0;led_int_Data2<=11;//减法，差为负数，第 2 个数码管显示“_”号表示负数(为11 时设计译码使对应数码管显示“"”)
                                        end
                                    end
                                3: begin //乘法
                                    int_Data<=int_Data0*int_Data1; led_int_Data2<=10; 
                                    end
                                default:;
                            endcase
                            PointTime<=1;
                            flag_Cal<=0;
                            flag_Data<=0;
                        end
                    default:;//无键盘按下
                endcase
            end
    end
    //给数码管传输数据
    //其中数码管显示译码部分略，参见实验二中的数码管扫描显示原理
    always @(posedge clk or negedge reset)
    begin
        if(reset==0)
            begin
                led_int_Data1<=0;led_int_Data0<=0;//第1个数码管不显示，第3、4 个数码管为0
            end
        else
            begin
                if(int_Data>9 && int_Data <20)
                    begin
                        led_int_Data1<=1;led_int_Data0<=int_Data-10;//分解成BCD码
                    end
                else if(int_Data>19 && int_Data <30)
                    begin
                        led_int_Data1<=2;led_int_Data0<=int_Data-20;//分解成BCD码
                    end
                else if(int_Data>29 && int_Data <40)
                    begin
                        led_int_Data1<=3;led_int_Data0<=int_Data-30;//分解成BCD码
                    end
                else if(int_Data>39 && int_Data <50)
                    begin
                        led_int_Data1<=4;led_int_Data0<=int_Data-40;//分解成BCD码
                    end
                else if(int_Data>49 && int_Data <60)
                    begin
                        led_int_Data1<=5;led_int_Data0<=int_Data-50;//分解成BCD码
                    end
                else if(int_Data>59 && int_Data <70)
                    begin
                        led_int_Data1<=6;led_int_Data0<=int_Data-60;//分解成BCD码
                    end
                else if(int_Data>69 && int_Data <80)
                    begin
                        led_int_Data1<=7;led_int_Data0<=int_Data-70;//分解成BCD码
                    end
                else if(int_Data>79 && int_Data <90)
                    begin
                        led_int_Data1<=8;led_int_Data0<=int_Data-80;//分解成BCD码
                    end
                else
                    begin
                        led_int_Data1<=10;//第3 个数码管不显示
                        led_int_Data0<=int_Data;
                    end
            end
    end



endmodule
