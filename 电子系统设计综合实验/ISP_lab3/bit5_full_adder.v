/*
ci 为 c_-1;
4位超前进位加法器的数据流描述
见数据系统设计实验教程lab8

*/
module bit5_full_adder(a,b,s,ci,co);

    input wire[4:0]a,b;
    input wire ci;
    output wire[4:0]s;
    output wire co;

    wire [4:0] g,p,c;
    assign g=a&b;
    assign p=a|b;
    
    assign c[0]=g[0]|(p[0]&ci);
    assign c[1]=g[1]|(p[1]&g[0])|(p[1]&p[0]&ci);
    assign c[2]=g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0])|(p[2]&p[1]&p[0]&ci);
    assign c[3]=g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&g[0])|(p[3]&p[2]&p[1]&p[0]&ci);
    assign c[4] = g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))));

    assign s=p&(~g)^({c[3:0],ci});
    assign co=c[4];

endmodule