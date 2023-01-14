//******************************************************************************
// MIPS verilog model
//
// ALU.v
//******************************************************************************

module ALU (
	// Outputs
	   ALUResult,
	// Inputs
	   ALUCode, A, B);
	input [3:0]	ALUCode;				// Operation select
	input [31:0]	A, B;
	output [31:0]	ALUResult;

// Decoded ALU operation select (ALUsel) signals
   parameter	 alu_add=  4'b0000;
   parameter	 alu_sub=  4'b0001;
   parameter	 alu_lui=  4'b0010;
   parameter	 alu_and=  4'b0011;
   parameter	 alu_xor=  4'b0100;
   parameter	 alu_or =  4'b0101;
   parameter 	 alu_sll=  4'b0110;
   parameter	 alu_srl=  4'b0111;
   parameter	 alu_sra=  4'b1000;
   parameter	 alu_slt=  4'b1001;
   parameter	 alu_sltu= 4'b1010; 	

   // 加、减法电路
   wire Binvert;
   wire[31:0] sum;
   assign Binvert = ~(ALUCode == 0);
   // 如果Binvert=0，则sum=A+B
   // 如果Binvert=1，则sum=A-B
   // A-B相当于A加上B的补码，即B取反再加1
   // 和全1异或，相当于取反（当Binvert=0时，和全0异或，B还是他本身，不影响结果）
   // 然后通过设置ci=Binvert实现加1
   // 由此，加、减法电路设计完成
   adder_32bits adder(
      .a(A),
      .b({32{Binvert}}^B),
      .ci(Binvert),
      .s(sum),
      .co()
   );

   // 比较电路
   wire isLT, isLTU;
   assign isLT = A[31]&&(~B[31]) || (A[31]~^B[31])&&sum[31];
   assign isLTU = (~A[31])&&B[31] || (A[31]~^B[31])&&sum[31];


   reg[31:0] ALUResult;
   reg signed[31:0] A_reg; //引入reg类型的中间变量A_reg，以进行算术右移操作
   always@(*)
   begin
      A_reg = A;
      case (ALUCode)
         alu_add: ALUResult = sum;
         alu_sub: ALUResult = sum;
         alu_lui: ALUResult = B;
         alu_and: ALUResult = A&B;
         alu_xor: ALUResult = A^B;
         alu_or:  ALUResult = A|B;
         alu_sll: ALUResult = A<<B;
         alu_srl: ALUResult = A>>B;
         alu_sra: ALUResult = A_reg>>>B;
         alu_slt: ALUResult = isLT?32'd1:32'd0;
         alu_sltu:ALUResult = isLTU?32'd1:32'd0;
         default: ALUResult = sum;
      endcase
   end

endmodule