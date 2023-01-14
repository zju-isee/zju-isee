`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module EX(ALUCode_ex, ALUSrcA_ex, ALUSrcB_ex,Imm_ex, rs1Addr_ex, rs2Addr_ex, rs1Data_ex, 
          rs2Data_ex, PC_ex, RegWriteData_wb, ALUResult_mem,rdAddr_mem, rdAddr_wb, 
		  RegWrite_mem, RegWrite_wb, ALUResult_ex, MemWriteData_ex, ALU_A, ALU_B);
    input [3:0] ALUCode_ex;
    input ALUSrcA_ex;
    input [1:0]ALUSrcB_ex;
    input [31:0] Imm_ex;
    input [4:0]  rs1Addr_ex;
    input [4:0]  rs2Addr_ex;
    input [31:0] rs1Data_ex;
    input [31:0] rs2Data_ex;
	input [31:0] PC_ex;
    input [31:0] RegWriteData_wb;
    input [31:0] ALUResult_mem;
	input [4:0]rdAddr_mem;
    input [4:0] rdAddr_wb;
    input RegWrite_mem;
    input RegWrite_wb;
    output [31:0] ALUResult_ex;
    output [31:0] MemWriteData_ex;
    output [31:0] ALU_A;
    output [31:0] ALU_B;

    // 数据前推电路
    // 通过信号控制数据选择器，实现转发
    wire[1:0] ForwardA, ForwardB;
    assign ForwardA[0] = RegWrite_wb && (rdAddr_wb!=0) && (rdAddr_mem!=rs1Addr_ex) && (rdAddr_wb==rs1Addr_ex);
    assign ForwardA[1] = RegWrite_mem && (rdAddr_mem!=0) && (rdAddr_mem==rs1Addr_ex);
    assign ForwardB[0] = RegWrite_wb && (rdAddr_wb!=0) && (rdAddr_mem!=rs2Addr_ex) && (rdAddr_wb==rs2Addr_ex);
    assign ForwardB[1] = RegWrite_mem && (rdAddr_mem!=0) && (rdAddr_mem==rs2Addr_ex);

    wire [31:0] A;
    mux3 mux_1(
        .in0(rs1Data_ex), 
        .in1(RegWriteData_wb), 
        .in2(ALUResult_mem), 
        .addr(ForwardA),
        .out(A)
    );

    wire [31:0] B;
    mux3 mux_2(
        .in0(rs2Data_ex), 
        .in1(RegWriteData_wb), 
        .in2(ALUResult_mem), 
        .addr(ForwardB),
        .out(B)
    );

    assign MemWriteData_ex = B;

    // 确定ALU_A
    assign ALU_A = ALUSrcA_ex?PC_ex:A;
    // 确定ALU_B
    mux3 mux_3(
        .in0(B),
        .in1(Imm_ex),
        .in2(32'd4),
        .addr(ALUSrcB_ex),
        .out(ALU_B)
    );
    // 确定ALUResult
    ALU ALU_1(
        .ALUCode(ALUCode_ex), 
        .A(ALU_A), 
        .B(ALU_B),
	    .ALUResult(ALUResult_ex)
    );


endmodule