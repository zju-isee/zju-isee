module DECODER(
    clk,
    reset,
    key_in_0,
    key_in_1,
    key_in_2,
    key_in_3,
    key_out_0,
    key_out_1,
    key_out_2,
    key_out_3,
    led_0,
    led_1,
    led_2,
    led_3,
    led_4
);
    input clk,reset;
    input key_in_0,key_in_1,key_in_2,key_in_3;
    output reg key_out_0,key_out_1,key_out_2,key_out_3,led_0,led_1,led_2,led_3,led_4;
    reg [3:0] scanvalue;
    reg [7:0] combvalue;
    reg [3:0] key_in;
    reg [3:0] key_out;
    reg [4:0] led;

    always @(posedge clk or negedge reset)
    begin
        key_in <= {key_in_0,key_in_1,key_in_2,key_in_3};
        key_out <= {key_out_0,key_out_1,key_out_2,key_out_3};
        led <= {led_0,led_1,led_2,led_3,led_4};
    end

    always @(posedge clk or negedge reset) //clk ???????128Hz\
    begin
        if(reset==0)
            begin
                scanvalue<=1;//scanvalue ??????
                led<=5'b11111; //5 ? led ????????????:???0????LED ??
                combvalue<=0;//combvalue ????????????
            end
        else
            begin//???ms????????
                key_out<=scanvalue;//?????: ey out ??row ?
    //??:????????????0???(?MAGIC3100)????????1???0001:
    //????????????1???(?EDA-E )???????0???1110
    //??????????
                case(scanvalue)
                    4'b0001:scanvalue<=4'b0010;
                    4'b0010:scanvalue<=4'b0100;
                    4'b0100:scanvalue<=4'b1000;
                    4'b1000:scanvalue<=4'b0001;
                    default:scanvalue<=4'b0001;
                endcase
                combvalue<={key_in,key_out};//key in ??column?
                case(combvalue)
                    8'b00010001:led<=5'b11110; //????"1"
                    8'b00100001:led<=5'b11101;//????"2"
                    8'b01000001:led<=5'b11100;//????"3"
                    8'b10000001:led<=5'b11011;//????"X"
                    8'b00010010:led<=5'b11010;//????"4"
                    8'b00100010:led<=5'b11001; //????"5"
                    8'b01000010:led<=5'b11000;//????"6"
                    8'b10000010:led<=5'b10111;//????"Y"
                    8'b00010100:led<=5'b10110;//????"7"
                    8'b00100100:led<=5'b10101;//????"8"
                    8'b01000100:led<=5'b10100;//????"9"
                    8'b10000100:led<=5'b10011;//????"Z"
                    8'b00011000:led<=5'b10010;//????"0"
                    8'b00101000:led<=5'b10001;//????"+"
                    8'b01001000:led<=5'b10000;//????"_"/
                    8'b10001000:led<=5'b01111; //????"="
                    default: led<=5'b11111;//????????LED ????
                endcase
            end
    end
    
endmodule
