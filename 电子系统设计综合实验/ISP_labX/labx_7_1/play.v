module play(
    clk,
    Clock4Hz,
    reset,
    en,//使能信号，为1时才可以播放，通过开关切换
    sp,
    led,
    sel_song
);
input clk,reset,Clock4Hz,en;
input[1:0] sel_song;
output sp;
output [15:0] led;
reg EnSp,sp;
reg [8:0] CntSone,CntSone1,CntSone2;
reg [3:0] tone;
reg [15:0] led;
reg [13:0] origin,CntSp;

always @(tone,reset)
begin
    if(reset==0||en==0)
    begin   
        EnSp<=0; //EnSp为蜂鸣器的使能信号，为0时为停顿、
        led<=16'b1111111111111111;//LED灯全灭
    end
    else
    begin
        case(tone) //tone为曲谱中的音符
            0:begin led<=16'b1111111111111111; EnSp<=0; end //停顿，灭灯
   
            1:begin origin<=15306; led<=16'b1111111111111110; EnSp<=1; end //低音5
            2:begin origin<=13636; led<=16'b1111111111111101; EnSp<=1; end //低音6
            3:begin origin<=12149; led<=16'b1111111111111011; EnSp<=1; end //低音7

            4:begin origin<=11468; led<=16'b1111111111110111; EnSp<=1; end //音符1
            5:begin origin<=10215; led<=16'b1111111111101111; EnSp<=1; end //音符2
            6:begin origin<=9099;  led<=16'b1111111111011111; EnSp<=1; end //音符3
            7:begin origin<=8591;  led<=16'b1111111110111111; EnSp<=1; end //音符4
            8:begin origin<=7653;  led<=16'b1111111101111111; EnSp<=1; end //音符5
            9:begin origin<=6818;  led<=16'b1111111011111111; EnSp<=1; end //音符6
            10:begin origin<=6074; led<=16'b1111110111111111; EnSp<=1; end //音符7
            
            11:begin origin<=5733; led<=16'b1111101111111111; EnSp<=1; end //高音1
            12:begin origin<=5108; led<=16'b1111011111111111; EnSp<=1; end //高音2
            13:begin origin<=4551; led<=16'b1110111111111111; EnSp<=1; end //高音3
            14:begin origin<=4295; led<=16'b1101111111111111; EnSp<=1; end //高音4
            15:begin origin<=3827; led<=16'b1011111111111111; EnSp<=1; end //高音5
            default:begin led<=16'b1111111111111111; EnSp<=0; end//停顿,灭灯
        endcase
    end
end

//蜂鸣器产生各音节基准频率
always @(posedge clk or negedge reset)//clk为时钟源6MHz
begin
    if(reset==0)
        begin
        CntSp<=0; //CntSp为产生蜂鸣器发声频率的计数器
        sp<=1; //sp为输出给蜂鸣器发声的信号
        end
    else if(EnSp==1)
         //origin越大，减的时间越长，sp 的周期越长，频率就越低，音调越低越粗
         //origin越小，减的时间越短，sp的周期越短，频率就越高，音调越高越尖
         begin
            if(CntSp==0) begin CntSp<=origin; sp<=~sp; end
            else CntSp<=CntSp-1;
            end
    else sp<=1;
end

//曲谱
//音律就是通过曲谱顺序演奏的，而每个节拍都有相应的音阶J/以下为《小星星》的音乐
always @(posedge Clock4Hz or negedge reset) //Clock4Hz为4Hz时钟信号，控制音符播放一拍的时间长短
begin 
        if(reset==0)
        begin
            CntSone<=0; //CntSone是控制歌曲进度的信号
            CntSone1<=2; //CntSone是控制歌曲进度的信号
            CntSone2<=0; //CntSone是控制歌曲进度的信号
        end     
        else if(sel_song==0)
        begin
            case(CntSone)
                0:tone<=1+3;
                2:tone<=1+3;
                4:tone<=5+3;
                6:tone<=5+3;
                8:tone<=6+3;
                10:tone<=6+3;
                12:tone<=5+3;
                13:tone<=5+3;
                16:tone<=4+3;
                18:tone<=4+3;
                20:tone<=3+3;
                22:tone<=3+3;
                24:tone<=2+3;
                26:tone<=2+3;
                28:tone<=1+3;
                29:tone<=1+3;
                32:tone<=5+3;
                34:tone<=5+3;
                36:tone<=4+3;
                38:tone<=4+3;
                40:tone<=3+3;
                42:tone<=3+3;
                44:tone<=2+3;
                45:tone<=2+3;
                48:tone<=5+3;
                50:tone<=5+3;
                52:tone<=4+3;
                54:tone<=4+3;
                56:tone<=3+3;
                58:tone<=3+3;
                60:tone<=2+3;
                61:tone<=2+3;
                default: tone<=0;
            endcase
            if(CntSone==67) CntSone<=0;
            else CntSone<=CntSone+1;
        end
        else if(sel_song==1)
        begin
            case(CntSone1)
                2:tone<=3+3;
                4:tone<=3+3;
                6:tone<=3+3;
                8:tone<=5+3;
                9:tone<=5+3;
                10:tone<=5+3;
                11:tone<=5+3;

                12:tone<=1+3;
                14:tone<=2+3;
                15:tone<=2+3;
                16:tone<=2+3;
                17:tone<=2+3;
                18:tone<=4+3;
                20:tone<=3+3;
                21:tone<=3+3;
                22:tone<=3+3;
                23:tone<=3+3;
                
                24:tone<=5+3;
                26:tone<=6+3;
                27:tone<=6+3;
                28:tone<=5+3;
                30:tone<=4+3;
                32:tone<=6+3;
                33:tone<=6+3;
                34:tone<=6+3;
                35:tone<=6+3;
                
                37:tone<=6+3;
                39:tone<=7+3;
                41:tone<=6+3;
                43:tone<=5+3;
                44:tone<=5+3;
                45:tone<=5+3;
                46:tone<=5+3;

                //形上谓道xi
                48:tone<=5+3;
                50:tone<=8+3;
                51:tone<=8+3;
                52:tone<=8+3;
                53:tone<=8+3;
                54:tone<=7+3;
                55:tone<=6+3;
                56:tone<=5+3;
                57:tone<=5+3;
                58:tone<=5+3;
                58:tone<=4+3;
                59:tone<=3+3;

                //形下为器
                61:tone<=6+3;
                63:tone<=2+3;
                65:tone<=3+3;
                67:tone<=2+3;
                68:tone<=2+3;

                //礼主别异xi
                71:tone<=3+3;
                73:tone<=3+3;
                75:tone<=6+3;
                77:tone<=6+3;
                78:tone<=6+3;
                79:tone<=6+3;
                80:tone<=5+3;
                81:tone<=5+3;
                
                //乐主合同
                83:tone<=5+3;
                85:tone<=5+3;
                87:tone<=8+3;
                89:tone<=7+3;
                90:tone<=7+3;
                91:tone<=7+3;

                //知其不二xi
                93:tone<=7+3;
                94:tone<=8+3;
                95:tone<=9+3;
                96:tone<=8+3;
                97:tone<=7+3;
                98:tone<=6+3;
                99:tone<=5+3;

                //耳听斯聪
                101:tone<=2+3;
                103:tone<=6+3;
                105:tone<=0+3;
                107:tone<=8+3;
                108:tone<=8+3;
                109:tone<=8+3;
                default: tone<=0;
            endcase
            if(CntSone1==113) CntSone1<=2;
            else CntSone1<=CntSone1+1;
        end
        else if(sel_song==2)
        begin
            case(CntSone2)
                0:tone<=1+3;
                2:tone<=2+3;
                4:tone<=3+3;
                6:tone<=4+3;
                8:tone<=5+3;
                9:tone<=5+3;
                11:tone<=1+3;
                12:tone<=1+3;
                14:tone<=4+3;
                16:tone<=3+3;
                18:tone<=2+3;
                20:tone<=0+3;
                22:tone<=1+3;
                default: tone<=0;
            endcase
            if(CntSone2==25) CntSone2<=0;
            else CntSone2<=CntSone2+1;
        end
end

endmodule
//1 2 3 4 5 1 4 3 2 7_ 1
/*
    0:tone<=1+3;
    2:tone<=2+3;
    4:tone<=3+3;
    6:tone<=4+3;
    8:tone<=5+3;
    10:tone<=1+3;
    12:tone<=4+3;
    13:tone<=3+3;
    16:tone<=2+3;
    18:tone<=0+3;
    20:tone<=1+3;

    22:tone<=3+3;
    24:tone<=2+3;
    26:tone<=2+3;
    28:tone<=1+3;
    29:tone<=1+3;
    32:tone<=5+3;
    34:tone<=5+3;
    36:tone<=4+3;
    38:tone<=4+3;
    40:tone<=3+3;
    42:tone<=3+3;
    44:tone<=2+3;
    45:tone<=2+3;
    48:tone<=5+3;
    50:tone<=5+3;
    52:tone<=4+3;
    54:tone<=4+3;
    56:tone<=3+3;
    58:tone<=3+3;
    60:tone<=2+3;
    61:tone<=2+3;
*/