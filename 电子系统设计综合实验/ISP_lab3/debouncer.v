module debouncer(in,clk,reset,out,pulse1kHz);
 
    input in,clk,reset,pulse1kHz;
    output out;
    wire timer_clr,timer_done;

    counter_n #(.n(10),.counter_bits(4)) Timer(.clk(clk),.r(timer_clr),.en(pulse1kHz),.co(timer_done),.q());//计时10ms

    controller ControlInst(.in(in),.reset(reset),.clk(clk),.timer_done(timer_done),.timer_clr(timer_clr),.out(out));//控制器
    
     
endmodule
