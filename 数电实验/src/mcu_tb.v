`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: qmj
// Engineer:zju

////////////////////////////////////////////////////////////////////////////////

module mcu_tb_v;
   parameter delay=10; 
	// Inputs
	reg clk;
	reg reset;
	reg play_pause;
	reg next;
	reg song_done;

	// Outputs
	wire play;
	wire [1:0] song;
	wire reset_play;

	// Instantiate the Unit Under Test (UUT)
	mcu uut (
		.clk(clk), 
		.reset(reset), 
		.play_pause(play_pause), 
		.next(next), 
		.play(play), 
		.song(song), 
		.reset_play(reset_play), 
		.song_done(song_done)
	);
 
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		play_pause = 0;
		next = 0;
		song_done = 0;

		// 
		#(delay*1.5+1) reset=0;
		#(delay)   play_pause = 1;
    #(delay)   play_pause = 0;
		#(delay*5) play_pause = 1;
		#(delay)   play_pause = 0;
		#(delay*5) play_pause = 1;
    #(delay)   play_pause = 0;
    #(delay*8) next = 1;		
    #(delay)   next = 0;		
    #(delay*8) song_done  = 1; 
    #(delay)    song_done  = 0;
    #(delay*2) play_pause = 1;
    #(delay)   play_pause = 0;
    #(delay*5) next = 1;		
    #(delay)   next = 0;
    #(delay*8) song_done  = 1; 
    #(delay)    song_done  = 0;
    #(delay*5) next = 1;		
    #(delay)   next = 0; 
    #(delay*5) next = 1;		
    #(delay)   next = 0;   
		#(delay*5)  $stop;	
	
	end
	//clock
  always 		#(delay/2) clk=~clk;
endmodule

