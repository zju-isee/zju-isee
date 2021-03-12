module timer(clk, beat, q, din, dout);
input clk, beat, din;
input [5:0] q;    //计时长度
output dout;      //计时结束输出
reg [5:0] cnt = 0;
assign dout = (cnt==q-1);   //计时结束
always @(posedge clk) begin
    if(din) cnt = 0;      //reset信号
    else begin if(beat) cnt = cnt+1;  //beat高电平则计时+1
               else cnt = cnt; end
end
endmodule // timer