module debouncer(in,clk,reset,out,pulse1kHz);

    parameter width=1;
    input  [width-1:0] in;
    output [width-1:0] out;
    wire   [width-1:0] out0;
    input clk,reset,pulse1kHz;
    wire timer_clr,timer_done;
    

    counter_n #(.n(10),.counter_bits(4)) timer10ms(.clk(clk),.r(timer_clr),.en(pulse1kHz),.co(timer_done),.q());//计时10ms

    controller #(.width(width)) controllerInst(.in(in),.reset(reset),.clk(clk),.timer_done(timer_done),.timer_clr(timer_clr),.out(out));//控制器
    
    /*width_trans  #(.width(width)) widthTransInst(.in(out0),.clk(clk),.out(out));//脉宽变换*/
endmodule
