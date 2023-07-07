module COLLECTOR(clk,q1,q0);

	input clk;
	output q1,q0;

	reg q1,q0;
	reg [1:0] counter;

	always @(posedge clk)
	begin 
		if(counter == 3) begin
		q1<=1;
		q0<=1;
		counter<=0;
		end
		else if(counter == 2) begin
		q1<=1;
		q0<=0;
		counter<=3;
		end
		else if(counter == 1) begin
		q1<=0;
		q0<=1;
		counter<=2;
		end
		else if(counter == 0) begin
		q1<=0;
		q0<=0;
		counter<=1;
		end
		else begin
		q1<=0;
		q0<=0;
		counter<=0;
		end

	end

endmodule
