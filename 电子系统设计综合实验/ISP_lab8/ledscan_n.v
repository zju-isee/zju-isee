/*
该模块为n位数码管（n<=4）的数码管动态扫描电路

*/
module LEDscan(clk, reset,scancnt, Data0, Data1, Data2, Data3, LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4);


input clk,reset;
input [3:0] Data0,Data1,Data2,Data3;
input [1:0] scancnt;

output LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, LED_VCC1, LED_VCC2, LED_VCC3,LED_VCC4;


reg LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, LED_VCC1, LED_VCC2, LED_VCC3,LED_VCC4;

always @(posedge clk)
begin
    if(reset== 1'b1)
        begin //四位数码管
            LED_A=1 ;LED_B=1 ;LED_C=1 ;LED_D=1 ;LED_E=1 ;LED_F=1 ;LED_G=1;
            LED_VCC1=0;LED_VCC2=0;LED_VCC3=0;LED_VCC4=0;
            //LED_A, LED_B 等数码管的7段码信号
            //LED_VCCI, LED_VCC2, LED_VCC3, LED_VCC4分别为千位、百位、十位、个位数码管片选信号
        end
    else if(scancnt==2'b00)//注意：单就实验二而言、并不需要scancnt变量及其值为1,2,3的以下几段代码
        begin //个位数码管显示数字1，注意LED_VCC4=1
        case(Data0)
            0:begin
                LED_A=0;LED_B=0;LED_C=0;LED_D=0;LED_E=0;LED_F=0;LED_G=1;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=0;LED_VCC4=1;end
            1:begin
                LED_A=1;LED_B=0;LED_C=0;LED_D=1;LED_E=1;LED_F=1;LED_G=1;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=0;LED_VCC4=1;end
            2:begin
                LED_A=0;LED_B=0;LED_C=1;LED_D=0;LED_E=0;LED_F=1;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=0;LED_VCC4=1 ;end
            3:begin
                LED_A=0;LED_B=0;LED_C=0;LED_D=0;LED_E=1;LED_F=1;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=0;LED_VCC4=1;end
            4:begin
                LED_A=1;LED_B=0;LED_C=0;LED_D=1;LED_E=1;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=0;LED_VCC4=1;end
            5:begin
                LED_A=0;LED_B=1;LED_C=0;LED_D=0;LED_E=1;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=0;LED_VCC4=1;end
            6:begin
                LED_A=0;LED_B=1 ;LED_C=0;LED_D=0;LED_E=0;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=0;LED_VCC4=1;end
            7:begin
                LED_A=0;LED_B=0;LED_C=0;LED_D=1;LED_E=1;LED_F=1;LED_G=1;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=0;LED_VCC4=1;end
            8:begin
                LED_A =0;LED_B=0;LED_C=0;LED_D=0;LED_E=0;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=0;LED_VCC4=1;end
            9:begin
                LED_A =0;LED_B=0;LED_C=0;LED_D=0;LED_E=1 ;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=0;LED_VCC4=1;end
            default:begin //~li!=bif:i:B~
                LED_A=1;LED_B=1;LED_C=1;LED_D=1;LED_E=1;LED_F=1;LED_G=1;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=0;LED_VCC4=1;end
        endcase
        end
    else if(scancnt==2'b01)
        begin //十位数码管显示数字2, 注意 LED_ VCC3=1
        case(Data1) //Datal 为十位数码管待显示的数字
            0:begin
                LED_A=0;LED_B=0;LED_C=0;LED_D=0;LED_E=0;LED_F=0;LED_G=1;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=1;LED_VCC4=0;end
            1:begin
                LED_A=1;LED_B=0;LED_C=0;LED_D=1;LED_E=1;LED_F=1;LED_G=1;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=1;LED_VCC4=0;end
            2:begin
                LED_A=0;LED_B=0;LED_C=1;LED_D=0;LED_E=0;LED_F=1;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=1;LED_VCC4=0 ;end
            3:begin
                LED_A=0;LED_B=0;LED_C=0;LED_D=0;LED_E=1;LED_F=1;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=1;LED_VCC4=0;end
            4:begin
                LED_A=1;LED_B=0;LED_C=0;LED_D=1;LED_E=1;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=1;LED_VCC4=0;end
            5:begin
                LED_A=0;LED_B=1;LED_C=0;LED_D=0;LED_E=1;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=1;LED_VCC4=0;end
            6:begin
                LED_A=0;LED_B=1 ;LED_C=0;LED_D=0;LED_E=0;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=1;LED_VCC4=0;end
            7:begin
                LED_A=0;LED_B=0;LED_C=0;LED_D=1;LED_E=1;LED_F=1;LED_G=1;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=1;LED_VCC4=0;end
            8:begin
                LED_A =0;LED_B=0;LED_C=0;LED_D=0;LED_E=0;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=1;LED_VCC4=0;end
            9:begin
                LED_A =0;LED_B=0;LED_C=0;LED_D=0;LED_E=1 ;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=1;LED_VCC4=0;end
            default:begin
                LED_A=1;LED_B=1;LED_C=1;LED_D=1;LED_E=1;LED_F=1;LED_G=1;
                LED_VCC1=0;LED_VCC2=0;LED_VCC3=1;LED_VCC4=0;end
        endcase
        end
    else if(scancnt==2'b10)
        begin //百位数码管, 注意 LED_ VCC2=1
        case(Data2) //Data2 为百位数码管待显示的数字
            0:begin
                LED_A=0;LED_B=0;LED_C=0;LED_D=0;LED_E=0;LED_F=0;LED_G=1;
                LED_VCC1=0;LED_VCC2=1;LED_VCC3=0;LED_VCC4=0;end
            1:begin
                LED_A=1;LED_B=0;LED_C=0;LED_D=1;LED_E=1;LED_F=1;LED_G=1;
                LED_VCC1=0;LED_VCC2=1;LED_VCC3=0;LED_VCC4=0;end
            2:begin
                LED_A=0;LED_B=0;LED_C=1;LED_D=0;LED_E=0;LED_F=1;LED_G=0;
                LED_VCC1=0;LED_VCC2=1;LED_VCC3=0;LED_VCC4=0 ;end
            3:begin
                LED_A=0;LED_B=0;LED_C=0;LED_D=0;LED_E=1;LED_F=1;LED_G=0;
                LED_VCC1=0;LED_VCC2=1;LED_VCC3=0;LED_VCC4=0;end
            4:begin
                LED_A=1;LED_B=0;LED_C=0;LED_D=1;LED_E=1;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=1;LED_VCC3=0;LED_VCC4=0;end
            5:begin
                LED_A=0;LED_B=1;LED_C=0;LED_D=0;LED_E=1;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=1;LED_VCC3=0;LED_VCC4=0;end
            6:begin
                LED_A=0;LED_B=1 ;LED_C=0;LED_D=0;LED_E=0;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=1;LED_VCC3=0;LED_VCC4=0;end
            7:begin
                LED_A=0;LED_B=0;LED_C=0;LED_D=1;LED_E=1;LED_F=1;LED_G=1;
                LED_VCC1=0;LED_VCC2=1;LED_VCC3=0;LED_VCC4=0;end
            8:begin
                LED_A =0;LED_B=0;LED_C=0;LED_D=0;LED_E=0;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=1;LED_VCC3=0;LED_VCC4=0;end
            9:begin
                LED_A =0;LED_B=0;LED_C=0;LED_D=0;LED_E=1 ;LED_F=0;LED_G=0;
                LED_VCC1=0;LED_VCC2=1;LED_VCC3=0;LED_VCC4=0;end
            11:begin//负号
                LED_A =1;LED_B=1;LED_C=1;LED_D=1;LED_E=1 ;LED_F=1;LED_G=0;
                LED_VCC1=0;LED_VCC2=1;LED_VCC3=0;LED_VCC4=0;end
            default:begin
                LED_A=1;LED_B=1;LED_C=1;LED_D=1;LED_E=1;LED_F=1;LED_G=1;
                LED_VCC1=0;LED_VCC2=1;LED_VCC3=0;LED_VCC4=0;end
        endcase
        end
    else if(scancnt==2'b11)
        begin //千位数码管显示, 注意 LED_ VCC1=1
        case(Data3) 
            0:begin
                LED_A=0;LED_B=0;LED_C=0;LED_D=0;LED_E=0;LED_F=0;LED_G=1;
                LED_VCC1=1;LED_VCC2=0;LED_VCC3=0;LED_VCC4=0;end
            1:begin
                LED_A=1;LED_B=0;LED_C=0;LED_D=1;LED_E=1;LED_F=1;LED_G=1;
                LED_VCC1=1;LED_VCC2=0;LED_VCC3=0;LED_VCC4=0;end
            2:begin
                LED_A=0;LED_B=0;LED_C=1;LED_D=0;LED_E=0;LED_F=1;LED_G=0;
                LED_VCC1=1;LED_VCC2=0;LED_VCC3=0;LED_VCC4=0 ;end
            3:begin
                LED_A=0;LED_B=0;LED_C=0;LED_D=0;LED_E=1;LED_F=1;LED_G=0;
                LED_VCC1=1;LED_VCC2=0;LED_VCC3=0;LED_VCC4=0;end
            4:begin
                LED_A=1;LED_B=0;LED_C=0;LED_D=1;LED_E=1;LED_F=0;LED_G=0;
                LED_VCC1=1;LED_VCC2=0;LED_VCC3=0;LED_VCC4=0;end
            5:begin
                LED_A=0;LED_B=1;LED_C=0;LED_D=0;LED_E=1;LED_F=0;LED_G=0;
                LED_VCC1=1;LED_VCC2=0;LED_VCC3=0;LED_VCC4=0;end
            6:begin
                LED_A=0;LED_B=1 ;LED_C=0;LED_D=0;LED_E=0;LED_F=0;LED_G=0;
                LED_VCC1=1;LED_VCC2=0;LED_VCC3=0;LED_VCC4=0;end
            7:begin
                LED_A=0;LED_B=0;LED_C=0;LED_D=1;LED_E=1;LED_F=1;LED_G=1;
                LED_VCC1=1;LED_VCC2=0;LED_VCC3=0;LED_VCC4=0;end
            8:begin
                LED_A =0;LED_B=0;LED_C=0;LED_D=0;LED_E=0;LED_F=0;LED_G=0;
                LED_VCC1=1;LED_VCC2=0;LED_VCC3=0;LED_VCC4=0;end
            9:begin
                LED_A =0;LED_B=0;LED_C=0;LED_D=0;LED_E=1 ;LED_F=0;LED_G=0;
                LED_VCC1=1;LED_VCC2=0;LED_VCC3=0;LED_VCC4=0;end
            default:begin
                LED_A=1;LED_B=1;LED_C=1;LED_D=1;LED_E=1;LED_F=1;LED_G=1;
                LED_VCC1=1;LED_VCC2=0;LED_VCC3=0;LED_VCC4=0;end
        endcase
        end
end
endmodule