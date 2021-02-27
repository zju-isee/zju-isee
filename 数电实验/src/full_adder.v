module full_adder(a, b, s, co);
    input [21:0] a;
    input [21:0] b;
    output reg [21:0] s;
    output reg co;
    always @*
        begin
            {co, s}=a+b;
        end
endmodule // full_adder