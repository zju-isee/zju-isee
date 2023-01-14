module BranchTest (Instruction, rs1Data, rs2Data, Branch);
    
    input[31:0] Instruction, rs1Data, rs2Data;
    output reg Branch;

    //Instruction type decode
    parameter SB_type_op    =   7'b1100011;
    parameter BEQ_FUNCT3    =   3'o0;
    parameter BNE_FUNCT3    =   3'o1;
    parameter BLT_FUNCT3    =   3'o4;
    parameter BGE_FUNCT3    =   3'o5;
    parameter BLTU_FUNCT3   =   3'o6;
    parameter BGEU_FUNCT3   =   3'o7;

    // sum = rs1Data + (~rs2Data) + 1
    wire[31:0] sum;
    adder_32bits adder(
        .a(rs1Data),
        .b(~rs2Data),
        .ci(1),
        .s(sum),
        .co()
    );

    wire isLT, isLTU;
    assign isLT = rs1Data[31]&&(~rs2Data[31]) || (rs1Data[31]~^rs2Data[31])&&sum[31];//符号数比较
    assign isLTU = (~rs1Data[31])&&rs2Data[31] || (rs1Data[31]~^rs2Data[31])&&sum[31];//无符号数比较

    wire[6:0] op;
    wire[2:0] funct3;
    wire SB_type;

    assign op = Instruction[6:0];
    assign funct3 = Instruction[14:12];
    assign SB_type = (op == SB_type_op);
    always@(*)
    begin
        if(SB_type) 
        begin
        case (funct3)
            BEQ_FUNCT3: Branch = ~(|sum[31:0]);
            BNE_FUNCT3: Branch = |sum[31:0];
            BLT_FUNCT3: Branch = isLT;
            BGE_FUNCT3: Branch = ~isLT;
            BLTU_FUNCT3:Branch = isLTU;
            BGEU_FUNCT3:Branch = ~isLTU;
            default:    Branch = 0;
        endcase
        end
        else 
            Branch = 0;
    end
    
endmodule