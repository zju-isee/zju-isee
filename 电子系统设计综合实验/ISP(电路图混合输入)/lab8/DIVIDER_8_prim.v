// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Mon May 01 10:29:28 2023
//
// Verilog Description of module DIVIDER_8
//

module DIVIDER_8 (clk, reset, time10ms) /* synthesis syn_module_defined=1 */ ;   // divider_8.v(1[8:17])
    input clk;   // divider_8.v(2[11:14])
    input reset;   // divider_8.v(2[15:20])
    output time10ms;   // divider_8.v(3[12:20])
    
    wire clk_c /* synthesis SET_AS_NETWORK=clk_c, is_clock=1 */ ;   // divider_8.v(2[11:14])
    
    wire pwr, gnd, reset_c, time10ms_c;
    wire [3:0]timecnt;   // divider_8.v(6[15:22])
    
    wire n10, time10ms_N_13;
    
    VCC i45 (.X(pwr));
    GND i44 (.X(gnd));
    IBUF reset_pad (.O(reset_c), .I0(reset));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    DFFC time10ms_15 (.Q(time10ms_c), .D(time10ms_N_13), .CLK(clk_c), 
         .CE(reset_c));   // divider_8.v(12[14] 17[33])
    XOR2 time10ms_I_0 (.O(time10ms_N_13), .I0(timecnt[0]), .I1(time10ms_c));
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OBUF time10ms_pad (.O(time10ms), .I0(time10ms_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    INV i41 (.O(n10), .I0(timecnt[0]));
    DFFR timecnt_22_23__i1 (.Q(timecnt[0]), .D(n10), .CLK(clk_c), .R(reset_c));   // divider_8.v(17[23:32])
    
endmodule
//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

//
// Verilog Description of module GND
// module not written out since it is a black-box. 
//

//
// Verilog Description of module XOR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module INV
// module not written out since it is a black-box. 
//

