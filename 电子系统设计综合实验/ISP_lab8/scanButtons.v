module scan_buttons(
    clk,clk_100Hz,key_in,key_out, led_int_Data0, led_int_Data1,led_int_Data2,reset_in
);
    input clk,clk_100Hz,reset_in;
    input [3:0] key_in;//key_in是已经消抖过的
    output[3:0] key_out, led_int_Data0, led_int_Data1,led_int_Data2;

    reg [3:0]  led_int_Data0, led_int_Data1,led_int_Data2;
    reg [4:0] int_Data;
    reg [3:0] key_out,int_Data0,int_Data1,scanvalue=4'b0001;
    reg [1:0] flag_Cal,flag_Data;
    reg PointTime;

    always@(posedge clk_100Hz or negedge reset_in)
    begin
        if(reset_in==0)
        begin
            scanvalue<=4'b0001;
            flag_Data<=0;
            flag_Cal<=0;
            int_Data0<=4'b0000;
            int_Data1<=4'b0000;
            PointTime<=1'b1;
            led_int_Data2<=10;
            int_Data<=5'b00000;
        end
        else
        begin
            key_out<=scanvalue;

            case(scanvalue)
                4'b0001:scanvalue<=4'b0010;
                4'b0010:scanvalue<=4'b0100;
                4'b0100:scanvalue<=4'b1000;
                4'b1000:scanvalue<=4'b0001;
                default:scanvalue<=4'b0001;
            endcase

            case({key_in,key_out})
                8'b00010001://键盘1
                    case(flag_Data)
                        0:begin led_int_Data2<=10;int_Data0<=1;int_Data<=1;flag_Data<=1; end
                        2:begin int_Data1<=1;int_Data<=1;flag_Data<=3;end
                    endcase
                8'b00100001://2
                    case(flag_Data)
                        0:begin led_int_Data2<=10;int_Data0<=2;int_Data<=2;flag_Data<=1; end
                        2:begin int_Data1<=2;int_Data<=2;flag_Data<=3;end
                    endcase
                8'b01000001://3
                    case(flag_Data)
                        0:begin led_int_Data2<=10;int_Data0<=3;int_Data<=3;flag_Data<=1; end
                        2:begin int_Data1<=3;int_Data<=3;flag_Data<=3;end
                    endcase
                8'b10000001:;//X

                8'b00010010://4
                    case(flag_Data)
                        0:begin led_int_Data2<=10;int_Data0<=4;int_Data<=4;flag_Data<=1; end
                        2:begin int_Data1<=4;int_Data<=4;flag_Data<=3;end
                    endcase
                8'b00100010://5
                    case(flag_Data)
                        0:begin led_int_Data2<=10;int_Data0<=5;int_Data<=5;flag_Data<=1; end
                        2:begin int_Data1<=5;int_Data<=5;flag_Data<=3;end
                    endcase
                8'b01000010://6
                    case(flag_Data)
                        0:begin led_int_Data2<=10;int_Data0<=6;int_Data<=6;flag_Data<=1; end
                        2:begin int_Data1<=6;int_Data<=6;flag_Data<=3;end
                    endcase
                8'b10000010:;//Y

                8'b00010100://7
                    case(flag_Data)
                        0:begin led_int_Data2<=10;int_Data0<=7;int_Data<=7;flag_Data<=1; end
                        2:begin int_Data1<=7;int_Data<=7;flag_Data<=3;end
                    endcase
                8'b00100100://8
                    case(flag_Data)
                        0:begin led_int_Data2<=10;int_Data0<=8;int_Data<=8;flag_Data<=1; end
                        2:begin int_Data1<=8;int_Data<=8;flag_Data<=3;end
                    endcase
                8'b01000100://9
                    case(flag_Data)
                        0:begin led_int_Data2<=10;int_Data0<=9;int_Data<=9;flag_Data<=1; end
                        2:begin int_Data1<=9;int_Data<=9;flag_Data<=3;end
                    endcase
                8'b10000100://Z
                    begin
                        flag_Data<=0;
                        int_Data0<=4'b0000;
                        int_Data1<=4'b0000;
                        PointTime<=1'b1;
                        led_int_Data2<=10;
                        int_Data<=5'b00000;
                    end

                8'b00011000://0
                    case(flag_Data)
                        0:begin led_int_Data2<=10;int_Data0<=0;int_Data<=0;flag_Data<=1; end
                        2:begin int_Data1<=0;int_Data<=0;flag_Data<=3;end
                    endcase
                8'b00101000://+
                    begin
                        if(flag_Data==1) 
                            begin 
                                flag_Cal<=1;
                                PointTime<=0;
                                flag_Data<=2;
                            end
                    end
                8'b01001000://-
                    begin
                        if(flag_Data==1) 
                            begin 
                                flag_Cal<=2;
                                PointTime<=0;
                                flag_Data<=2;
                            end
                    end
                8'b10001000://=
                    begin
                        case(flag_Cal)
                            1:begin 
                                int_Data<=int_Data0+int_Data1;
                                led_int_Data2<=10; 
                              end
                            2:begin 
                                if(int_Data0>=int_Data1)
                                    begin
                                        int_Data<=int_Data0-int_Data1;
                                        led_int_Data2<=10;
                                    end
                                else
                                    begin 
                                        int_Data<=int_Data1-int_Data0;
                                        led_int_Data2<=11;
                                    end
                              end
                            default:;
                        endcase

                        PointTime<=1;
                        flag_Cal<=0;
                        flag_Data<=0;
                    end

                default:;//无按键按下
            endcase
        end
    end

    always @(clk,reset_in)
    begin
        if(reset_in==0)
            begin 
                led_int_Data1<=0;
                led_int_Data0<=0;
            end
        else
            begin 
                if(int_Data>9)
                    begin
                        led_int_Data1<=1;
                        led_int_Data0<=int_Data-10;
                    end
                else
                    begin
                        led_int_Data1<=10;
                        led_int_Data0<=int_Data;
                    end
            end
    end
endmodule