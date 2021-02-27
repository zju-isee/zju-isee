module synch(clk, in, out);
input clk, in;
output out;
reg q1, q2;
//非阻塞赋值
always @(posedge clk) begin
    q1 <= in;
    q2 <= q1;
end
assign out = q1 && (~q2);
endmodule // synch