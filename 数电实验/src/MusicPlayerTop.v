`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module MusicPLayerTop(
    // Clock	 
	input clk,//100MHz
    input reset,//高电平有效
	 // Push button 
	input play_button,  //高电平有效
	input next_button,  //高电平有效
	 //Codec Interface
    input  ADC_SDATA,
    output DAC_SDATA,
    output BCLK,
    output MCLK,
    output LRCLK,
    inout SCL,
    inout SDA,
	 //3 LED outputs
	 output[1:0] song,
	 output play
	 );
wire sys_clk,audio_clk;
DCM_Audio DCM_inst
        (
         // Clock out ports
         .clk_out1(sys_clk),     // output clk_out1
         .clk_out2(audio_clk),     // output clk_out2
         // Status and control signals
         .reset(0), // input reset
         .locked(),       // output locked
        // Clock in ports
         .clk_in1(clk));      // input clk_in1
//	******************************************************************************
//  	Button processor units
//	******************************************************************************
	
	wire next;
	button_process_unit next_button_process_unit(
	   .clk(sys_clk),
	   .reset(reset),
	   . ButtonIn(next_button),
	   . ButtonOut(next)); //高电平脉冲
	wire play_pause;
   button_process_unit play_button_process_unit(
	   .clk(sys_clk),
	   .reset(reset),
	   . ButtonIn(play_button),
	   . ButtonOut(play_pause)); //高电平脉冲
//	******************************************************************************
//  	The music player Sample Generate
//	******************************************************************************
	wire	[15:0] sample;	   
	wire NewFrame;//
	music_player music_player_inst(
      .clk(sys_clk),
      .reset(reset),
      .play_pause( play_pause),
      .next(next),//(next),
      .NewFrame(NewFrame), 
      .sample(sample),
  	   .play(play),
	   .song(song));


//	******************************************************************************
//  	Codec interface
//	******************************************************************************

	AudioInterface AudioInterface_inst(
    .clk(audio_clk),
    .reset(reset),
    .BCLK(BCLK),
    .LRCLK(LRCLK),
    .MCLK(MCLK),
    .ADC_SDATA(ADC_SDATA),
    .DAC_SDATA(DAC_SDATA),
    .LeftPlayData({sample,8'd0}),
	 .RightPlayData({sample,8'd0}),
    .LeftRecData(),
	 .RightRecData(),
    .NewFrame(NewFrame),
	 .SCL(SCL),
    .SDA(SDA),
	 .error() );
	

	  
	 endmodule
