module ModeComparator(a, b, m, y);
    input [7:0] a, b;
    input m;
    output [7:0] y;
    wire agb;
    comp #(.N(8))comp_inst( .a(a),  .b(b),  .agb(agb), .aeb(),  .alb());
    mux_2to1 #(.N(8))  mux1(.out(y), .in0(a),  .in1(b), .addr(~(agb^m))); 
endmodule // ModeComparator