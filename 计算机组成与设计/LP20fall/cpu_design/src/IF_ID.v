module IF_ID (clk, EN, R, PC_if, Instruction_if, PC_id, Instruction_id);
    input clk, EN, R;
    input[31:0] PC_if, Instruction_if;
    output reg [31:0] PC_id, Instruction_id;

    always@(posedge clk)
    begin
        if(R) begin PC_id <= 0; Instruction_id <= 0; end
        else if(EN) begin PC_id <= PC_if; Instruction_id <= Instruction_if; end
        else begin PC_id <= PC_id; Instruction_id <= Instruction_id; end
    end
 
endmodule