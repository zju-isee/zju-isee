module music_player(
    clk, 
    reset, 
    play_pause, 
    next, 
    NewFrame, 
    sample, 
    play, 
    song
);

parameter sim = 0;
input clk, reset, play_pause, next, NewFrame;
output [15:0] sample;
output play;
output [1:0] song;
wire ready, beat, reset_play, song_done, new_note, note_done;
wire [5:0] note, duration;
wire sample_ready;

//同步化电路
synch i1(
    .clk(clk),
    .in(NewFrame),
    .out(ready)
);

//节拍基准产生器
counter_n #(.n(sim?64:1000), .counter_bits(sim?6:10)) i2(
    .clk(clk),
    .r(0),
    .en(ready),
    .q(),
    .co(beat)
);

//主控制器
mcu c1(
    .clk(clk),
    .reset(reset),
    .play_pause(play_pause),
    .next(next),
    .play(play),
    .song(song),
    .reset_play(reset_play), 
    .song_done(song_done)
);

//乐曲读取
song_reader c2(
    .clk(clk), 
    .reset(reset_play), 
    .play(play), 
    .song(song), 
    .song_done(song_done), 
    .note(note), 
    .duration(duration), 
    .new_note(new_note), 
    .note_done(note_done)
);



//音符播放
note_player c3(
    .clk(clk), 
    .reset(reset_play), 
    .play_enable(play), 
    .note_to_load(note), 
    .duration_to_load(duration), 
    .note_done(note_done), 
    .load_new_note(new_note), 
    .beat(beat), 
    .sampling_pulse(ready), 
    .sample(sample), 
    .sample_ready(sample_ready)
);


endmodule // music_player