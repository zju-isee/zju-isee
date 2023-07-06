module clk_gen(clk,reset,en/*,scancnt*/,clk_1kHz,clk_4Hz);
input clk,reset,en;
output clk_1kHz,clk_4Hz;
/*output [1:0] scancnt;
reg [1:0] scancnt=0; 
parameter LEDnum=1;//需要n位数码管*/
// 时钟进程，产生各种时钟信号

counter_n #(.n(6000),.counter_bits(13)) FreqDivide_1(.clk(clk),.r(reset),.en(en),.co(clk_1kHz),.q());//产生1kHz的时钟信号

counter_n #(.n(2300),.counter_bits(12)) FreqDivide_2(.clk(clk_1kHz),.r(reset),.en(en),.co(clk_4Hz),.q());//产生1kHz的时钟信号

/*always @(posedge clk_1kHz)//
begin //整体刷新频率为1000Hz/4=250Hz,即1s内对4位数码管都刷新250次，大于50次每秒的要求
    if(scancnt==(LEDnum-1)) scancnt=0; //scancnt为LED扫描轮转信号(从0到3)
    else scancnt=scancnt+1;   
end*/
endmodule

