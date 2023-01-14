`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: ZJU
// Engineer: tangyi
////////////////////////////////////////////////////////////////////////////////

module ALU_tb;

	// Inputs
	reg [3:0] ALUCode;
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire [31:0] ALUResult;
	
	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.ALUResult(ALUResult), 
		.ALUCode(ALUCode), 
		.A(A), 
		.B(B)
	);

	initial begin
		// Initialize Inputs
		ALUCode = 4'd0; A = 32'h00004012; B = 32'h1000200F;//add
		      
		// Add stimulus here
		#100 ALUCode = 4'd0; A = 32'h80000000;	B = 32'h80000000;//add
		#100 ALUCode = 4'd1; A = 32'h70F0C0E0;	B = 32'h10003054;//sub
		#100 ALUCode = 4'd2; A = 32'h70F0C0E0;	B = 32'h00003000;//lui
		#100 ALUCode = 4'd3; A = 32'hFF0C0E10;	B = 32'h10DF30FF;//and
		#100 ALUCode = 4'd4; A = 32'hFF0C0E10;	B = 32'h10DF30FF;//xor
		#100 ALUCode = 4'd5; A = 32'hFF0C0E10;	B = 32'h10DF30FF;//or
		#100 ALUCode = 4'd6; A = 32'hFFFFE0FF;	B = 32'h00000004;//sll
		#100 ALUCode = 4'd7; A = 32'hFFFFE0FF;	B = 32'h00000004;//srl
		#100 ALUCode = 4'd8; A = 32'hFFFFE0FF; B = 32'h00000004;//sra
		#100 ALUCode = 4'd9; A = 32'hFF000004;	B = 32'h700000FF;//slt
		#100 ALUCode = 4'd10;A = 32'hFF000004;	B = 32'h700000FF;//sltu
		#100 $stop;

	end
      
endmodule

