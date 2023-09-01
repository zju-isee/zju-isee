// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Mon May 01 09:08:13 2023
//
// Verilog Description of module DECODE_MODULE
//

module DECODE_MODULE (clk, reset, key_in, key_out, led) /* synthesis syn_module_defined=1 */ ;   // decode_module.v(1[8:21])
    input clk;   // decode_module.v(2[11:14])
    input reset;   // decode_module.v(2[15:20])
    input [3:0]key_in;   // decode_module.v(3[17:23])
    output [3:0]key_out;   // decode_module.v(4[18:25])
    output [4:0]led;   // decode_module.v(5[18:21])
    
    wire clk_c /* synthesis is_clock=1, SET_AS_NETWORK=clk_c */ ;   // decode_module.v(2[11:14])
    
    wire pwr, reset_c, key_in_c_3, key_in_c_2, key_in_c_1, key_in_c_0, 
        key_out_c_3, key_out_c_2, key_out_c_1, key_out_c_0, led_c_4, 
        led_c_3, led_c_2, led_c_1, led_c_0;
    wire [3:0]scanvalue;   // decode_module.v(9[15:24])
    wire [7:0]combvalue;   // decode_module.v(10[15:24])
    
    wire n31, n219, n28, n363, n373, n274, n22, led_4__N_21, 
        n359, n357, led_4__N_35, led_4__N_36;
    wire [4:0]led_4__N_5;
    
    wire n11, n386, n11_adj_1, n12, n4, n215, n34, n337, n6, 
        n5, n346, n1, n6_adj_2, n284, n14, n15, n6_adj_3, n14_adj_4, 
        n15_adj_5, n1_adj_6, n7, n10, n260, n181, n14_adj_7, n14_adj_8, 
        n15_adj_9, n11_adj_10, n13, n15_adj_11, n2, n235, n15_adj_12, 
        gnd, n12_adj_13, n371, n355, n8, n15_adj_14, n11_adj_15, 
        n9, n178, n11_adj_16, n10_adj_17, n151, n15_adj_18, n3, 
        n4_adj_19, n15_adj_20, n15_adj_21, n11_adj_22, n15_adj_23, 
        n169, n327, n15_adj_24, n382, n332, n10_adj_25, n385, 
        n379, n326, n353, n383, n375, n365, n15_adj_26;
    
    OBUF key_out_pad_2 (.O(key_out[2]), .I0(key_out_c_2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFR scanvalue_FSM_i0 (.Q(scanvalue[3]), .D(scanvalue[2]), .CLK(clk_c), 
         .R(reset_c));   // decode_module.v(27[17] 33[24])
    DFFC key_out_i0_i4 (.Q(key_out_c_3), .D(scanvalue[3]), .CLK(clk_c), 
         .CE(reset_c));   // decode_module.v(22[13] 54[16])
    OR2 i1 (.O(n327), .I0(n326), .I1(combvalue[3]));
    INV i209 (.O(n151), .I0(n327));
    IBUF key_in_pad_0 (.O(key_in_c_0), .I0(key_in[0]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OR3 i3 (.O(led_4__N_5[1]), .I0(n178), .I1(n6_adj_2), .I2(n181));
    OR2 combvalue_7__I_0_i15 (.O(n15_adj_26), .I0(n14_adj_8), .I1(n11_adj_22));
    AND2 i1_adj_1 (.O(n359), .I0(n14_adj_8), .I1(n14_adj_4));
    OR3 i3_adj_2 (.O(led_4__N_5[2]), .I0(n284), .I1(n178), .I2(n5));
    OR3 i2 (.O(n11_adj_22), .I0(n9), .I1(n12), .I2(combvalue[2]));
    AND2 i346 (.O(n365), .I0(n337), .I1(n15_adj_23));
    AND2 i356 (.O(n375), .I0(n371), .I1(n235));
    XOR2 i367 (.O(n385), .I0(combvalue[7]), .I1(n274));
    AND3 i360 (.O(n379), .I0(n357), .I1(n15_adj_20), .I2(n375));
    DFFR combvalue_i0 (.Q(combvalue[0]), .D(key_out_c_0), .CLK(clk_c), 
         .R(reset_c));   // decode_module.v(22[13] 54[16])
    INV i12 (.O(n12), .I0(combvalue[3]));
    OR3 i2_adj_3 (.O(led_4__N_5[0]), .I0(n1), .I1(led_4__N_21), .I2(n169));
    OR3 i2_adj_4 (.O(n14_adj_8), .I0(n12_adj_13), .I1(n8), .I2(combvalue[6]));
    OR3 i2_adj_5 (.O(n14), .I0(n4), .I1(combvalue[5]), .I2(n13));
    OR2 i339 (.O(n357), .I0(n219), .I1(n14));
    OR2 i362 (.O(n382), .I0(n4_adj_19), .I1(n11_adj_16));
    OR3 i3_adj_6 (.O(led_4__N_5[3]), .I0(n1), .I1(n6), .I2(n181));
    AND2 i363 (.O(n383), .I0(n375), .I1(n15_adj_12));
    AND2 i1_adj_7 (.O(n34), .I0(n9), .I1(combvalue[2]));
    OR2 combvalue_7__I_0_57_i15 (.O(n15_adj_24), .I0(n14_adj_4), .I1(n11_adj_22));
    OR2 combvalue_7__I_0_56_i15 (.O(n15_adj_23), .I0(n14), .I1(n11_adj_22));
    OR2 i1_adj_8 (.O(n353), .I0(n359), .I1(n219));
    OR2 combvalue_7__I_0_55_i15 (.O(n15_adj_21), .I0(n14_adj_8), .I1(n11_adj_16));
    AND2 i185 (.O(n219), .I0(n11_adj_16), .I1(n11_adj_10));
    OR2 combvalue_7__I_0_54_i15 (.O(n15_adj_20), .I0(n14_adj_7), .I1(n11_adj_16));
    OR2 i337 (.O(n355), .I0(n14_adj_7), .I1(n11_adj_22));
    OR2 i352 (.O(n371), .I0(n14_adj_7), .I1(n11_adj_10));
    OR3 i2_adj_9 (.O(n11), .I0(n1_adj_6), .I1(combvalue[1]), .I2(n10));
    AND2 i2_adj_10 (.O(n260), .I0(n4_adj_19), .I1(n14));
    VCC i366 (.X(pwr));
    OR2 combvalue_7__I_0_52_i15 (.O(n15_adj_18), .I0(n14), .I1(n11_adj_16));
    OR2 combvalue_7__I_0_52_i13 (.O(n13), .I0(combvalue[7]), .I1(combvalue[6]));
    OR2 combvalue_7__I_0_52_i9 (.O(n9), .I0(combvalue[1]), .I1(combvalue[0]));
    AND2 i1_adj_11 (.O(n31), .I0(n326), .I1(combvalue[3]));
    OR2 i229 (.O(n235), .I0(n260), .I1(n11));
    OR2 combvalue_7__I_0_51_i15 (.O(n15_adj_14), .I0(n14_adj_8), .I1(n11_adj_10));
    OR2 combvalue_7__I_0_51_i10 (.O(n10), .I0(combvalue[3]), .I1(combvalue[2]));
    AND2 i1_adj_12 (.O(n11_adj_1), .I0(combvalue[4]), .I1(combvalue[5]));
    OR3 i2_adj_13 (.O(n11_adj_16), .I0(n9), .I1(combvalue[3]), .I2(n3));
    OR6 i6 (.O(led_4__N_36), .I0(n11_adj_1), .I1(n28), .I2(n10_adj_25), 
        .I3(n34), .I4(n386), .I5(n151));
    OR2 combvalue_7__I_0_49_i15 (.O(n15_adj_12), .I0(n14_adj_4), .I1(n11_adj_10));
    OR2 combvalue_7__I_0_48_i15 (.O(n15_adj_11), .I0(n14), .I1(n11_adj_10));
    AND2 i1_adj_14 (.O(n28), .I0(n12_adj_13), .I1(combvalue[6]));
    INV combvalue_7__I_0_i16 (.O(led_4__N_35), .I0(n15_adj_26));
    GND i365 (.X(gnd));
    OR2 i3_adj_15 (.O(n10_adj_25), .I0(n22), .I1(n31));
    OR2 combvalue_7__I_0_47_i15 (.O(n15_adj_9), .I0(n14_adj_8), .I1(n11));
    OR4 i6_adj_16 (.O(led_4__N_5[4]), .I0(n346), .I1(n10_adj_17), .I2(led_4__N_36), 
        .I3(n11_adj_15));
    OR2 i2_adj_17 (.O(n274), .I0(n12_adj_13), .I1(combvalue[6]));
    OR2 reduce_or_76_i1 (.O(n1), .I0(led_4__N_35), .I1(led_4__N_36));
    OR2 combvalue_7__I_0_45_i15 (.O(n15_adj_5), .I0(n14_adj_4), .I1(n11));
    INV i101 (.O(n8), .I0(combvalue[7]));
    OR2 i1_adj_18 (.O(n178), .I0(n332), .I1(n1));
    DFFC key_out_i0_i3 (.Q(key_out_c_2), .D(scanvalue[2]), .CLK(clk_c), 
         .CE(reset_c));   // decode_module.v(22[13] 54[16])
    INV i100 (.O(n3), .I0(combvalue[2]));
    OR2 combvalue_7__I_0_44_i15 (.O(n15), .I0(n14), .I1(n11));
    OR3 i2_adj_19 (.O(n14_adj_7), .I0(n12_adj_13), .I1(combvalue[7]), 
        .I2(n7));
    DFFC key_out_i0_i2 (.Q(key_out_c_1), .D(scanvalue[1]), .CLK(clk_c), 
         .CE(reset_c));   // decode_module.v(22[13] 54[16])
    DFFS scanvalue_FSM_i3 (.Q(scanvalue[0]), .D(scanvalue[3]), .CLK(clk_c), 
         .S(reset_c));   // decode_module.v(27[17] 33[24])
    INV i368 (.O(n386), .I0(n385));
    INV i99 (.O(n7), .I0(combvalue[6]));
    INV i97 (.O(n6_adj_3), .I0(combvalue[5]));
    DFFR scanvalue_FSM_i2 (.Q(scanvalue[1]), .D(scanvalue[0]), .CLK(clk_c), 
         .R(reset_c));   // decode_module.v(27[17] 33[24])
    INV i95 (.O(n4), .I0(combvalue[4]));
    OR3 i2_adj_20 (.O(n14_adj_4), .I0(combvalue[4]), .I1(n6_adj_3), .I2(n13));
    INV i347 (.O(n10_adj_17), .I0(n365));
    DFFR scanvalue_FSM_i1 (.Q(scanvalue[2]), .D(scanvalue[1]), .CLK(clk_c), 
         .R(reset_c));   // decode_module.v(27[17] 33[24])
    DFFR combvalue_i7 (.Q(combvalue[7]), .D(key_in_c_3), .CLK(clk_c), 
         .R(reset_c));   // decode_module.v(22[13] 54[16])
    OR3 i2_adj_21 (.O(n326), .I0(combvalue[1]), .I1(combvalue[2]), .I2(combvalue[0]));
    OR3 i2_adj_22 (.O(n11_adj_10), .I0(combvalue[0]), .I1(n2), .I2(n10));
    DFFR combvalue_i6 (.Q(combvalue[6]), .D(key_in_c_2), .CLK(clk_c), 
         .R(reset_c));   // decode_module.v(22[13] 54[16])
    DFFR combvalue_i5 (.Q(combvalue[5]), .D(key_in_c_1), .CLK(clk_c), 
         .R(reset_c));   // decode_module.v(22[13] 54[16])
    DFFR combvalue_i4 (.Q(combvalue[4]), .D(key_in_c_0), .CLK(clk_c), 
         .R(reset_c));   // decode_module.v(22[13] 54[16])
    DFFR combvalue_i3 (.Q(combvalue[3]), .D(key_out_c_3), .CLK(clk_c), 
         .R(reset_c));   // decode_module.v(22[13] 54[16])
    DFFR combvalue_i2 (.Q(combvalue[2]), .D(key_out_c_2), .CLK(clk_c), 
         .R(reset_c));   // decode_module.v(22[13] 54[16])
    DFFR combvalue_i1 (.Q(combvalue[1]), .D(key_out_c_1), .CLK(clk_c), 
         .R(reset_c));   // decode_module.v(22[13] 54[16])
    INV i92 (.O(n2), .I0(combvalue[1]));
    OR2 i1_adj_23 (.O(n12_adj_13), .I0(combvalue[4]), .I1(combvalue[5]));
    DFFS led_i5 (.Q(led_c_4), .D(led_4__N_5[4]), .CLK(clk_c), .S(reset_c));   // decode_module.v(22[13] 54[16])
    DFFS led_i4 (.Q(led_c_3), .D(led_4__N_5[3]), .CLK(clk_c), .S(reset_c));   // decode_module.v(22[13] 54[16])
    INV i361 (.O(n11_adj_15), .I0(n379));
    AND3 i354 (.O(n373), .I0(n15_adj_21), .I1(n15), .I2(n15_adj_23));
    DFFS led_i3 (.Q(led_c_2), .D(led_4__N_5[2]), .CLK(clk_c), .S(reset_c));   // decode_module.v(22[13] 54[16])
    AND2 i1_adj_24 (.O(n22), .I0(combvalue[0]), .I1(combvalue[1]));
    DFFS led_i2 (.Q(led_c_1), .D(led_4__N_5[1]), .CLK(clk_c), .S(reset_c));   // decode_module.v(22[13] 54[16])
    DFFS led_i1 (.Q(led_c_0), .D(led_4__N_5[0]), .CLK(clk_c), .S(reset_c));   // decode_module.v(22[13] 54[16])
    OBUF key_out_pad_3 (.O(key_out[3]), .I0(key_out_c_3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    INV i267 (.O(n284), .I0(n235));
    AND2 i199 (.O(n215), .I0(n15_adj_9), .I1(n15_adj_11));
    AND3 i1_adj_25 (.O(n337), .I0(n353), .I1(n15_adj_24), .I2(n15_adj_9));
    IBUF key_in_pad_1 (.O(key_in_c_1), .I0(key_in[1]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF key_in_pad_2 (.O(key_in_c_2), .I0(key_in[2]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    INV i359 (.O(n5), .I0(n382));
    IBUF key_in_pad_3 (.O(key_in_c_3), .I0(key_in[3]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF reset_pad (.O(reset_c), .I0(reset));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    INV i200 (.O(n181), .I0(n215));
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OBUF led_pad_0 (.O(led[0]), .I0(led_c_0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF led_pad_1 (.O(led[1]), .I0(led_c_1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i1_adj_26 (.O(n4_adj_19), .I0(n14_adj_7), .I1(n14_adj_4));
    AND2 i344 (.O(n363), .I0(n15_adj_14), .I1(n15_adj_18));
    OBUF led_pad_2 (.O(led[2]), .I0(led_c_2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    INV combvalue_7__I_0_45_i16 (.O(led_4__N_21), .I0(n15_adj_5));
    INV i345 (.O(n332), .I0(n363));
    INV i82 (.O(n1_adj_6), .I0(combvalue[0]));
    OBUF led_pad_3 (.O(led[3]), .I0(led_c_3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    INV i355 (.O(n6_adj_2), .I0(n373));
    OBUF led_pad_4 (.O(led[4]), .I0(led_c_4));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF key_out_pad_0 (.O(key_out[0]), .I0(key_out_c_0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF key_out_pad_1 (.O(key_out[1]), .I0(key_out_c_1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFC key_out_i0_i1 (.Q(key_out_c_0), .D(scanvalue[0]), .CLK(clk_c), 
         .CE(reset_c));   // decode_module.v(22[13] 54[16])
    INV i364 (.O(n6), .I0(n383));
    INV i220 (.O(n169), .I0(n337));
    INV i338 (.O(n346), .I0(n355));
    
endmodule
//
// Verilog Description of module OR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module INV
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR3
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module XOR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND3
// module not written out since it is a black-box. 
//

//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR6
// module not written out since it is a black-box. 
//

//
// Verilog Description of module GND
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR4
// module not written out since it is a black-box. 
//

