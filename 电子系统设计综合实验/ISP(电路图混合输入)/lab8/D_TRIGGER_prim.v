// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Thu May 18 21:33:58 2023
//
// Verilog Description of module D_TRIGGER
//

module D_TRIGGER (d, clk, q) /* synthesis syn_module_defined=1 */ ;   // d_trigger.v(1[8:17])
    input d;   // d_trigger.v(3[8:9])
    input clk;   // d_trigger.v(2[8:11])
    output q;   // d_trigger.v(4[13:14])
    
    wire clk_c /* synthesis is_clock=1, SET_AS_NETWORK=clk_c */ ;   // d_trigger.v(2[8:11])
    
    wire pwr, d_c, q_c, gnd;
    
    VCC i24 (.X(pwr));
    OBUF q_pad (.O(q), .I0(q_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    DFF q_5 (.Q(q_c), .D(d_c), .CLK(clk_c));   // d_trigger.v(7[9] 10[6])
    IBUF d_pad (.O(d_c), .I0(d));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    GND i23 (.X(gnd));
    
endmodule
//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

//
// Verilog Description of module GND
// module not written out since it is a black-box. 
//

