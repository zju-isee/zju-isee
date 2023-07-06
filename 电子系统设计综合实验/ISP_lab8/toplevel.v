module toplevel(
    clk,reset,
    key_out,key_in,
    LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, 
    LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4
    );
    input clk,reset;//clk是6MHz
    input[3:0] key_in;
    output[3:0] key_out;
    output LED_VCC1,LED_VCC2,LED_VCC3,LED_VCC4,LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G;

    wire [1:0] scancnt;
    wire [3:0] key_in_1,Data0,Data1,Data2;
    wire clk_100Hz,clk_1kHz;

    parameter sim=0;
    clk_gen #(.sim(sim),.LEDnum(3)) clkGenerator(.clk(clk),.reset(1'b0),.en(1'b1),.scancnt(scancnt),.clk_1kHz(clk_1kHz),.clk_100Hz(clk_100Hz));

    debouncer #(.width(4)) debouncerInst(.in(key_in),.clk(clk),.reset(~reset),.out(key_in_1),.pulse1kHz(clk_1kHz));//key_in按键消抖处理
    
    scan_buttons scanButtonsInst(
    .clk(clk),.clk_100Hz(clk_100Hz),.key_in(key_in),.key_out(key_out), .led_int_Data0(Data0), .led_int_Data1(Data1),.led_int_Data2(Data2),.reset_in(reset));

    LEDscan LEDscanInst(.clk(clk_1kHz), .reset(~reset),.scancnt(scancnt),.Data0(Data0), .Data1(Data1), .Data2(Data2), .Data3(4'b1111), .LED_A(LED_A), .LED_B(LED_B), .LED_C(LED_C), .LED_D(LED_D), .LED_E(LED_E), .LED_F(LED_F), .LED_G(LED_G), .LED_VCC1(LED_VCC1), .LED_VCC2(LED_VCC2), .LED_VCC3(LED_VCC3), .LED_VCC4(LED_VCC4));


endmodule