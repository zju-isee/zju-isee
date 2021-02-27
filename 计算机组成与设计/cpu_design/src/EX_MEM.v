module EX_MEM (clk,
    MemtoReg_ex, RegWrite_ex, MemWrite_ex, ALUResult_ex, MemWriteData_ex, rdAddr_ex,
    MemtoReg_mem, RegWrite_mem, MemWrite_mem, ALUResult_mem, MemWriteData_mem, rdAddr_mem
    );
    input clk;
    input MemtoReg_ex, RegWrite_ex, MemWrite_ex;
    input[31:0] ALUResult_ex, MemWriteData_ex;
    input[4:0] rdAddr_ex;

    output reg MemtoReg_mem, RegWrite_mem, MemWrite_mem;
    output reg [31:0] ALUResult_mem, MemWriteData_mem;
    output reg [4:0] rdAddr_mem;

    always@(posedge clk)
    begin
        MemtoReg_mem <= MemtoReg_ex;
        RegWrite_mem <= RegWrite_ex;
        MemWrite_mem <= MemWrite_ex;
        ALUResult_mem <= ALUResult_ex;
        MemWriteData_mem <=MemWriteData_ex;
        rdAddr_mem <= rdAddr_ex;
    end
    
endmodule