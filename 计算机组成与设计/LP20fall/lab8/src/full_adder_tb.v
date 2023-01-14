`timescale 1ns/100ps
module full_adder_tb;
reg  a,b;
reg   ci;
wire  s;
wire  co;
parameter DELY=100;
full_adder  adder_inst(
.a(a),
.b(b),
.ci(ci),
.s(s),
.co(co));
initial begin 
       a=0; b=0;ci=0;
#DELY  a=0; b=0;ci=1;
#DELY  a=0; b=1;ci=0;
#DELY  a=0; b=1;ci=1;
#DELY  a=1; b=0;ci=0;
#DELY  a=1; b=0;ci=1;
#DELY  a=1; b=1;ci=0;
#DELY  a=1; b=1;ci=1;
#DELY $stop;
end
endmodule