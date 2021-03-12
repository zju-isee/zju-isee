`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qmj
////////////////////////////////////////////////////////////////////////////////

module mux_2to1_tb_v;

	// Inputs
	reg[3:0] in0;
	reg[3:0] in1;
	reg      addr;

	// Outputs
	wire[3:0] out;

	// Instantiate the Unit Under Test (UUT)
	mux_2to1 #(.n(4))uut (
		.out(out), 
		.in0(in0), 
		.in1(in1), 
		.addr(addr)
	);

	initial begin
		addr = 0;in0 = 0;in1 = 0;
		#100  in0 = 5; in1 = 10;	
        #100  in0 = 6; in1 = 13;
		#100  addr=1;
		#100  in0 = 14; in1 = 9;	
        #100  in0 = 8; in1 = 11;
		#100 addr=0;
		#100 $stop;
		end
      
endmodule

