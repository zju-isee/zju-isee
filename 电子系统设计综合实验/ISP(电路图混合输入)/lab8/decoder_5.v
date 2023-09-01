module DECODER_5(in,Q0,Q1,Q2,Q3,Q4);
    input [4:0] in;
    output Q0,Q1,Q2,Q3,Q4;

    assign Q0 = in[0];
    assign Q1 = in[1];
    assign Q2 = in[2];
    assign Q3 = in[3];
    assign Q4 = in[4];

endmodule

