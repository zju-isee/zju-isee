module adder_32bits (a, b, ci, s, co);
    input[31:0] a, b;
    input ci;
    output[31:0] s;
    output co;

    wire[7:0] c, ctmp;  //进位
    wire[31:0] stmp1, stmp0;  //本位

    //最低位计算块，得到s[7:0]
    adder_4bits i1( .a(a[3:0]), .b(b[3:0]), .ci(ci), .s(s[3:0]), .co(c[0]) );

    assign ctmp[0] = c[0];
    assign stmp1[3:0] = s[3:0];
    assign stmp0[3:0] = s[3:0];

    // 并行计算，得到stmp1[31:8]，stmp0[31:8]，c[7:1]，ctmp[7:1]，为数据选择做准备
    adder_4bits i21( .a(a[7:4]), .b(b[7:4]), .ci(1), .s(stmp1[7:4]), .co(c[1]) );
    adder_4bits i22( .a(a[7:4]), .b(b[7:4]), .ci(0), .s(stmp0[7:4]), .co(ctmp[1]) );

    adder_4bits i31( .a(a[11:8]), .b(b[11:8]), .ci(1), .s(stmp1[11:8]), .co(c[2]) );
    adder_4bits i32( .a(a[11:8]), .b(b[11:8]), .ci(0), .s(stmp0[11:8]), .co(ctmp[2]) );

    adder_4bits i41( .a(a[15:12]), .b(b[15:12]), .ci(1), .s(stmp1[15:12]), .co(c[3]) );
    adder_4bits i42( .a(a[15:12]), .b(b[15:12]), .ci(0), .s(stmp0[15:12]), .co(ctmp[3]) );

    adder_4bits i51( .a(a[19:16]), .b(b[19:16]), .ci(1), .s(stmp1[19:16]), .co(c[4]) );
    adder_4bits i52( .a(a[19:16]), .b(b[19:16]), .ci(0), .s(stmp0[19:16]), .co(ctmp[4]) );

    adder_4bits i61( .a(a[23:20]), .b(b[23:20]), .ci(1), .s(stmp1[23:20]), .co(c[5]) );
    adder_4bits i62( .a(a[23:20]), .b(b[23:20]), .ci(0), .s(stmp0[23:20]), .co(ctmp[5]) );

    adder_4bits i71( .a(a[27:24]), .b(b[27:24]), .ci(1), .s(stmp1[27:24]), .co(c[6]) );
    adder_4bits i72( .a(a[27:24]), .b(b[27:24]), .ci(0), .s(stmp0[27:24]), .co(ctmp[6]) );

    adder_4bits i81( .a(a[31:28]), .b(b[31:28]), .ci(1), .s(stmp1[31:28]), .co(c[7]) );
    adder_4bits i82( .a(a[31:28]), .b(b[31:28]), .ci(0), .s(stmp0[31:28]), .co(ctmp[7]) );

    // 数据选择器，得到s[31:8]
    mux2 m1( .in0(stmp0[7:4]), .in1(stmp1[7:4]), .addr(c[0]), .out(s[7:4]) );
    mux2 m2( .in0(stmp0[11:8]), .in1(stmp1[11:8]), .addr(c[0]&c[1] | ctmp[1]), .out(s[11:8]));
    mux2 m3( .in0(stmp0[15:12]), .in1(stmp1[15:12]), .addr(c[1]&c[2] | ctmp[2]), .out(s[15:12]));
    mux2 m4( .in0(stmp0[19:16]), .in1(stmp1[19:16]), .addr(c[2]&c[3] | ctmp[3]), .out(s[19:16]));
    mux2 m5( .in0(stmp0[23:20]), .in1(stmp1[23:20]), .addr(c[3]&c[4] | ctmp[4]), .out(s[23:20]));
    mux2 m6( .in0(stmp0[27:24]), .in1(stmp1[27:24]), .addr(c[4]&c[5] | ctmp[5]), .out(s[27:24]));
    mux2 m7( .in0(stmp0[31:28]), .in1(stmp1[31:28]), .addr(c[5]&c[6] | ctmp[6]), .out(s[31:28]));

    // 得到最终进位co
    assign co = c[6]&c[7] | ctmp[7];    
endmodule