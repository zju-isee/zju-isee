module ID_EX (clk, R, 
    MemtoReg_id, RegWrite_id, MemWrite_id, MemRead_id, ALUCode_id, ALUSrcA_id, ALUSrcB_id, 
    PC_id, Imm_id, rdAddr_id, rs1Addr_id, rs2Addr_id, rs1Data_id, rs2Data_id,
    MemtoReg_ex, RegWrite_ex, MemWrite_ex, MemRead_ex, ALUCode_ex, ALUSrcA_ex, ALUSrcB_ex, 
    PC_ex, Imm_ex, rdAddr_ex, rs1Addr_ex, rs2Addr_ex, rs1Data_ex, rs2Data_ex);

    input clk, R;
	input MemtoReg_id, RegWrite_id, MemWrite_id, MemRead_id;
	input[3:0] ALUCode_id;
	input ALUSrcA_id;
	input[1:0] ALUSrcB_id;
	input[4:0] rdAddr_id, rs1Addr_id, rs2Addr_id;
    input[31:0] rs1Data_id, rs2Data_id, PC_id, Imm_id;

    output reg MemtoReg_ex, RegWrite_ex, MemWrite_ex, MemRead_ex;
	output reg [3:0] ALUCode_ex;
	output reg ALUSrcA_ex;
	output reg [1:0] ALUSrcB_ex;
	output reg [4:0] rdAddr_ex, rs1Addr_ex, rs2Addr_ex;
    output reg [31:0] rs1Data_ex, rs2Data_ex, PC_ex, Imm_ex;

    always@(posedge clk)
    begin
        if(R) begin
            MemtoReg_ex <= 0; 
            RegWrite_ex <= 0; 
            MemWrite_ex <= 0; 
            MemRead_ex <= 0;
            ALUCode_ex <= 0; 
            ALUSrcA_ex <= 0; 
            ALUSrcB_ex <= 0; 
            PC_ex <= 0; 
            Imm_ex <= 0; 
            rdAddr_ex <= 0;
            rs1Addr_ex <= 0;
            rs2Addr_ex <= 0;
            rs1Data_ex <= 0;
            rs2Data_ex <= 0;
        end
        else begin
            MemtoReg_ex <= MemtoReg_id; 
            RegWrite_ex <= RegWrite_id; 
            MemWrite_ex <= MemWrite_id; 
            MemRead_ex <= MemRead_id;
            ALUCode_ex <= ALUCode_id; 
            ALUSrcA_ex <= ALUSrcA_id; 
            ALUSrcB_ex <= ALUSrcB_id; 
            PC_ex <= PC_id; 
            Imm_ex <= Imm_id; 
            rdAddr_ex <= rdAddr_id;
            rs1Addr_ex <= rs1Addr_id;
            rs2Addr_ex <= rs2Addr_id;
            rs1Data_ex <= rs1Data_id;
            rs2Data_ex <= rs2Data_id;
        end
    end
    
endmodule