module debouncer(in,clk,reset,out,pulse1kHz);

    input  in;
    output out;
    input clk,reset,pulse1kHz;
    wire timer_clr,timer_done;
    wire  out0;
    
    counter_n #(.n(30),.counter_bits(5)) timer30ms(.clk(clk),.r(timer_clr),.en(pulse1kHz),.co(timer_done),.q());//计时30ms

    controller controllerInst(.in(in),.reset(reset),.clk(clk),.timer_done(timer_done),.timer_clr(timer_clr),.out(out0));//控制器
    
    width_trans  #(.width(1)) widthTransInst(.in(out0),.clk(clk),.out(out));//脉宽变换

endmodule
