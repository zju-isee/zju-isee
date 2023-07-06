module toplevel(clk,reset,
    start,stop,switch,sp,led,
    LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, 
    LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4);
input clk,reset,start,stop,switch;
output sp,LED_A, LED_B, LED_C, LED_D, LED_E, LED_F, LED_G, 
    LED_VCC1, LED_VCC2, LED_VCC3, LED_VCC4;
output [15:0] led;
reg play_enable;
reg [1:0] sel_song;
wire clk_1kHz,start_1,stop_1,clk_4Hz,switch_1,LED_VCC1_, LED_VCC2_, LED_VCC3_, LED_VCC4_;
clk_gen clkGenerator(.clk(clk),.reset(~reset),.en(1),.clk_1kHz(clk_1kHz),.clk_4Hz(clk_4Hz));

debouncer debouncerInst_1(.in(~start),.clk(clk),.reset(~reset),.out(start_1),.pulse1kHz(clk_1kHz));
debouncer debouncerInst_2(.in(~stop),.clk(clk),.reset(~reset),.out(stop_1),.pulse1kHz(clk_1kHz));
debouncer debouncerInst_3(.in(~switch),.clk(clk),.reset(~reset),.out(switch_1),.pulse1kHz(clk_1kHz));

always@(posedge start_1 or posedge stop_1 or negedge reset)
begin
    if(reset==0)
        begin
            play_enable=1'b0;
        end
    else
    begin
        if(start_1==1)
            begin
                play_enable=1'b1;
            end
        else if(stop_1==1)
            begin
                play_enable=1'b0;
            end
    end
end

always@(posedge switch_1 or negedge reset)
begin
    if(reset==0)
    begin
        sel_song=0;
    end
    else
    begin
        if(sel_song==2)
            sel_song=0;
        else
            sel_song=sel_song+1;
    end
end

play playInst(.clk(clk),.Clock4Hz((clk_4Hz & play_enable)),.reset(reset),.en(play_enable),.sp(sp),.led(led),.sel_song(sel_song));

 LEDscan LEDscanInst(.clk(clk_1kHz), .reset(~reset),.scancnt(2'b00),.Data0({2'b00,sel_song}), .Data1(4'b1111), .Data2(4'b1111), .Data3(4'b1111), .LED_A(LED_A), .LED_B(LED_B), .LED_C(LED_C), .LED_D(LED_D), .LED_E(LED_E), .LED_F(LED_F), .LED_G(LED_G), .LED_VCC1(LED_VCC1_), .LED_VCC2(LED_VCC2_), .LED_VCC3(LED_VCC3_), .LED_VCC4(LED_VCC4_));

assign LED_VCC1=~LED_VCC1_;
assign LED_VCC2=~LED_VCC2_;
assign LED_VCC3=~LED_VCC3_;
assign LED_VCC4=~LED_VCC4_;
endmodule