`timescale 1ns/10ps
module complement_adder_tb;
reg [15:0] a,b;
wire [16:0]s;
parameter DELY=100;
complement_adder complement_adder_inst(
.a(a),
.b(b),
.s(s));

initial begin
       a=2475; b=8655;
#DELY  a=5167; b=30126;
#DELY  a=32767; b=32767;
#DELY  a=-32768; b=-32768;
#DELY  a=-475; b=-25;
#DELY  a=-259; b=930;
#DELY  a=-24575; b=8965;
#DELY $stop;
end
endmodule