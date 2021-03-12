`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qmj
//
// Create Date:   16:12:27 07/31/2012
// Design Name:   div
// Module Name:   E:/solution/lab30/DESIGN1/src/div_tb.v
// Project Name:  TimerTop
// Verilog Test Fixture created by ISE for module: div
////////////////////////////////////////////////////////////////////////////////

module counter_n_tb;

	// Inputs
	reg clk;
	reg en;
        reg r;
	// Outputs
	wire co;
        wire [2:0] q;

	// Instantiate the Unit Under Test (UUT)
	 counter_n #(.n(5),.counter_bits(3)) uut (
		.clk(clk),
                .r(r), 
		.en(en), 	
                .q(q),
                .co(co));

	//clk
   always #50 clk=~clk;
	
	//  clr
	initial 
	 begin
	   clk = 0;r=0;en = 0;
         #(51) r=1;
  	 #(100)r=0;en=1;
         #(800)
         repeat (10)  begin 
	     #(100*3)  en=1;
	     # 100  en=0; end
            #100 $stop;
  end
      
endmodule

