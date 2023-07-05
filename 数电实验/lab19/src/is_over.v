module is_over(clk, r, din, dout);
input clk, r;                 //r为清零信号，即地址计数器输出进位co，32个音符全部播放完毕
input [5:0] din;              //din即duration
output reg dout;              //dout即song_done
parameter PAUSE = 0, PLAY = 1; //状态编码，PAUSE表示未播放状态，PLAY表示正在播放
reg state, nextstate;              //状态
     always @(posedge clk) begin
        if (r) 
            dout = 1;
        else if (din == {6'b0}) 
            dout = 1;
        else
            dout = 0;
    end
endmodule // is_over
