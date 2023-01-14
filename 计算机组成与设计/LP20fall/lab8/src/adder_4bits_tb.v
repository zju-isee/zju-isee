`timescale 1ns/10ps
module adder_4bits_tb;
reg [3:0] a,b;
reg cin;
wire[3:0] sum;
wire cout;

parameter DELY=100;
adder_4bits adder_4bits_inst(
.a(a),
.b(b),
.ci(cin),
.s(sum),
.co(cout));
initial begin 
       a=4'd3;  b=4'd2;  cin=1;
#DELY  a=4'd3;  b=4'd2;  cin=0;
#DELY  a=4'd5;  b=4'd10; cin=1;
#DELY  a=4'd5;  b=4'd10; cin=0;
#DELY  a=4'd6;  b=4'd10; cin=1;
#DELY  a=4'd6;  b=4'd10; cin=0;
#DELY  a=4'd9;  b=4'd12; cin=1;
#DELY  a=4'd9;  b=4'd12; cin=0;
#DELY  a=4'd15; b=4'd15; cin=1;
#DELY  a=4'd15; b=4'd15; cin=0;
#DELY $stop;
end
endmodule