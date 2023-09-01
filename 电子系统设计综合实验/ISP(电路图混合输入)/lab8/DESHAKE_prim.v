// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Mon May 01 10:29:29 2023
//
// Verilog Description of module DESHAKE
//

module DESHAKE (keyclk, RESET, din, dout) /* synthesis syn_module_defined=1 */ ;   // deshake.v(1[8:15])
    input keyclk;   // deshake.v(3[11:17])
    input RESET;   // deshake.v(3[18:23])
    input din;   // deshake.v(3[24:27])
    output dout;   // deshake.v(4[12:16])
    
    wire keyclk_c /* synthesis is_clock=1, SET_AS_NETWORK=keyclk_c */ ;   // deshake.v(3[11:17])
    
    wire pwr, gnd, RESET_c, din_c;
    wire [1:0]pre_s;   // deshake.v(6[15:20])
    wire [1:0]next_s;   // deshake.v(7[15:21])
    
    wire dout_c;
    wire [1:0]pre_s_1__N_1;
    wire [1:0]next_s_1__N_9;
    
    wire n98;
    wire [1:0]next_s_1__N_3;
    
    wire n125, n96, n121, n4, n72, n92, n79, n107;
    
    DFF pre_s_i0 (.Q(pre_s[0]), .D(pre_s_1__N_1[0]), .CLK(keyclk_c));   // deshake.v(10[12] 14[8])
    XOR2 i15 (.O(n79), .I0(pre_s[1]), .I1(pre_s[0]));
    AND3 i2 (.O(next_s_1__N_3[1]), .I0(pre_s[0]), .I1(next_s_1__N_9[1]), 
         .I2(n92));
    IBUF keyclk_pad (.O(keyclk_c), .I0(keyclk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    DFFC dout_22 (.Q(dout_c), .D(n72), .CLK(keyclk_c), .CE(n98));   // deshake.v(16[12] 30[8])
    OR2 i83 (.O(pre_s_1__N_1[0]), .I0(n107), .I1(next_s[0]));
    IBUF din_pad (.O(din_c), .I0(din));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    AND2 i1 (.O(n98), .I0(n79), .I1(n121));
    DFFC next_s_i1 (.Q(next_s[1]), .D(next_s_1__N_3[1]), .CLK(keyclk_c), 
         .CE(n4));   // deshake.v(16[12] 30[8])
    IBUF RESET_pad (.O(RESET_c), .I0(RESET));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OBUF dout_pad (.O(dout), .I0(dout_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFF pre_s_i1 (.Q(pre_s[1]), .D(pre_s_1__N_1[1]), .CLK(keyclk_c));   // deshake.v(10[12] 14[8])
    OR2 i1_adj_1 (.O(next_s_1__N_3[0]), .I0(n121), .I1(pre_s[1]));
    INV i82 (.O(n107), .I0(RESET_c));
    DFFC next_s_i0 (.Q(next_s[0]), .D(next_s_1__N_3[0]), .CLK(keyclk_c), 
         .CE(n4));   // deshake.v(16[12] 30[8])
    OR2 i107 (.O(n4), .I0(n72), .I1(n125));
    INV i67 (.O(n92), .I0(pre_s[1]));
    INV i106 (.O(n125), .I0(pre_s[1]));
    OR2 i85 (.O(n72), .I0(pre_s[0]), .I1(din_c));
    INV i71 (.O(n96), .I0(pre_s[0]));
    OR2 i1_adj_2 (.O(n121), .I0(n96), .I1(din_c));
    INV i1_adj_3 (.O(next_s_1__N_9[1]), .I0(din_c));
    AND2 i87 (.O(pre_s_1__N_1[1]), .I0(RESET_c), .I1(next_s[1]));
    GND i104 (.X(gnd));
    VCC i105 (.X(pwr));
    
endmodule
//
// Verilog Description of module XOR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND3
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module INV
// module not written out since it is a black-box. 
//

//
// Verilog Description of module GND
// module not written out since it is a black-box. 
//

//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

