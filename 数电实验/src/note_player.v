module note_player(
    clk,          //系统时钟信号，外接sys_clk
    reset,        //复位信号，来自mcu模块的reset_play
    play_enable,  //来自mcu模块的play信号，高电平表示播放
    note_to_load, //来自song_reader模块的音符标记note
    duration_to_load, //来自song_reader模块的音符时长duration
    note_done,     //给song_reader模块的应答信号，表示音符播放完毕
    load_new_note, //来自song_raeder模块的new_note信号，表示音符播放完毕
    beat,          //定时基准信号，频率为48kHz
    sampling_pulse, //来自同步化电路模块的ready信号，频率48kHz，表示索取新的样品
    sample,         //正弦样品输出
    sample_ready    //下一个正弦信号
);
input clk, reset, play_enable, load_new_note, beat, sampling_pulse;
input [5:0] note_to_load, duration_to_load;
output note_done, sample_ready;
output [15:0] sample;
wire [5:0] q;       //FreqROM的地址输入
wire [19:0] dout;
wire timer_clear, timer_done;  //计时清空和计时完成
//控制器
note_player_ctrl i1(
    .clk(clk), 
    .reset(reset),
    .play_enable(play_enable),
    .load_new_note(load_new_note),
    .load(load),   //D触发器的使能输入
    .timer_clear(timer_clear),  //音符节拍定时器计时清空
    .timer_done(timer_done),    //音符节拍定时器计时完成
    .note_done(note_done)
);
//D触发器
dffre#(.n(6)) i2(
    .d(note_to_load),
    .en(load),
    .r(~play_enable || reset),  //清零信号
    .clk(clk),
    .q(q)      //FreqROM地址输入
);
//FreqROM
frequency_rom i3(
    .clk(clk),
    .dout(dout),  //DDS模块k的后20位
    .addr(q)
);
//DDS
dds i4(
    .clk(clk),
    .reset(~play_enable || reset),
    .k({2'b00, dout}),  
    .sampling_pulse(sampling_pulse),
    .new_sample_ready(sample_ready),
    .sample(sample)
);
//计时器
timer i5(
    .clk(clk),
    .beat(beat),  //使能端
    .q(duration_to_load), //计时长度
    .din(timer_clear),
    .dout(timer_done)
);
endmodule // note_player