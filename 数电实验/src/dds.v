module dds(
    input clk, reset,
    input [21:0] k,           //相位增量
    input sampling_pulse, 
    output new_sample_ready,
    output [15:0] sample      //正弦信号
);
wire [21:0] raw_addr;         //地址处理输入
wire [21:0] temp;             //加法器输出
wire [9:0] rom_addr;          //ROM地址
wire [15:0] raw_data;         //ROM输出数据
wire [15:0] data;             //数据处理输出                                  
wire area;                    //区域
//加法器实现 temp = k + raw_addr
full_adder adder1(.a(k), .b(raw_addr), .s(temp), .co());
//D触发器得到row_addr
dffre#(.n(22)) dff1(.d(temp), .en(sampling_pulse), .r(reset), .clk(clk), .q(raw_addr));
//地址处理
assign rom_addr[9:0] = raw_addr[20]?((raw_addr[20:10]==1024)?1023:(~raw_addr[19:10]+1)):raw_addr[19:10];
//ROM得到原始数据
sine_rom rom1(.clk(clk), .addr(rom_addr), .dout(raw_data));
//D触发器得到data
dffre#(.n(1)) dff2(.d(raw_addr[21]), .en(1), .r(0), .clk(clk), .q(area));
//数据处理
assign data[15:0] = area?(~raw_data[15:0]+1):raw_data[15:0];
//D触发器得到sample值
dffre#(.n(16)) dff3(.d(data), .en(sampling_pulse), .r(0), .clk(clk), .q(sample));
//D触发器得到new_sample_ready
dffre#(.n(1)) dff4(.d(sampling_pulse), .en(1), .r(0), .clk(clk), .q(new_sample_ready));
endmodule // 