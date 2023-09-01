/* 
当且仅当脉冲信号到来的第一个时间周期，寄存器q还没有从0变成1，则out输出为1,之后q变成1，脉冲输入还是1，则out输出0；
*/

module width_trans(in,clk,out);
    parameter width=1;
    input  [width-1:0] in;
    output [width-1:0] out;
    input clk;

    reg [width-1:0] q=0;
    always @(posedge clk)
        q=in;

    assign out=in&(~q);
endmodule
/*
in  0 0 1 1
q   1 0 0 1
out 0 1 1 1
*/