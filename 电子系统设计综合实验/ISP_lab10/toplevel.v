module toplevel (
    clk,clk_low,reset,KeyData,KeyClock,
     LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, 
    LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4
);
input clk,clk_low,reset,KeyData,KeyClock;
output LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, 
    LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4;

wire [3:0] Data;

PS2_Receiver PS2_Receiver_Inst(.clk(clk),.reset(reset),.KeyClock(KeyClock),.KeyData(KeyData),.PS_Data(Data));

LEDscan LEDscanInst(.clk(clk_low), .reset(~reset),.scancnt(2'b00), .Data0(Data), .Data1(4'b1111), .Data2(4'b1111), .Data3(4'b1111), .LED_A(LED_A), .LED_B(LED_B), .LED_C(LED_C), .LED_D(LED_D), .LED_E(LED_E), .LED_F(LED_F), .LED_G(LED_G), .LED_VCC1(LED_VCC1), .LED_VCC2(LED_VCC2), .LED_VCC3(LED_VCC3), .LED_VCC4(LED_VCC4));

endmodule