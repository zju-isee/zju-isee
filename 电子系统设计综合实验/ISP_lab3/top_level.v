//注意，板子的ABCD按钮是低电平有效，按钮阵列是高电平有效，所以这里对reset信号取反。

module top_level(clk,clk_low,resetIn,ButtonIn,LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4, light_win);
    input clk,clk_low,resetIn,ButtonIn;
    output LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4, light_win;
    wire ButtonOut,ButtonOut_1,clk_1kHz,resetOut,resetOut_1,clk_3791;
    wire [3:0] Data0,Data1,win,lose;
    wire [4:0] sum;
    wire [1:0] selLED;
    parameter sim=0;

    debouncer buttonInst_1(.in(ButtonIn),.clk(clk),.reset(1'b0),.out(ButtonOut),.pulse1kHz(clk_1kHz));//随机数按键的按键处理
    
    debouncer buttonInst_2(.in(resetIn),.clk(clk),.reset(1'b0),.out(resetOut),.pulse1kHz(clk_1kHz));//reset按键的按键处理，reset按键不进行脉宽变换

    clk_gen #(.n(4),.sim(sim)) clkGenerate(.clk(clk),.reset(1'b0),.en(1'b1),.scancnt(selLED),.clk_1kHz(clk_1kHz),.clk_3791(clk_3791));

    random_gen randomNumGenetate_1(.clk(clk_low),.start(ButtonOut),.num(Data0),.odd());

    random_gen randomNumGenetate_2(.clk(clk_3791),.start(ButtonOut),.num(Data1),.odd());

    LEDscan LEDscanInst(.clk(clk_1kHz), .reset(~resetOut),.scancnt(selLED),.Data0(Data0), .Data1(Data1), .Data2(win), .Data3(lose), .LED_A(LED_A), .LED_B(LED_B), .LED_C(LED_C), .LED_D(LED_D), .LED_E(LED_E), .LED_F(LED_F), .LED_G(LED_G), .LED_VCC1(LED_VCC1), .LED_VCC2(LED_VCC2), .LED_VCC3(LED_VCC3), .LED_VCC4(LED_VCC4));

    bit5_full_adder bit5Adder_1(.a({1'b0,Data0}),.b({1'b0,Data1}),.s(sum),.ci(1'b0),.co());

    assign light_win=((sum==4'b0111)|(sum==4'b1011))?1'b0:1'b1;//若为7或11，light_win亮

    width_trans width_trans_inst_1(.in(ButtonOut),.clk(clk),.out(ButtonOut_1));
    width_trans width_trans_inst_2(.in(resetOut),.clk(clk),.out(resetOut_1));
    counter_n #(.n(10),.counter_bits(4)) counter_win(.clk(clk),.r(~resetOut_1),.en(light_win&(~ButtonOut_1)),.co(),.q(win));
    counter_n #(.n(10),.counter_bits(4)) counter_lose(.clk(clk),.r(~resetOut_1),.en((~light_win)&(~ButtonOut_1)),.co(),.q(lose));
    
endmodule

