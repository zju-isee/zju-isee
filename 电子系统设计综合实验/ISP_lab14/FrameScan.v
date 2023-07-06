module FrameScan(reset,sys_clk,co2,EndLine,vsync,v_nblank,EndFrame,q2);
//帧扫描控制器
input reset,sys_clk,co2,EndLine;
output [1:0] q2;
output vsync,v_nblank,EndFrame;
reg vsync,v_nblank,EndFrame;
reg [1:0] q2,nextstate;

parameter Vsynch =2'b00 ;
parameter Vbp=2'b01;
parameter Vactive=2'b10;
parameter Vfp=2'b11;

always @(posedge sys_clk)
    if(reset) q2<=Vsynch; //q2 为帧扫描控制器当前状态
    else q2<=nextstate;

    //根据帧扫描控制器ASM图设计
always @(*)
begin
    vsync<=0; 
    v_nblank<=0; 
    EndFrame<=0;
    //vsync为帧同步信号; v_nblank为帧扫描消隐时间;EndFrame为一帧扫描结束标志
    case(q2)
        Vsynch: if(co2&&EndLine) nextstate<=Vbp; 
                else nextstate<=Vsynch;
            //只有在帧计数器一个状态计数完成，并且到最后一行扫描结束，
            //即 co2=1 且. EndLine=1时，才进行状态转换
            //co2为帧扫描控制器的计数器定时结束标志
        Vbp: begin
                vsync<=1;
                if(co2&&EndLine) nextstate<=Vactive;
                else nextstate<=Vbp;
            end
        //只有在帧的有效显示区进行显示，其他区域均进行消隐
        Vactive: begin
                    vsync<=1;
                    v_nblank<=1;
                    if(co2&&EndLine) nextstate<=Vfp;
                    else nextstate<=Vactive;
                end
        //消隐后肩的下一状态进入同步阶段时，
        //说明一帧扫描完成，输出一帧扫描结束标志
        Vfp: begin
                vsync<=1;
                if(EndLine) 
                    begin nextstate<=Vsynch; EndFrame<=1;end 
                else 
                    begin nextstate<=Vfp; EndFrame<=0; end
            end
        default: nextstate<=Vsynch;
    endcase
end



endmodule