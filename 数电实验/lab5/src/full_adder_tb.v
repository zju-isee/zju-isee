`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qmj
////////////////////////////////////////////////////////////////////////////////

module full_adder_tb_v;

	// Inputs
	reg a;
	reg b;
	reg ci;

	// Outputs
	wire s;
	wire co;

	// Instantiate the Unit Under Test (UUT)
	full_adder uut (
		.a(a), 
		.b(b), 
		.s(s), 
		.ci(ci), 
		.co(co)
	);

	initial begin
  	  a = 0;b = 0;ci = 0;
	  #100  a = 0;b = 0;ci = 1;
      #100  a = 0;b = 1;ci = 0;
	  #100  a = 0;b = 1;ci = 1;
      #100  a = 1;b = 0;ci = 0;
	  #100  a = 1;b = 0;ci = 1;
      #100  a = 1;b = 1;ci = 0;
	  #100  a = 1;b = 1;ci = 1;
      #100  $stop;
	end
      
endmodule

