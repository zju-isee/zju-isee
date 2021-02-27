`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: ZJU
// Engineer: tangyi
////////////////////////////////////////////////////////////////////////////////
module IF_tb;
	// Inputs
	reg clk;
	reg reset;
	reg Branch;
	reg Jump;
	reg IFWrite;
	reg [31:0] JumpAddr;
	
	// Outputs
	wire [31:0] Instruction_if;
	wire IF_flush;
	wire [31:0] PC;
	// Instantiate the Unit Under Test (UUT)
	IF uut (
		.clk(clk), 
		.reset(reset), 
		.Branch(Branch), 
		.Jump(Jump), 
		.IFWrite(IFWrite), 
		.JumpAddr(JumpAddr),		
		.Instruction_if(Instruction_if), 
		.IF_flush(IF_flush), 
		.PC(PC)
	);
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		Branch = 0; Jump = 0;
		IFWrite = 1;
		JumpAddr = 32'd20;
		
		// Wait 100 ns for global reset to finish
		#100 reset=0;

		// Add stimulus here
		#800 Branch = 1; Jump = 0;
		#100 Branch = 0; Jump = 0;
		#600 Branch = 0; Jump = 1; JumpAddr = 32'd40;
		#100 Branch = 0; Jump = 0;
		#200 IFWrite = 0;
		#400 $stop;	
	end
	
	always #50 clk=~clk;

      
endmodule

