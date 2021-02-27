module mux2 (in0, in1, addr, out);
    // two to one
    parameter n = 4;
    input[n-1:0] in0, in1;
    input addr;
    output[n-1:0] out;

    assign out = addr?in1:in0;
endmodule