`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qmj

////////////////////////////////////////////////////////////////////////////////

module song_reader_tb_v;
   parameter delay=10;
	// Inputs
	reg clk;
	reg reset;
	reg play;
	reg [1:0] song;
	reg note_done;

	// Outputs
	wire song_done;
	wire [5:0] note;
	wire [5:0] duration;
	wire new_note;

	// Instantiate the Unit Under Test (UUT)
	song_reader uut (
		.clk(clk), 
		.reset(reset), 
		.play(play), 
		.song(song), 
		.song_done(song_done), 
		.note(note), 
		.duration(duration), 
		.new_note(new_note), 
		.note_done(note_done)
	);

	initial 
	  begin
		// Initialize Inputs
		clk = 0;
		reset =1;
		play = 0;
		song = 0;
		note_done = 0;
		//
		#(delay*1.5+1) reset=0;
		#(delay*2) play=1;
		 
		repeat (29)
		begin 
        #(delay*5)  note_done = 1;
		  #(delay)   note_done = 0;
		end 
		// 
    reset=1;
    #(delay) reset=0;
		
		 #(delay*5) play=0; 
		 #(delay*16) $stop;
		

	  end
	//clock
	always 		#(delay/2) clk=~clk;
      
endmodule

