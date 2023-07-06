/* 
当且仅当脉冲信号到来的第一个时间周期，寄存器q还没有从1变成0，则out输出为0,之后q变成0，脉冲输入还是0，则out输出1；
*/

module width_trans(in,clk,out);
    input in,clk;
    output out;
    reg q=1;

    always @(posedge clk)
        q=in;

    assign out=~((~in)&q);
endmodule
/*
in  0 0 1 1
q   1 0 0 1
out 0 1 1 1
*/