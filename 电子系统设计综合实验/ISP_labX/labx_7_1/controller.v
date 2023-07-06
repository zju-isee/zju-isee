module controller(in,reset,clk,timer_done,timer_clr,out);
    parameter width=1;

    input  [width-1:0] in;
    output [width-1:0] out;
    input  reset,clk,timer_done;
    output timer_clr;
    
    reg [1:0] state=0;
    parameter LOW=0,WAIT_HIGH=1,HIGH=2,WAIT_LOW=3;

    always@(posedge clk)
        if(reset) state=LOW;
        else
            begin
            case(state)
             LOW:state=((|in)==1)?WAIT_HIGH:LOW;
                //缩减或运算符，表示 (最高位|次高位| ... |最低位)
             WAIT_HIGH:state=(timer_done==1)?HIGH:WAIT_HIGH;
             HIGH:state=((|in)==0)?WAIT_LOW:HIGH;
             WAIT_LOW:state=(timer_done==1)?LOW:WAIT_LOW;
            endcase    
            end
    
    assign timer_clr=(state==HIGH||state==LOW)?1:0;
    assign out=~(state==LOW);

endmodule

