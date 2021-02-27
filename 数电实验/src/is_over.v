module is_over(clk, r, din, dout);
input clk, r;                 //r为清零信号，即地址计数器输出进位co，32个音符全部播放完毕
input [5:0] din;              //din即duration
output reg dout;              //dout即song_done
parameter PAUSE = 0, PLAY = 1; //状态编码，PAUSE表示未播放状态，PLAY表示正在播放
reg state, nextstate;              //状态
always @(posedge clk) begin
    if(r) begin dout = 1; state =  PAUSE; end //当地址计数器输出co即r=0时，表示歌曲播放完毕，输出dout=1，状态变为PAUSE
    else state = nextstate;
end
always @(*)begin
    dout = 0;
    case (state) 
    PAUSE: begin 
        if(din) nextstate = PLAY;   //当din不为0时表示歌曲播放，进入PLAY状态
        else nextstate = PAUSE; end //否则继续PAUSE状态
    PLAY: begin 
        if(din==0) begin dout = 1; nextstate = PAUSE; end      //音长为0进入OVER状态同时输出dout=1
        else nextstate = PLAY;               //否则继续PLAY状态
    end     //否则输出0
    default: nextstate = PAUSE;
    endcase
end
endmodule // is_over