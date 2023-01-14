module mux2 (in0, in1, addr, out);
    // 二选一数据选择器
    input[3:0] in0, in1;
    input addr;
    output[3:0] out;

    assign out[3:0] = addr?in1[3:0]:in0[3:0];
endmodule