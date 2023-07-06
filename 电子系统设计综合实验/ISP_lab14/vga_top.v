module toplevel(reset_n,sys_clk,orient,hsync,vsync,EndFrame,vga_d);
    input reset_n,sys_clk,orient;
    output hsync,vsync,EndFrame;
    output[2:0] vga_d;

    wire [9:0] hcnt,vcnt;
    wire nblank;

    vga_ctrl vga_ctrl(
    .reset(~reset_n),
    .sys_clk(sys_clk),//系统时钟信号
    .hsync(hsync),//行同步信号，低电平有效
    .vsync(vsync),//帧同步信号，低电平有效
    .EndFrame(EndFrame),//一帧扫描结束标志
    .nblank(nblank),//消隐信号，低电平有效
    .hcnt(hcnt),
    .vcnt(vcnt));

    vga_data vga_data(
    .orient(orient),//拨码开关CS1控制信号（高电平为置OFF)
    .nblank(nblank),
    .hcnt(hcnt),
    .vcnt(vcnt),
    .vga_d(vga_d)); //三基色输出信号，从高位到低位分别表示蓝、绿、红

endmodule

