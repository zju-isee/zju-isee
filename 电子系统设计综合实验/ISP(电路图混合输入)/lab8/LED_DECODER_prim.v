// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Thu May 18 21:40:20 2023
//
// Verilog Description of module LED_DECODER
//

module LED_DECODER (EN, A0, A1, A2, A3, Z0, Z1, Z2, Z3, Z4, 
            Z5, Z6) /* synthesis syn_module_defined=1 */ ;   // led_decoder.v(1[8:19])
    input EN;   // led_decoder.v(2[11:13])
    input A0;   // led_decoder.v(2[14:16])
    input A1;   // led_decoder.v(2[17:19])
    input A2;   // led_decoder.v(2[20:22])
    input A3;   // led_decoder.v(2[23:25])
    output Z0;   // led_decoder.v(3[12:14])
    output Z1;   // led_decoder.v(3[15:17])
    output Z2;   // led_decoder.v(3[18:20])
    output Z3;   // led_decoder.v(3[21:23])
    output Z4;   // led_decoder.v(3[24:26])
    output Z5;   // led_decoder.v(3[27:29])
    output Z6;   // led_decoder.v(3[30:32])
    
    
    wire EN_c, A0_c, A1_c, A2_c, A3_c, pwr, gnd;
    
    BUFTH Z1_pad (.O(Z1), .I0(gnd), .OE(gnd));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(76[8:13])
    BUFTH Z0_pad (.O(Z0), .I0(gnd), .OE(gnd));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(76[8:13])
    BUFTH Z2_pad (.O(Z2), .I0(gnd), .OE(gnd));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(76[8:13])
    BUFTH Z3_pad (.O(Z3), .I0(gnd), .OE(gnd));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(76[8:13])
    BUFTH Z4_pad (.O(Z4), .I0(gnd), .OE(gnd));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(76[8:13])
    BUFTH Z5_pad (.O(Z5), .I0(gnd), .OE(gnd));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(76[8:13])
    BUFTH Z6_pad (.O(Z6), .I0(gnd), .OE(gnd));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(76[8:13])
    VCC i44 (.X(pwr));
    IBUF EN_pad (.O(EN_c), .I0(EN));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    GND i6 (.X(gnd));
    IBUF A0_pad (.O(A0_c), .I0(A0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF A1_pad (.O(A1_c), .I0(A1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF A2_pad (.O(A2_c), .I0(A2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF A3_pad (.O(A3_c), .I0(A3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    
endmodule
//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

//
// Verilog Description of module GND
// module not written out since it is a black-box. 
//

