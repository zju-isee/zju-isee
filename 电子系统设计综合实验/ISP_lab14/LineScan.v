module LineScan(reset,sys_clk,co1,hsync,h_nblank,EndLine,q1);
input reset,sys_clk,co1;
output [1:0] q1;
output hsync,h_nblank,EndLine;
reg hsync,h_nblank,EndLine;
reg [1:0] q1,nextstate;

parameter Hsynch =2'b00 ;
parameter Hbp=2'b01;
parameter Hactive=2'b10;
parameter Hfp=2'b11;

//行扫描控制器
always @(posedge sys_clk)
if(reset) q1<=Hsynch;//q1 为行扫描控制器当前状态
else q1<=nextstate;

//根据行扫描控制器ASM图设计
always @(*)
begin
    hsync<=0; h_nblank<=0; EndLine<=0;
    //hsync为行同步信号; h_nblank为行扫描消隐时间; EndLine为一行扫描结束标志
    case(q1)
        Hsynch:
            if(co1) nextstate<=Hbp; 
            else nextstate<=Hsynch;
        //co1为行扫描控制器的计数器定时结束标志
        Hbp: 
            begin
            hsync<=1;
            if(co1) nextstate<=Hactive;
            else nextstate<=Hbp;
            end
        //只有在行的有效显示区进行显示，其他区域均进行消隐
        Hactive: 
            begin
            hsync<=1;
            h_nblank<=1;
            if(co1) nextstate<=Hfp;
            else nextstate<=Hactive;end
        //消隐后肩的下一状态进入同步阶段时
        //说明一行扫描完成，输出一行扫描结束标志
        Hfp: 
            begin
            hsync<=1;
            if(co1) begin nextstate<=Hsynch; EndLine<=1; end
            else begin nextstate<=Hfp;EndLine<=0;end
          end
    default: nextstate<=Hsynch;
    endcase
end

endmodule
