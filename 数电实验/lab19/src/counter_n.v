module counter_n(clk, r, en, q, co);
parameter n = 2, counter_bits = 1;
input clk, r, en;
output co;//进位输出
output reg [counter_bits-1:0] q = 0;
assign co = (q==(n-1)) && en;
always @(posedge clk) begin
    if(r) q = 0;
    else if(en) begin
            if(q==(n-1)) q = 0; //同步清零
            else q = q+1; end
         else q = q;
end
endmodule // counter_n