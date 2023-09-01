module D_TRIGGER(d,clk,q);
	input clk;
	input d;
	output reg q;
	//reg q;
	
	always @(posedge clk)
		begin 
			q <= d;
		end
endmodule
