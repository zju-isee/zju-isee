module song_reader(
    clk, 
    reset, 
    play, 
    song,             //歌曲序号
    song_done,        //歌曲播放完成标志
    note,             //二进制6位，表示音符
    duration,         //二进制6位，表示音长
    new_note,         //新音符标志
    note_done         //音符播放完成标志
);
input clk, reset, play, note_done;
input [1:0] song;
output song_done, new_note;
output [5:0] note, duration;
wire co;               //地址计数器进位输出，表示32个音符播放完毕
wire [4:0] q;          //音符地址后5位
//控制器
song_reader_ctrl c1(.clk(clk), .reset(reset), .play(play), .note_done(note_done), .new_note(new_note));
//地址计数器
counter_n#(.n(32), .counter_bits(5)) song_choose(.clk(clk), .r(reset), .en(note_done), .q(q), .co(co));
//歌曲选择
song_rom song_read(.clk(clk), .dout({note, duration}), .addr({song, q}));
//结束判断
is_over i1(.clk(clk), .r(co), .din(duration), .dout(song_done));
endmodule