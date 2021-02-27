`timescale 1ns / 1ps
module synch_tb;
parameter delay = 10;
reg clk, in;
wire out;
synch i1(
    .clk(clk),
    .in(in),
    .out(out)
);

	initial 
	  begin
		// Initialize Inputs
		clk = 0;
		in = 0;

		// 
		#(delay+1)  in=0;
		#(delay)  in = 1;
		#(delay)  in = 0;
		repeat (20000)
		 begin
			#(delay*5)  in = 1;
			#(delay) 	in = 0;
		 end
	  #(delay*10) $stop;
         
    end
	
	//clock
  always 		#(delay/2) clk=~clk;

endmodule // synch_tb