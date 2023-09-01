module HCounter(reset,sys_clk,q1,co1,hcnt);
//行扫描控制器的计数器
input reset,sys_clk;
input [1:0] q1;
output co1;
output [9:0] hcnt;
reg [9:0] cnt,hcnt;

assign co1=(hcnt==cnt-1);//co1为定时结束标志，即计数器进位信号; cnt为计数器的模

always @(posedge sys_clk)
begin
    case(q1)//q1为行扫描控制器输出的控制器当前状态
        //行扫描控制器的4个状态分别对应行同步信号的4个阶段
        //根据行扫描控制器ASM图可以确定控制器每个状态计数器的模\
        //Hsynch:80 Hbp:160 Hactive:800 Hfp:16
        2'b00:  cnt=80; //行同步
        2'b01 : cnt=160;//行后沿
        2'b10:  cnt=800; //行像素
        2'b11 : cnt=16;//行前沿
        default:cnt=80;
    endcase
    //系统重置或每一阶段计数完成时，计数器清零
    if(reset||co1 ) hcnt=0;
    else hcnt=hcnt+1;
end

endmodule