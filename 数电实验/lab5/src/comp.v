module comp(a, b, agb, aeb, alb);
    parameter N=1;
    input[N-1:0] a, b;
    output reg agb, aeb, alb;
    always @*
        begin
            if(a>b) {agb, aeb, alb}=3'b100;
            else if(a==b) {agb, aeb, alb}=3'b010;
            else {agb, aeb, alb}=3'b001;
        end
endmodule // 