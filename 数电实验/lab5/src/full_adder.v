module full_adder(a, b, s, co);
    input a, b;
    output reg s;
    output reg co;
    always @*
        begin
            {co, s}=a+b;
        end
endmodule // 