`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//////////////////////////////////////////////////////////////////////////////////
module ID(clk,Instruction_id, PC_id, RegWrite_wb, rdAddr_wb, RegWriteData_wb, MemRead_ex, 
          rdAddr_ex, MemtoReg_id, RegWrite_id, MemWrite_id, MemRead_id, ALUCode_id, 
			 ALUSrcA_id, ALUSrcB_id,  Stall, Branch, Jump, IFWrite,  JumpAddr, Imm_id,
			 rs1Data_id, rs2Data_id,rs1Addr_id,rs2Addr_id,rdAddr_id);
    input clk;
    input [31:0] Instruction_id;
    input [31:0] PC_id;
    input RegWrite_wb;
    input [4:0] rdAddr_wb;
    input [31:0] RegWriteData_wb;
    input MemRead_ex;
    input [4:0] rdAddr_ex;
    output MemtoReg_id;
    output RegWrite_id;
    output MemWrite_id;
    output MemRead_id;
    output [3:0] ALUCode_id;
    output ALUSrcA_id;
    output [1:0]ALUSrcB_id;
    output Stall;
    output Branch;
    output Jump;
    output IFWrite;
    output [31:0] JumpAddr;
    output [31:0] Imm_id;
    output [31:0] rs1Data_id;
    output [31:0] rs2Data_id;
	output[4:0] rs1Addr_id,rs2Addr_id,rdAddr_id;
 
    assign rs1Addr_id = Instruction_id[19:15];
    assign rs2Addr_id = Instruction_id[24:20];
    assign rdAddr_id = Instruction_id[11:7];

    // 寄存器堆
    Registers Registers0(
        // Inputs
        .clk(clk),
        .rs1Addr(rs1Addr_id), 
        .rs2Addr(rs2Addr_id),
        .RegWrite(RegWrite_wb), 
        .WriteAddr(rdAddr_wb),
        .WriteData(RegWriteData_wb),
        // Outputs
        .rs1Data(rs1Data_id),
        .rs2Data(rs2Data_id)
    );


    wire JALR;
    wire[31:0] offset;
    // 指令译码模块
    Decode Decode0(
        // Inputs
        .Instruction(Instruction_id),
        // Outputs
        .MemtoReg(MemtoReg_id), 
        .RegWrite(RegWrite_id), 
        .MemWrite(MemWrite_id), 
        .MemRead(MemRead_id),
        .ALUCode(ALUCode_id),
        .ALUSrcA(ALUSrcA_id),
        .ALUSrcB(ALUSrcB_id),
        .Jump(Jump),
        .JALR(JALR),
        .Imm(Imm_id),
        .offset(offset)
    );

    // 分支检测
    BranchTest BranchTest0(
        // Inputs
        .Instruction(Instruction_id),
        .rs1Data(rs1Data_id), 
        .rs2Data(rs2Data_id),
        // Outputs
        .Branch(Branch)
    );

    // 根据JALR信号决定基地址
    // 并把基地址保存在变量base_addr中
    wire[31:0] base_addr;
    assign base_addr = JALR?rs1Data_id:PC_id;

    // 计算跳转指令的目标地址
    // JumpAddr = base_addr + offset
    adder_32bits adder0(
        .a(offset), 
        .b(base_addr), 
        .ci(0), 
        .s(JumpAddr), 
        .co()
    );

    // 冒险检测
    assign Stall = ((rdAddr_ex==rs1Addr_id) || (rdAddr_ex==rs2Addr_id)) && MemRead_ex;
    assign IFWrite = ~Stall;    

endmodule