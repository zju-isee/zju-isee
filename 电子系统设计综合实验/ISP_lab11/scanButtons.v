module scan_buttons(
    clk,clk_100Hz,key_in,key_out,reset_in, DATA_IN
);
    input clk,clk_100Hz,reset_in;
    input [3:0] key_in;//key_in是已经消抖过的
    output[3:0] key_out, DATA_IN;

    //wire clk_2Hz;
    reg [3:0] key_out,scanvalue=4'b0001,int_Data0;//Data2,Data1;
    //reg display;

    always@(posedge clk_100Hz )
    begin
        begin
            key_out<=scanvalue;
            case(scanvalue)
                4'b0001:scanvalue<=4'b0010;
                4'b0010:scanvalue<=4'b0100;
                4'b0100:scanvalue<=4'b1000;
                4'b1000:scanvalue<=4'b0001;
                default:scanvalue<=4'b0001;
            endcase
        end
    end
    
    always@(posedge clk or negedge reset_in)
    begin
        if(reset_in==0)
        begin
            int_Data0<=4'b0000;
        end
        else
        case({key_in,key_out})
            8'b00010001://键盘1
                int_Data0<=1; 
            8'b00100001://2
                int_Data0<=2;
            8'b01000001://3
                int_Data0<=3;
            8'b10000001:;//X
            8'b00010010://4
                int_Data0<=4;
            8'b00100010://5
                int_Data0<=5;
            8'b01000010://6
                int_Data0<=6;
            8'b10000010:;//Y
            8'b00010100://7
                int_Data0<=7;
            8'b00100100://8
                int_Data0<=8;
            8'b01000100://9
                int_Data0<=9;
            8'b10000100:;//Z
            8'b00011000://0
                int_Data0<=0;
            8'b00101000:;//+
            8'b01001000:;//-
            8'b10001000:;//=

            default:;//无按键按下
        endcase
    end

    assign DATA_IN=int_Data0;

endmodule