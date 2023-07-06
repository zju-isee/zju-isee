//行、帧同步屯路顶层模块
module vga_ctrl(reset,sys_clk,hsync,vsync,EndFrame,nblank,hcnt,vcnt);
    input reset,sys_clk;
    output hsync,vsync,EndFrame,nblank;
    output [9:0] hcnt,vcnt;

    wire [1:0] q1,q2;
    wire EndLine,co1,co2,h_nblank,v_nblank;

    HCounter HCounter(
        .reset(reset),
        .sys_clk(sys_clk),
        .q1(q1),
        .co1(co1),
        .hcnt(hcnt));
    VCounter VCounter(
        .reset(reset),
        .sys_clk(sys_clk),
        .EndLine(EndLine),
        .q2(q2),
        .co2(co2),
        .vcnt(vcnt));
    LineScan LineScan(
        .reset(reset),
        .sys_clk(sys_clk),
        .co1(co1),
        .hsync(hsync),
        .h_nblank(h_nblank),
        .EndLine(EndLine),
        .q1(q1));
    FrameScan FrameScan(
        .reset(reset),
        .sys_clk(sys_clk),
        .co2(co2),
        .EndLine(EndLine),
        .vsync( vsync),
        .v_nblank(v_nblank),
        .EndFrame(EndFrame),
        .q2(q2));
    //消隐信号包括行的消隐与帧的消隐
    assign nblank=h_nblank&&v_nblank;

endmodule