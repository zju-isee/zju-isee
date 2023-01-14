`timescale 1ns/10ps
module adder_32bits_tb;
reg [31:0] a,b;
reg ci; 
wire [31:0]s;
wire co;
parameter DELY=100;
adder_32bits adder_32bits_inst(
.a(a),
.b(b),
.ci(ci),
.s(s),
.co(co));

initial begin
       a=32'ha0022475; b=32'h85561c86;ci=0;
#DELY  a=32'h57b451c7; b=32'h9712093b;ci=0;
#DELY  a=32'ha0000575; b=32'h00004ab4;ci=0;
#DELY  a=32'h4bbc3b1e; b=32'h5aa64395;ci=0;
#DELY  a=32'h0145b475; b=32'h67845c86;ci=1;
#DELY  a=32'hf00041c7; b=32'h9677693b;ci=1;
#DELY  a=32'h451bcd75; b=32'h30981ab4;ci=1;
#DELY  a=32'h00002b1e; b=32'hd3950000;ci=1;
#DELY  a=32'h0;        b=32'h0;   ci=0;
#DELY  a=32'hfffffff0; b=32'hf;   ci=1;
#DELY $stop;
end
endmodule