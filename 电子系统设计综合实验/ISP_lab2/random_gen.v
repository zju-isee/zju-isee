module random_gen(clk,start,num,odd);
    input start,clk;
    output odd;
    output [3:0] num;
    reg [3:0] num=4'b1111;
    reg odd;

    wire [3:0] numNow;
    counter_n #(.n(10),.counter_bits(4)) conter_9(.clk(clk),.r(1'b0),.en(1'b1),.co(),.q(numNow));

    always@(posedge start)//牢记！是低电平触发！
        begin
            num=numNow;
            odd=(num[0]==1'b1)?1'b1:1'b0;
        end
endmodule

