`timescale 1ns/10ps
module  pipeline_adder_tb;
reg clk;
reg [31:0] a,b;
reg ci; 
wire [31:0]s;
wire co;
parameter DELY=100;
pipeline_adder  pipeline_adder_inst(
.clk(clk),
.a(a),
.b(b),
.ci(ci),
.s(s),
.co(co));
initial begin clk=0; forever #(DELY/2) clk=~clk ;end
initial begin
       a=32'h00002475; b=32'h30561c86;ci=0;
#DELY  a=32'h321451c7; b=32'h0000093b;ci=0;
#DELY  a=32'ha0987557; b=32'hff004ab4;ci=0;
#DELY  a=32'h3b1e1234; b=32'h4395ab46;ci=0;
#DELY  a=32'hb4750109; b=32'h5c86ba90;ci=1;
#DELY  a=32'hf1c70078; b=32'h6936579b;ci=1;
#DELY  a=32'h45750000; b=32'h76893ab4;ci=1;
#DELY  a=32'h2b1e1111; b=32'hd395ffef;ci=1;
#DELY  a=3216'h0;    b=16'h0;   ci=0;
#DELY  a=32'hffffffff;   b=16'h1;   ci=0;
#(DELY*20) $stop;
end
endmodule