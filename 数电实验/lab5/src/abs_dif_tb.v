module abs_dif_tb;

wire[3:0] out;
reg[3:0]  a, b;
abs_dif  abs_dif1(.aIn(a),.bIn(b),.out(out));

initial
begin
	    a = 4'd3;	b = 4'd12;
	#10	$display("| %d - %d |= %d", a, b, out);
	#10	a = 4'd10;	b = 4'd4;
	#10	$display("| %d - %d |= %d", a, b, out);
	#10	a = 4'd5;	b = 4'd5;
	#10	$display("| %d - %d |= %d", a, b, out);
	#10	a = 4'd12;	b = 4'd0;
	#10	$display("| %d - %d |= %d", a, b, out);
	#10 $stop;
end



endmodule //float_add_tb