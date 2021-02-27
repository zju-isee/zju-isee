module adder_4bits(a, b, ci, s, co);
    input[3:0] a, b;
    input ci;
    output[3:0] s;
    output co;
    wire[3:0] p, g;
    wire[2:0] c;
    
    assign g = a & b;
    assign p = a | b;

    //各级进位
    assign c[0] = g[0] | p[0]&ci;
    assign c[1] = g[1] | p[1]&c[0];
    assign c[2] = g[2] | p[2]&c[1];
    assign co = g[3] | p[3]&c[2];

    //求和
    assign s[0] = p[0]&(~g[0])&(~ci) | (~(p[0]&(~g[0])))&ci;
    assign s[1] = p[1]&(~g[1])&(~c[0]) | (~(p[1]&(~g[1])))&c[0];
    assign s[2] = p[2]&(~g[2])&(~c[1]) | (~(p[2]&(~g[2])))&c[1];
    assign s[3] = p[3]&(~g[3])&(~c[2]) | (~(p[3]&(~g[3])))&c[2];
endmodule