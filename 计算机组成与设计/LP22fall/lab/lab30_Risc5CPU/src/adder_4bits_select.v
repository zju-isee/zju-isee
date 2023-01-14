module adder_4bits_select (a, b, ci, s, co);
    input[3:0] a, b;
    input ci;
    output[3:0] s;
    output co;
    wire[3:0] s0, s1;
    wire c0, c1;
    adder_4bits adder0(.a(a), .b(b), .ci(0), .s(s0), .co(c0));
    adder_4bits adder1(.a(a), .b(b), .ci(1), .s(s1), .co(c1));

    // 根据是否有前级进位ci选择输出
    assign s = ci?s1:s0;
    assign co = ci?c1:c0;

endmodule