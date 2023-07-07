module ENCODER(D0,D1,D2,D3,key_in);
    input D0,D1,D2,D3;
    output [3:0] key_in;

    assign key_in[0] = D0;
    assign key_in[1] = D1;
    assign key_in[2] = D2;
    assign key_in[3] = D3;

endmodule
