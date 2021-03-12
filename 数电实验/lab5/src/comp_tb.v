`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qmj
////////////////////////////////////////////////////////////////////////////////

module comp_tb;

	// Inputs
	reg[3:0] a;
	reg[3:0] b;

	// Outputs
	wire agb;
	wire aeb;
	wire alb;

	// Instantiate the Unit Under Test (UUT)
	comp #(.n(4)) uut (
		.a(a), 
		.b(b), 
		.agb(agb), 
		.aeb(aeb), 
		.alb(alb)
	);

	initial begin
		a = 0;		b = 0;
		#100 
        a = 4'b0011;	b = 4'b1101; 
		#100 
        a = 4'b1011;	b = 4'b1101; 
		#100 
        a = 4'b1010;	b = 4'b1001; 
		#100 
        a = 4'b1111;	b = 4'b0001;
        #100 
        a = 4'b0101;	b = 4'b0101; 
		#100 
        a = 4'b0000;	b = 4'b0110; 
		#100 
        a = 4'b0011;	b = 4'b1110; 
		#100 
        a = 4'b0010;	b = 4'b1111;
		#100  $stop; 
	end
      
endmodule

