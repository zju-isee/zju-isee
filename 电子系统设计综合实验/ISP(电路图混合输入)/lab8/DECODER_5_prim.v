// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Mon May 01 09:08:09 2023
//
// Verilog Description of module DECODER_5
//

module DECODER_5 (in, Q0, Q1, Q2, Q3, Q4);   // decoder_5.v(1[8:17])
    input [4:0]in;   // decoder_5.v(2[17:19])
    output Q0;   // decoder_5.v(3[12:14])
    output Q1;   // decoder_5.v(3[15:17])
    output Q2;   // decoder_5.v(3[18:20])
    output Q3;   // decoder_5.v(3[21:23])
    output Q4;   // decoder_5.v(3[24:26])
    
    
    wire Q4_c_4_c, Q3_c_3_c, Q2_c_2_c, Q1_c_1_c, Q0_c_0_c, pwr, 
        gnd;
    
    OBUF Q0_pad (.O(Q0), .I0(Q0_c_0_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF Q2_pad (.O(Q2), .I0(Q2_c_2_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF Q3_pad (.O(Q3), .I0(Q3_c_3_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF Q4_pad (.O(Q4), .I0(Q4_c_4_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    IBUF Q4_c_4_pad (.O(Q4_c_4_c), .I0(in[4]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF Q3_c_3_pad (.O(Q3_c_3_c), .I0(in[3]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF Q2_c_2_pad (.O(Q2_c_2_c), .I0(in[2]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF Q1_c_1_pad (.O(Q1_c_1_c), .I0(in[1]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF Q0_c_0_pad (.O(Q0_c_0_c), .I0(in[0]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    VCC i37 (.X(pwr));
    OBUF Q1_pad (.O(Q1), .I0(Q1_c_1_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    GND i36 (.X(gnd));
    
endmodule
//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

//
// Verilog Description of module GND
// module not written out since it is a black-box. 
//

