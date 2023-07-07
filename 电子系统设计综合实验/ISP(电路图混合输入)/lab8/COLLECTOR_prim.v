// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Thu May 18 21:33:56 2023
//
// Verilog Description of module COLLECTOR
//

module COLLECTOR (clk, q1, q0) /* synthesis syn_module_defined=1 */ ;   // collector.v(1[8:17])
    input clk;   // collector.v(3[8:11])
    output q1;   // collector.v(4[9:11])
    output q0;   // collector.v(4[12:14])
    
    wire clk_c /* synthesis is_clock=1, SET_AS_NETWORK=clk_c */ ;   // collector.v(3[8:11])
    
    wire pwr, gnd, q1_c, q0_c;
    wire [1:0]counter;   // collector.v(7[12:19])
    
    wire n1, n72;
    
    OBUF q0_pad (.O(q0), .I0(q0_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    VCC i75 (.X(pwr));
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    DFF q0_19 (.Q(q0_c), .D(counter[0]), .CLK(clk_c));   // collector.v(9[9] 37[5])
    DFF q1_18 (.Q(q1_c), .D(counter[1]), .CLK(clk_c));   // collector.v(9[9] 37[5])
    DFF counter__i1 (.Q(counter[1]), .D(n72), .CLK(clk_c));   // collector.v(9[9] 37[5])
    OBUF q1_pad (.O(q1), .I0(q1_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    GND i74 (.X(gnd));
    DFF counter__i0 (.Q(counter[0]), .D(n1), .CLK(clk_c));   // collector.v(9[9] 37[5])
    XOR2 i76 (.O(n72), .I0(counter[0]), .I1(counter[1]));
    INV i35 (.O(n1), .I0(counter[0]));
    
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

