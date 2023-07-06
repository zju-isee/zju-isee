module dffre(d,r,clk,q);
    parameter n=1;//n为寄存器的位数，n=1时为D触发器
    
    input clk,r;
    input [n:1]d;
    output [n:1]q;
       reg [n:1]q=0;

    always @(posedge clk)
        begin
            if(r)   q=0;
            else q=d;
        end
endmodule
