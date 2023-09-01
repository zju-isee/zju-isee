//注意，板子的ABCD按钮是低电平有效，按钮阵列是高电平有效，所以这里对reset信号取反。

module top_level(clk,clk_low,resetIn,ButtonIn,LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4, light_1, light_2);
    input clk,clk_low,resetIn,ButtonIn;
    output LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4, light_1, light_2;
    wire ButtonOut,pulse1kHz,selLED,odd,resetOut;
    wire [3:0] Data0;

    button buttonInst_1(.clk(clk),.reset(0),.ButtonIn(ButtonIn),.ButtonOut(ButtonOut),.pulse1kHz(pulse1kHz));//随机数按键的按键处理
    
    debouncer buttonInst_2(.in(resetIn),.clk(clk),.reset(0),.out(resetOut),.pulse1kHz(pulse1kHz));//reset按键的按键处理，reset按键不进行脉宽变换

    clk_gen clkGenerate(.clk(clk),.reset(0),.en(1'b1),.scancnt(selLED),.clk_1kHz(pulse1kHz));

    random_gen randomNumGenetate(.clk(clk_low),.start(ButtonOut),.num(Data0),.odd(odd));

    LEDscan LEDscanInst(.clk(pulse1kHz), .reset(~resetOut),.scancnt(2'b00),.Data0(Data0), .Data1(0), .Data2(0), .Data3(0), .LED_A(LED_A), .LED_B(LED_B), .LED_C(LED_C), .LED_D(LED_D), .LED_E(LED_E), .LED_F(LED_F), .LED_G(LED_G), .LED_VCC1(LED_VCC1), .LED_VCC2(LED_VCC2), .LED_VCC3(LED_VCC3), .LED_VCC4(LED_VCC4));

    assign light_1=(odd==1'b1)?1'b1:1'b0;//若为奇数，light_1亮
    assign light_2=(odd==1'b0)?1'b1:1'b0;//若为偶数，light_2亮

endmodule

