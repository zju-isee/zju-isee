module mcu_ctrl(clk, reset, play_pause, next,  play, nextsong, reset_play, song_done);
input clk, reset, play_pause, next, song_done;
output reg play, reset_play, nextsong;
parameter RESET=0, PAUSE=1, NEXT=2, PLAY=3;//状态编码
reg [1:0] state, nextstate;
//D寄存器
always @(posedge clk) begin
    if(reset) state = RESET;
    else state = nextstate;
end
//下一状态和输出电路
always @(*)begin
    play = 0; nextsong = 0; reset_play = 0;//默认值设置为0
    case(state)
        RESET: begin nextstate = PAUSE; reset_play = 1; end
        PAUSE: begin 
            if(play_pause) nextstate = PLAY;  
            else begin if(next) nextstate = NEXT;
                    else nextstate = PAUSE; end
            end
        NEXT: begin nextstate = PLAY; nextsong = 1; reset_play = 1; end
        PLAY: begin
            play = 1;
            if(play_pause) nextstate = PAUSE;  
            else begin
                if(next) nextstate = NEXT;
                else begin
                    if(song_done) nextstate = RESET;
                    else nextstate = PLAY; end
                end
            end
        default: nextstate = RESET;
    endcase
end
endmodule