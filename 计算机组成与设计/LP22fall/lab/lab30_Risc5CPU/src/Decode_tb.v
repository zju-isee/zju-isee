`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: ZJU
// Engineer: tangyi
 ////////////////////////////////////////////////////////////////////////////////
module Decode_tb;

	// Inputs
	reg [31:0] Instruction;

	// Outputs
	wire MemtoReg;
	wire RegWrite;
	wire MemWrite;
	wire MemRead;
	wire [3:0] ALUCode;
	wire ALUSrcA;
	wire [1:0] ALUSrcB;
	wire Jump;
	wire JALR;
	wire [31:0] Imm,offset;

	// Instantiate the Unit Under Test (UUT)
	Decode uut (
		.MemtoReg(MemtoReg), 
		.RegWrite(RegWrite), 
		.MemWrite(MemWrite), 
		.MemRead(MemRead), 
		.ALUCode(ALUCode), 
		.ALUSrcA(ALUSrcA), 
		.ALUSrcB(ALUSrcB), 		
		.Jump(Jump), 
		.JALR(JALR),
		.Imm(Imm),
		.offset(offset), 
		.Instruction(Instruction)
	);

	initial begin
		// Initialize Inputs
		Instruction = 32'h00003f37;//lui  X30, 0x3000	
        
		// Add stimulus here		
		#200 Instruction = 32'h02000fe7;//jalr X31, later(X0)
		#200 Instruction = 32'h00001c63;//bne  X0, X0, end
		#200 Instruction = 32'h042f0293;//addi X5, X30, 42
		#200 Instruction = 32'h01f00333;//add  X6, X0, X31
		#200 Instruction  = 32'h406283b3;//sub  X7, X5, X6		
		#200 Instruction = 32'h0053ee33;//or	 X28, X7, X5		
		#200 Instruction = 32'hfc000ae3;//beq X0, X0, earlier
		#200 Instruction = 32'h001c2623;//sw  X28, 0C(X0)	
		#200 Instruction = 32'h00432e83;//lw X29, 04(X6)
		#200 Instruction = 32'h002e9293;//sll X5, X29,2
		#200 Instruction = 32'h00733e33;//sltu X28, X6,X7
		#200 Instruction = 32'h0000f6f;//jal  X31, done
	
        #200 $stop;
	end
      
endmodule

