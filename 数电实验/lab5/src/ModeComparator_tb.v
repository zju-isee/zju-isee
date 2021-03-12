`timescale 1 ps / 1 ps
module ModeComparator_tb;

wire[7:0] out;
reg[7:0]  a, b;
reg m;
ModeComparator  ModeComparator1(.a(a),.b(b),.m(m),.y(out));

initial
begin
	    m=0;//MAX
	    a = 8'd33;	b = 8'd122;
	#10	$display("MAX( %d , %d )= %d", a, b, out);
	#10	a = 8'd167;	b = 8'd4;
	#10	$display("MAX( %d , %d )= %d", a, b, out);
	#10	a = 8'd68;	b = 8'd68;
  #10	$display("MAX( %d , %d )= %d", a, b, out);
    
  
	#10	m=1;//MIN
	    a = 8'd5;	b = 8'd5;
	#10	$display("MIN( %d , %d )= %d", a, b, out);
	#10	a = 8'd112;	b = 8'd103;
	#10	$display("MIN( %d , %d )= %d", a, b, out);
	#10	a = 8'd132;	b = 8'd141;
  #10	$display("MIN( %d , %d )= %d", a, b, out);
	#10 $stop;
end



endmodule 