// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Mon May 29 00:01:33 2023
//
// Verilog Description of module ENCODER
//

module ENCODER (D0, D1, D2, D3, key_in);   // encoder.v(1[8:15])
    input D0;   // encoder.v(2[11:13])
    input D1;   // encoder.v(2[14:16])
    input D2;   // encoder.v(2[17:19])
    input D3;   // encoder.v(2[20:22])
    output [3:0]key_in;   // encoder.v(3[18:24])
    
    
    wire n4_c, n3_c, n2_c, key_in_c_c, pwr, gnd;
    
    OBUF key_in_pad_3 (.O(key_in[3]), .I0(key_in_c_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF key_in_pad_1 (.O(key_in[1]), .I0(n3_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF key_in_pad_0 (.O(key_in[0]), .I0(n4_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    IBUF n4_pad (.O(n4_c), .I0(D0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF n3_pad (.O(n3_c), .I0(D1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF n2_pad (.O(n2_c), .I0(D2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF key_in_c_pad (.O(key_in_c_c), .I0(D3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    VCC i35 (.X(pwr));
    OBUF key_in_pad_2 (.O(key_in[2]), .I0(n2_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    GND i34 (.X(gnd));
    
endmodule
//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

//
// Verilog Description of module GND
// module not written out since it is a black-box. 
//

