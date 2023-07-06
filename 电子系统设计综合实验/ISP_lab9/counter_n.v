/*
clk为时钟信号,q为寄存器（长度可变）,
co为寄存器满了之后的进位信号.r为reset信号,
en为计数使能

值得注意的是，en恒为1时为时钟计数，
如果计数使能en为脉冲信号（脉冲的长度必须为一个时钟周期）
那就是对en计数。因为只有当en为正脉冲时，寄存器才能变化，
则如果en每3个周期一个脉冲，那每三个clk下降沿中只有一个能使寄存器+1；

另外，如果改造为分频器，
寄存器位数决定了进位信号的周期，
让寄存器自然进位，只需要取寄存器q的第k位，即可变成N=2**k的分频（偶数分频）
如果改变寄存器自然进位，例如10分频，可以吧输出逻辑改放在always里面，并使用
两个分别上升沿和下降沿触发的时钟相或得到；
*/

module counter_n(clk,r,en,co,q);
    parameter n=2;//计数器的模
    parameter counter_bits=1;//计数器的位数

    input clk,r,en;
    output co;
    output [counter_bits:1] q;
       reg [counter_bits:1] q=0;//寄存器q，用来计数
    assign co=(q==(n-1)) && en;//输出逻辑，当计数使能打开，q存满了时，输出进位信号
    always @(posedge clk)//上升沿触发
        begin
            if(r)   q=0;//同步清零
            else if(en)//只有en=1才能寄存器变化。
                begin if(q==(n-1))  q=0;
                      else q=q+1;
                end
            else    q=q;
        end
endmodule

