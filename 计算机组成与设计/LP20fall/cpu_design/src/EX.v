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

    wire[1:0] ForwardA, ForwardB;
    wire[31:0] A_tmp, B_tmp;

    //Forward
    assign ForwardA[0] = RegWrite_wb && (rdAddr_wb!=0) && (rdAddr_mem!=rs1Addr_ex) && (rdAddr_wb==rs1Addr_ex);
    assign ForwardA[1] = RegWrite_mem && (rdAddr_mem!=0) && (rdAddr_mem==rs1Addr_ex);
    assign ForwardB[0] = RegWrite_wb && (rdAddr_wb!=0) && (rdAddr_mem!=rs2Addr_ex) && (rdAddr_wb==rs2Addr_ex);
    assign ForwardB[1] = RegWrite_mem && (rdAddr_mem!=0) && (rdAddr_mem==rs2Addr_ex);

    mux3 m_1(
        //input
        .in0(rs1Data_ex), 
        .in1(RegWriteData_wb), 
        .in2(ALUResult_mem), 
        .addr(ForwardA),
        //output 
        .out(A_tmp)
    );

    mux3 m_2(
        //input
        .in0(rs2Data_ex), 
        .in1(RegWriteData_wb), 
        .in2(ALUResult_mem), 
        .addr(ForwardB),
        //output 
        .out(B_tmp)
    );

    assign MemWriteData_ex = B_tmp;

    mux2 #(.n(32)) m_3(
        //input
        .in0(A_tmp),
        .in1(PC_ex),
        .addr(ALUSrcA_ex),
        //output
        .out(ALU_A)
    );

    mux3 m_4(
        //input
        .in0(B_tmp),
        .in1(Imm_ex),
        .in2(32'd4),
        .addr(ALUSrcB_ex),
        //output
        .out(ALU_B)
    );

    ALU ALU_1(
        // Outputs
	    .ALUResult(ALUResult_ex),
	    // Inputs
        .ALUCode(ALUCode_ex), 
        .A(ALU_A), 
        .B(ALU_B)
    );

endmodule
