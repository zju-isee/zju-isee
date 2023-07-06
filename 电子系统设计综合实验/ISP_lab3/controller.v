module controller(in,reset,clk,timer_done,timer_clr,out);
    input in,reset,clk,timer_done;
    output timer_clr,out;
    reg [1:0] state=0;
    parameter HIGH=0,WAIT_LOW=1,LOW=2,WAIT_HIGH=3;

    always@(posedge clk)
        if(reset) state=HIGH;
        else
            begin
            case(state)
             HIGH:state=(in==0)?WAIT_LOW:HIGH;
             WAIT_LOW:state=(timer_done==1)?LOW:WAIT_LOW;
             LOW:state=(in==1)?WAIT_HIGH:LOW;
             WAIT_HIGH:state=(timer_done==1)?HIGH:WAIT_HIGH;
            endcase    
            end
    
    assign timer_clr=(state==LOW||state==HIGH)?1:0;
    assign out=(state==HIGH);

endmodule

