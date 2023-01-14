module mux3 (in0, in1, in2, addr, out);
    // three to one
    input[31:0] in0, in1, in2;
    input[1:0] addr;
    output reg [31:0] out;

    always@(*)
    begin
        case (addr)
            2'd0: out = in0;
            2'd1: out = in1;
            2'd2: out = in2;
            default: out = in0;
        endcase
    end
endmodule