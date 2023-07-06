module clk_gen(clk,reset,en,scancnt,clk_1kHz);
input clk,reset,en;
output scancnt,clk_1kHz;
reg [1:0] scancnt=0; 
parameter n=1;//需要n位数码管

// 时钟进程，产生各种时钟信号
counter_n #(.n(1000),.counter_bits(13)) FreqDivide(.clk(clk),.r(reset),.en(en),.co(clk_1kHz),.q());

always @(posedge clk_1kHz)//
begin //整体刷新频率为1000Hz/4=250Hz,即1s内对4位数码管都刷新250次，大于50次每秒的要求
    if(scancnt==(n-1)) scancnt=0; //scancnt为LED扫描轮转信号(从0到3)
    else scancnt=scancnt+1;   
end

endmodule

