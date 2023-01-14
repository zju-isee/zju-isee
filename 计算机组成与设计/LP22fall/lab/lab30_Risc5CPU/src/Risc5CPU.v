`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module Risc5CPU(clk, reset, JumpFlag, Instruction_id, ALU_A, 
                     ALU_B, ALUResult_ex, PC, MemDout_mem,Stall);
    input clk;
    input reset;
    output[1:0] JumpFlag;
    output [31:0] Instruction_id;
    output [31:0] ALU_A;
    output [31:0] ALU_B;
    output [31:0] ALUResult_ex;
    output [31:0] PC;
    output [31:0] MemDout_mem;
    output Stall;

    wire IFWrite, IF_flush;
    wire[31:0] JumpAddr;
    wire[31:0] Instruction_if, PC;

    wire MemtoReg_id, RegWrite_id, MemWrite_id, MemRead_id;
	wire[3:0] ALUCode_id;
	wire ALUSrcA_id;
	wire[1:0] ALUSrcB_id;
	wire[4:0] rdAddr_id, rs1Addr_id, rs2Addr_id;
    wire[31:0] rs1Data_id, rs2Data_id, PC_id, Imm_id;
    
    wire MemtoReg_ex, RegWrite_ex, MemWrite_ex, MemRead_ex;
	wire [3:0] ALUCode_ex;
	wire ALUSrcA_ex;
	wire [1:0] ALUSrcB_ex;
	wire [4:0] rdAddr_ex, rs1Addr_ex, rs2Addr_ex;
    wire [31:0] rs1Data_ex, rs2Data_ex, PC_ex, Imm_ex, MemWriteData_ex, ALUResult_ex;

    wire MemtoReg_mem, RegWrite_mem, MemWrite_mem;
    wire [31:0] ALUResult_mem, MemWriteData_mem;
    wire [4:0] rdAddr_mem;

    wire MemtoReg_wb, RegWrite_wb;
    wire [31:0] MemDout_wb, ALUResult_wb, RegWriteData_wb;
    wire [4:0] rdAddr_wb;


    IF IF_1(
        // Inputs
        .clk(clk), 
        .reset(reset), 
        .Branch(JumpFlag[0]),
        .Jump(JumpFlag[1]), 
        .IFWrite(IFWrite), 
        .JumpAddr(JumpAddr),
        // Outputs
        .Instruction_if(Instruction_if),
        .PC(PC),
        .IF_flush(IF_flush)
    );

    IF_ID IF_ID_1(
        // Inputs
        .clk(clk), 
        .en(IFWrite), 
        .reset(IF_flush|reset), 
        .PC_if(PC), 
        .Instruction_if(Instruction_if), 
        // Outputs
        .PC_id(PC_id), 
        .Instruction_id(Instruction_id)
    );


    ID ID_1(
        // Inputs
        .clk(clk),
        .Instruction_id(Instruction_id), 
        .PC_id(PC_id), 
        .RegWrite_wb(RegWrite_wb), 
        .rdAddr_wb(rdAddr_wb), 
        .RegWriteData_wb(RegWriteData_wb), 
        .MemRead_ex(MemRead_ex), 
        .rdAddr_ex(rdAddr_ex), 
        // Outputs
        .MemtoReg_id(MemtoReg_id), 
        .RegWrite_id(RegWrite_id), 
        .MemWrite_id(MemWrite_id), 
        .MemRead_id(MemRead_id), 
        .ALUCode_id(ALUCode_id), 
	    .ALUSrcA_id(ALUSrcA_id), 
        .ALUSrcB_id(ALUSrcB_id),  
        .Stall(Stall), 
        .Branch(JumpFlag[0]), 
        .Jump(JumpFlag[1]), 
        .IFWrite(IFWrite),  
        .JumpAddr(JumpAddr), 
        .Imm_id(Imm_id),
		.rs1Data_id(rs1Data_id), 
        .rs2Data_id(rs2Data_id),
        .rs1Addr_id(rs1Addr_id),
        .rs2Addr_id(rs2Addr_id),
        .rdAddr_id(rdAddr_id)
    );

    ID_EX ID_EX_1(
        // Inputs
        .clk(clk), 
        .reset(Stall|reset), 
        .MemtoReg_id(MemtoReg_id), 
        .RegWrite_id(RegWrite_id), 
        .MemWrite_id(MemWrite_id), 
        .MemRead_id(MemRead_id), 
        .ALUCode_id(ALUCode_id), 
        .ALUSrcA_id(ALUSrcA_id), 
        .ALUSrcB_id(ALUSrcB_id), 
        .PC_id(PC_id), 
        .Imm_id(Imm_id), 
        .rdAddr_id(rdAddr_id), 
        .rs1Addr_id(rs1Addr_id), 
        .rs2Addr_id(rs2Addr_id), 
        .rs1Data_id(rs1Data_id), 
        .rs2Data_id(rs2Data_id),
        // Outputs
        .MemtoReg_ex(MemtoReg_ex), 
        .RegWrite_ex(RegWrite_ex), 
        .MemWrite_ex(MemWrite_ex), 
        .MemRead_ex(MemRead_ex), 
        .ALUCode_ex(ALUCode_ex), 
        .ALUSrcA_ex(ALUSrcA_ex), 
        .ALUSrcB_ex(ALUSrcB_ex), 
        .PC_ex(PC_ex), 
        .Imm_ex(Imm_ex), 
        .rdAddr_ex(rdAddr_ex), 
        .rs1Addr_ex(rs1Addr_ex), 
        .rs2Addr_ex(rs2Addr_ex), 
        .rs1Data_ex(rs1Data_ex), 
        .rs2Data_ex(rs2Data_ex)
    );

    EX EX_1(
        // Inputs
        .ALUCode_ex(ALUCode_ex), 
        .ALUSrcA_ex(ALUSrcA_ex), 
        .ALUSrcB_ex(ALUSrcB_ex),
        .Imm_ex(Imm_ex), 
        .rs1Addr_ex(rs1Addr_ex), 
        .rs2Addr_ex(rs2Addr_ex), 
        .rs1Data_ex(rs1Data_ex), 
        .rs2Data_ex(rs2Data_ex), 
        .PC_ex(PC_ex), 
        .RegWriteData_wb(RegWriteData_wb), 
        .ALUResult_mem(ALUResult_mem),
        .rdAddr_mem(rdAddr_mem), 
        .rdAddr_wb(rdAddr_wb), 
		.RegWrite_mem(RegWrite_mem), 
        .RegWrite_wb(RegWrite_wb), 
        // Outputs
        .ALUResult_ex(ALUResult_ex), 
        .MemWriteData_ex(MemWriteData_ex), 
        .ALU_A(ALU_A), 
        .ALU_B(ALU_B)
    );

    EX_MEM EX_MEM_1(
        // Inputs
        .clk(clk),
        .MemtoReg_ex(MemtoReg_ex), 
        .RegWrite_ex(RegWrite_ex), 
        .MemWrite_ex(MemWrite_ex), 
        .ALUResult_ex(ALUResult_ex), 
        .MemWriteData_ex(MemWriteData_ex), 
        .rdAddr_ex(rdAddr_ex),
        // Outputs
        .MemtoReg_mem(MemtoReg_mem), 
        .RegWrite_mem(RegWrite_mem), 
        .MemWrite_mem(MemWrite_mem), 
        .ALUResult_mem(ALUResult_mem), 
        .MemWriteData_mem(MemWriteData_mem), 
        .rdAddr_mem(rdAddr_mem)
    );

    DataRAM DataRAM_1(
        // Inputs
        .a(ALUResult_mem[7:2]),
        .d(MemWriteData_mem),
        .clk(clk),
        .we(MemWrite_mem),
        // Outputs
        .spo(MemDout_mem)
    );


    MEM_WB MEM_WB_1(
        // Inputs
        .clk(clk),
        .MemtoReg_mem(MemtoReg_mem), 
        .RegWrite_mem(RegWrite_mem), 
        .MemDout_mem(MemDout_mem), 
        .ALUResult_mem(ALUResult_mem), 
        .rdAddr_mem(rdAddr_mem),
        // Outputs
        .MemtoReg_wb(MemtoReg_wb), 
        .RegWrite_wb(RegWrite_wb), 
        .MemDout_wb(MemDout_wb), 
        .ALUResult_wb(ALUResult_wb), 
        .rdAddr_wb(rdAddr_wb)
    );

    assign RegWriteData_wb = MemtoReg_wb?MemDout_wb:ALUResult_wb;

endmodule