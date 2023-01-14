module adder_4bits(a, b, ci, s, co);
    input[3:0] a, b;
    input ci;
    output[3:0] s;
    output co;
    wire[3:0] g, p;     // 辅助变量g和p，其中g[i] = a[i] & b[i]、 p[i] = a[i] + b[i]
    wire[2:0] c;        // 按教材C应当和加数A、B的位数保持一致，也就是4bit，但是实际上C[3]就是co，所以我们可以由 co c[2:0]  拼凑出 4bit的 C
    
    assign g = a & b;
    assign p = a | b;

    // 5.12(2) 先行进位计算
    assign c[0] = g[0] | p[0]&ci;
    assign c[1] = g[1] | p[1]&c[0];
    assign c[2] = g[2] | p[2]&c[1];
    assign co = g[3] | p[3]&c[2];

    // 5.12(1) 各位和计算
    assign s[0] = (p[0]&(~g[0])) ^ (ci);
    assign s[1] = (p[1]&(~g[1])) ^ (c[0]);
    assign s[2] = (p[2]&(~g[2])) ^ (c[1]);
    assign s[3] = (p[3]&(~g[3])) ^ (c[2]);
endmodule