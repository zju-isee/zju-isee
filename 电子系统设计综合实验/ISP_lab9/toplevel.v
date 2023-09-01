module toplevel(clk,dout,reset,
    Tx,Rx,
    LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, 
    LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4);
    input Rx,dout,reset,clk;
    output Tx,LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, 
    LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4;

    wire [1:0] scancnt;
    wire clk_1kHz,clk_9600Hz,clock16,dout_1;
    wire [3:0] Data1,Data2;

    clk_gen #(.sim(0),.LEDnum(2)) clkGenerator(.clk(clk),.reset(~reset),.en(1'b1),.scancnt(scancnt),.clk_1kHz(clk_1kHz),.clk_9600Hz(clk_9600Hz),.clock16(clock16));

    debouncer debouncer_Inst(.in(~dout),.clk(clk),.reset(~reset),.out(dout_1),.pulse1kHz(clk_1kHz));

    LEDscan LEDscanInst(.clk(clk_1kHz), .reset(~reset),.scancnt(scancnt),.Data0(Data1), .Data1(Data2), .Data2(4'b1111), .Data3(4'b1111), .LED_A(LED_A), .LED_B(LED_B), .LED_C(LED_C), .LED_D(LED_D), .LED_E(LED_E), .LED_F(LED_F), .LED_G(LED_G), .LED_VCC1(LED_VCC1), .LED_VCC2(LED_VCC2), .LED_VCC3(LED_VCC3), .LED_VCC4(LED_VCC4));

    receiver receiverInst(.Clock16(clock16),.reset(reset),.Rx(Rx),.Data1(Data1),.Data2(Data2));
    sender senderInst(.Clock9600(clk_9600Hz),.dout(dout_1),.reset(reset),.Tx(Tx));


endmodule