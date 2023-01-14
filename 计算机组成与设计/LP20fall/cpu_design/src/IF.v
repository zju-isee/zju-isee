`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module IF(clk, reset, Branch,Jump, IFWrite, JumpAddr,Instruction_if,PC,IF_flush);
    input clk;
    input reset;
    input Branch;
    input Jump;
    input IFWrite;
    input [31:0] JumpAddr;
    output [31:0] Instruction_if;
    output [31:0] PC;
    output IF_flush;

    wire[31:0] NextPC_if, PC_tmp;
    reg[31:0] PC;

    assign IF_flush = Branch || Jump;

    mux2 #(.n(32)) m_1(
        .in0(NextPC_if), 
        .in1(JumpAddr), 
        .addr(IF_flush), 
        .out(PC_tmp)
    );

    always@(posedge clk)
    begin
        if(reset) PC <= 0;
        else if(IFWrite) PC <= PC_tmp;
        else PC <= PC;
    end

    adder_32bits adder_1(
        .a(PC), 
        .b(32'd4), 
        .ci(0), 
        .s(NextPC_if), 
        .co()
    );

    InstructionROM Inst_1(
        .addr(PC[7:2]),
        .dout(Instruction_if)
    );


endmodule
