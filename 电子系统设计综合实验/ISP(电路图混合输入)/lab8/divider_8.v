module DIVIDER_8(clk,reset,time10ms);
    input clk,reset;
    output time10ms;

    reg time10ms;
    reg [3:0] timecnt;

    //产生10ms时钟的进程
    always @(posedge clk or negedge reset) //clk 为系统时钟信号 6MHz
    begin
        if(reset==1'b0)timecnt<=0; //timecnt 为分频计数器，用来得到10ms 时钟
        else if(timecnt==1)
            begin
                time10ms<=~time10ms; //timel0ms 为10ms 时钟
                timecnt<=0;
            end
        else timecnt<=timecnt+1;
    end

endmodule

