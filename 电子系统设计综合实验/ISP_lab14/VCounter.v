module VCounter(reset,sys_clk,EndLine,q2,co2,vcnt);
//帧扫描控制器的计数器
input reset,sys_clk,EndLine;
input [1:0] q2;
output co2;
output [9:0] vcnt;
reg [9:0] cnt,vcnt;

assign co2=EndLine&&(vcnt==cnt-1);//co2为定时结束标志，即计数器进位信号//EndLine为行扫描器扫描完一行结束的标志; cnt为计数器的模
always @(posedge sys_clk)
begin
    case(q2)//q2为帧扫描控制器输出的控制器当前状态
    //帧扫描控制器的4个状态分别对应帧同步信号的4个阶段
    //根据帧扫描控制器ASM图可以确定控制器每个状态计数器的模
    //Vsynch:3 Vbp:21 Vactive:600 Vfp:1
        2'b00: cnt=3;//帧同步
        2'b01: cnt=21;//帧后沿
        2'b10: cnt=600;//帧像素
        2'b11: cnt=1;//帧前沿
        default:cnt=3;
    endcase

    //系统重置或每一阶段计数完成时，计数器清零。
    if(reset||co2 ) vcnt=0;
    //每扫描完一行时，帧扫描计数器加1
    else if(EndLine) vcnt=vcnt+1;
end

endmodule