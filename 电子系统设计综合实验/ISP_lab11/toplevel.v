module toplevel(clk,reset,key_in_0,key_out,
    LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, 
    LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4,SDA,SCL,CMD_RD,CMD_WR);
    //只用一位数码管，clk_low采用256Hz的就够了
    inout SDA,SCL;
    input [3:0] key_in_0;
    input clk,reset,CMD_RD,CMD_WR;
    output LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, 
    LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4;
    output [3:0] key_out;

    wire clk_1kHz,clk_100Hz;//CMD_WR_1,CMD_RD_1;
    wire [3:0] DATA_IN,DataLED;
    wire [1:0] scancnt;

    clk_gen #(.LEDnum(4)) clkGenerator(.clk(clk),.reset(~reset),.en(1'b1),.scancnt(scancnt),.clk_1kHz(clk_1kHz),.clk_100Hz(clk_100Hz));

    //debouncer #(.width(1)) debouncer_Inst_1(.in(~CMD_WR),.clk(clk),.reset(~reset),.out(CMD_WR_1),.pulse1kHz(clk_1kHz));
    //debouncer #(.width(1)) debouncer_Inst_2(.in(~CMD_RD),.clk(clk),.reset(~reset),.out(CMD_RD_1),.pulse1kHz(clk_1kHz));

    I2C I2CInst(.SDA(SDA),.SCL(SCL),.RST(reset),.CLK(clk),.CMD_RD(CMD_RD),.CMD_WR(CMD_WR),.DATA_IN(DATA_IN),.DataLED(DataLED));

    scan_buttons scanButtonsInst(.clk(clk),.clk_100Hz(clk_100Hz),.key_in(key_in_0),.key_out(key_out),.reset_in(reset), .DATA_IN(DATA_IN));

    LEDscan LEDscanInst(.clk(clk_1kHz), .reset(~reset),.scancnt(scancnt), .Data0(DataLED), .Data1(4'b1111), .Data2(4'b1111), .Data3(DATA_IN), .LED_A(LED_A), .LED_B(LED_B), .LED_C(LED_C), .LED_D(LED_D), .LED_E(LED_E), .LED_F(LED_F), .LED_G(LED_G), .LED_VCC1(LED_VCC1), .LED_VCC2(LED_VCC2), .LED_VCC3(LED_VCC3), .LED_VCC4(LED_VCC4));
endmodule