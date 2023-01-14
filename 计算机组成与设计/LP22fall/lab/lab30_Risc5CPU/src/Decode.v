//******************************************************************************
// //
// Decode.v
//******************************************************************************

module Decode(   
	// Outputs
	MemtoReg, RegWrite, MemWrite, MemRead,ALUCode,ALUSrcA,ALUSrcB,Jump,JALR,Imm,offset,
	// Inputs
    Instruction);
	input [31:0]	Instruction;	// current instruction
	output		   MemtoReg;		// use memory output as data to write into register
	output		   RegWrite;		// enable writing back to the register
	output		   MemWrite;		// write to memory
	output         MemRead;
	output [3:0]   ALUCode;         // ALU operation select
	output      	ALUSrcA;
	output [1:0]   ALUSrcB;
	output         Jump;
	output         JALR;
	output[31:0]   Imm,offset;
	
//******************************************************************************
//  instruction type decode
//******************************************************************************
	parameter  R_type_op=   7'b0110011;
	parameter  I_type_op=   7'b0010011;
	parameter  SB_type_op=  7'b1100011;
	parameter  LW_op=       7'b0000011;
	parameter  JALR_op=     7'b1100111;
	parameter  SW_op=       7'b0100011;
	parameter  LUI_op=      7'b0110111;
	parameter  AUIPC_op=    7'b0010111;	
	parameter  JAL_op=      7'b1101111;	
//
  //
   parameter  ADD_funct3 =     3'b000 ;
   parameter  SUB_funct3 =     3'b000 ;
   parameter  SLL_funct3 =     3'b001 ;
   parameter  SLT_funct3 =     3'b010 ;
   parameter  SLTU_funct3 =    3'b011 ;
   parameter  XOR_funct3 =     3'b100 ;
   parameter  SRL_funct3 =     3'b101 ;
   parameter  SRA_funct3 =     3'b101 ;
   parameter  OR_funct3 =      3'b110 ;
   parameter  AND_funct3 =     3'b111;
   //
   parameter  ADDI_funct3 =     3'b000 ;
   parameter  SLLI_funct3 =     3'b001 ;
   parameter  SLTI_funct3 =     3'b010 ;
   parameter  SLTIU_funct3 =    3'b011 ;
   parameter  XORI_funct3 =     3'b100 ;
   parameter  SRLI_funct3 =     3'b101 ;
   parameter  SRAI_funct3 =     3'b101 ;
   parameter  ORI_funct3 =      3'b101 ;
   parameter  ANDI_funct3 =     3'b111;
   //
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

//******************************************************************************
// instruction field
//******************************************************************************
	wire [6:0]		op;
	wire  	 	    funct6_7;
	wire [2:0]		funct3;
	assign op			= Instruction[6:0];
	assign funct6_7		= Instruction[30];
 	assign funct3		= Instruction[14:12];
	
// 设置R_type、I_type、SB_ type、LW、JALR、SW、LUI、AUIPC 和JAL 等变量来表示指令类型
  wire R_type, I_type, SB_type, LW, JALR, SW, LUI, AUIPC, JAL;
  assign R_type = (op == R_type_op);
  assign I_type = (op == I_type_op);
  assign SB_type = (op == SB_type_op);
  assign LW = (op == LW_op);
  assign JALR = (op == JALR_op);
  assign SW = (op == SW_op);
  assign LUI = (op == LUI_op);
  assign AUIPC = (op == AUIPC_op);
  assign JAL = (op == JAL_op);

// 根据指令类型确定控制信号
  assign MemtoReg = LW;
  assign MemRead = LW;
  assign MemWrite = SW;
  assign RegWrite = R_type || I_type || LW || JALR || LUI || AUIPC || JAL;
  assign Jump = JALR || JAL;

// 根据指令类型确定ALUSrcA_id和ALUSrcB_id
// 需要注意的是，提供的框架中，变量名为ALUSrcA和ALUSrcB和实验手册不一致
  assign ALUSrcA = JALR || JAL || AUIPC;
  assign ALUSrcB[1] = JAL || JALR;
  assign ALUSrcB[0] = ~(R_type || JAL || JALR);

  reg[31:0] ALUCode, Imm, offset;
  always@(*)
  begin
    if (LUI&(~R_type)&(~I_type))
      ALUCode = alu_lui;
    else if((R_type|I_type)&(~LUI)) 
    begin
      case (funct3)
        ADD_funct3: begin
                    // funct3=3'o0,如果funct6_7=0,则ALUCode=4'd0
                    // 如果是R_type而且funct6_7=1,那么是减法，ALUCode=4'd1
                    if((R_type&(~funct6_7))|I_type)
                      ALUCode = alu_add;
                    else if(R_type&funct6_7)
                      ALUCode = alu_sub;
                    end
        SLL_funct3: begin
                    // 同上，对照表30.5翻译成代码即可
                    if((R_type&(~funct6_7))|I_type)
                      ALUCode = alu_sll;
                    end
        SLT_funct3: begin
                    if((R_type&(~funct6_7))|I_type)
                      ALUCode = alu_slt;
                    end
        SLTU_funct3:begin 
                    if((R_type&(~funct6_7))|I_type)
                      ALUCode = alu_sltu;
                    end 
        XOR_funct3: begin
                    if((R_type&(~funct6_7))|I_type)
                      ALUCode = alu_xor;
                    end
        SRL_funct3: begin
                    if((R_type&(~funct6_7))|(I_type&(~funct6_7)))
                      ALUCode = alu_srl;
                    else if((R_type&funct6_7)|(I_type&funct6_7))
                      ALUCode = alu_sra;
                    end             
        OR_funct3:  begin
                    if((R_type&(~funct6_7))|I_type)
                      ALUCode = alu_or;
                    end    
        AND_funct3: begin
                    if((R_type&(~funct6_7))|I_type)
                      ALUCode = alu_and;
                    end   
        // 加法为默认算法
        default:    ALUCode = alu_add; 
      endcase 
    end

    else 
      ALUCode = alu_add;
  end


  // 首先判断是否是移位运算
  // Shift=1表示移位运算，否为则算术逻辑运算
  wire Shift;
  assign Shift = (funct3 == 1) || (funct3 == 5);

  always@(*)
  begin
    // 根据表30.6翻译成代码即可
    if(I_type) 
    begin
      Imm = Shift?{26'd0, Instruction[25:20]}:{{20{Instruction[31]}}, Instruction[31:20]}; 
      offset = 32'bx;
    end
    else if(LW)
    begin 
      Imm = {{20{Instruction[31]}}, Instruction[31:20]}; 
      offset = 32'bx; 
    end
    else if(JALR) 
    begin 
      Imm = 32'bx; 
      offset = {{20{Instruction[31]}}, Instruction[31:20]}; 
    end
    else if(SW) 
    begin 
      Imm = {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7]}; 
      offset= 32'bx; 
    end
    else if(JAL) 
    begin
      Imm = 32'bx;
      offset = {{11{Instruction[31]}}, Instruction[31], Instruction[19:12], Instruction[20], Instruction[30:21], 1'b0}; 
    end
    else if(LUI || AUIPC) 
    begin
      Imm = {Instruction[31:12], 12'd0};
      offset= 32'bx;
    end
    else if(SB_type) 
    begin
      Imm = 32'bx;
      offset = {{19{Instruction[31]}}, Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0};
    end
    else
    begin 
      Imm = 32'bx;
      offset = 32'bx;
    end
  end


endmodule