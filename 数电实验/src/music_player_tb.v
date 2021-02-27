`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qmj
////////////////////////////////////////////////////////////////////////////////

module music_player_tb_v;
   parameter delay=10; 
	// Inputs
	reg clk;
	reg reset;
	reg play_pause;
	reg next;
	reg NewFrame;

	// Outputs
	wire [15:0] sample;
	wire play ;
	wire [1:0] song ;

	// Instantiate the Unit Under Test (UUT)
	music_player #(.sim(1)) uut (
		.clk(clk), 
		.reset(reset), 
		.play_pause(play_pause), 
		.next(next), 
		.NewFrame(NewFrame), 
		.sample(sample), 
		.play (play), 
		.song (song));

	initial 
	  begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		play_pause = 0;
		next = 0;
		NewFrame = 0;

		// 
		#(delay+1)  reset=0;
		#(delay)  play_pause = 1;
		#(delay)  play_pause = 0;
		repeat (20000)
		 begin
			#(delay*5)  NewFrame = 1;
			#(delay) 	NewFrame = 0;
		 end
	  #(delay*10) $stop;
         
    end
	
	//clock
  always 		#(delay/2) clk=~clk;
endmodule

