module MEM_WB (clk,
    MemtoReg_mem, RegWrite_mem, MemDout_mem, ALUResult_mem, rdAddr_mem,
    MemtoReg_wb, RegWrite_wb, MemDout_wb, ALUResult_wb, rdAddr_wb
    );
    input clk;
    input MemtoReg_mem, RegWrite_mem;
    input[31:0] MemDout_mem, ALUResult_mem;
    input[4:0] rdAddr_mem;

    output reg MemtoReg_wb, RegWrite_wb;
    output reg [31:0] MemDout_wb, ALUResult_wb;
    output reg [4:0] rdAddr_wb;

    always@(posedge clk)
    begin
        MemtoReg_wb <= MemtoReg_mem;
        RegWrite_wb <= RegWrite_mem;
        MemDout_wb <= MemDout_mem; 
        ALUResult_wb <= ALUResult_mem;
        rdAddr_wb <= rdAddr_mem;
    end
    
endmodule