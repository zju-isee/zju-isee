module mcu(
    clk, 
    reset, 
    play_pause,                //play/pause按钮
    next,                      //next按钮
    play,                      //歌曲状态
    song,                      //歌曲序号
    reset_play,                //脉冲复位
    song_done                  //播放完毕信号
);
input clk, reset, play_pause, next, song_done;
output play, reset_play;
output [1:0] song;
wire nextsong;
//控制器
mcu_ctrl m1(.clk(clk), .reset(reset), .play_pause(play_pause), .next(next), .play(play), .nextsong(nextsong), .reset_play(reset_play), .song_done(song_done));
//二进制计数器
counter_n#(.n(4), .counter_bits(2)) song_count(.clk(nextsong), .r(0), .en(1), .q(song), .co());
endmodule // mcu