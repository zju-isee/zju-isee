module adder_4bits_part (a, b, ci, s, co);
    input[3:0] a, b;
    input ci;
    output[3:0] s;
    output co;
    wire[3:0] s0, s1;
    wire c0, c1;
    adder_4bits a0(.a(a), .b(b), .ci(0), .s(s0), .co(c0));
    adder_4bits a1(.a(a), .b(b), .ci(1), .s(s1), .co(c1));
    mux2 m(.in0(s0), .in1(s1), .addr(ci), .out(s));
    assign co = ci&c1 | c0;
endmodule