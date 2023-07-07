// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Wed May 17 10:15:59 2023
//
// Verilog Description of module DECODER
//

module DECODER (clk, reset, key_in_0, key_in_1, key_in_2, key_in_3, 
            key_out_0, key_out_1, key_out_2, key_out_3, led_0, led_1, 
            led_2, led_3, led_4) /* synthesis syn_module_defined=1 */ ;   // decoder.v(1[8:15])
    input clk;   // decoder.v(18[11:14])
    input reset;   // decoder.v(18[15:20])
    input key_in_0;   // decoder.v(19[11:19])
    input key_in_1;   // decoder.v(19[20:28])
    input key_in_2;   // decoder.v(19[29:37])
    input key_in_3;   // decoder.v(19[38:46])
    output key_out_0;   // decoder.v(20[16:25])
    output key_out_1;   // decoder.v(20[26:35])
    output key_out_2;   // decoder.v(20[36:45])
    output key_out_3;   // decoder.v(20[46:55])
    output led_0;   // decoder.v(20[56:61])
    output led_1;   // decoder.v(20[62:67])
    output led_2;   // decoder.v(20[68:73])
    output led_3;   // decoder.v(20[74:79])
    output led_4;   // decoder.v(20[80:85])
    
    wire clk_c /* synthesis is_clock=1, SET_AS_NETWORK=clk_c */ ;   // decoder.v(18[11:14])
    
    wire pwr, reset_c, key_in_0_c, key_in_1_c, key_in_2_c, key_in_3_c, 
        key_out_0_c_3, key_out_1_c_2, key_out_2_c_1, key_out_3_c_0, 
        led_0_c, led_1_c, led_2_c, led_3_c, led_4_c;
    wire [3:0]scanvalue;   // decoder.v(21[15:24])
    wire [7:0]combvalue;   // decoder.v(22[15:24])
    
    wire n31_adj_1, n220, n28, n364, n374, n275, n22, n16, n360, 
        n358, n30, n31;
    wire [4:0]led_0_N_15;
    
    wire n11, n387, n11_adj_2, n12, n4, n216, n34, n338, n6, 
        n5, n347, n1, n6_adj_3, n285, n14, n15, n6_adj_4, n14_adj_5, 
        n15_adj_6, n1_adj_7, n7, n10, n261, n182, n14_adj_8, n14_adj_9, 
        n15_adj_10, n11_adj_11, n13, n15_adj_12, n2, n236, n15_adj_13, 
        gnd, n12_adj_14, n372, n356, n8, n15_adj_15, n11_adj_16, 
        n9, n179, n11_adj_17, n10_adj_18, n152, n15_adj_19, n3, 
        n4_adj_20, n15_adj_21, n15_adj_22, n11_adj_23, n15_adj_24, 
        n170, n328, n15_adj_25, n383, n333, n10_adj_26, n386, 
        n380, n327, n354, n384, n376, n366, n15_adj_27;
    
    OBUF key_out_1_pad (.O(key_out_1), .I0(key_out_1_c_2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFR scanvalue_FSM_i0 (.Q(scanvalue[3]), .D(scanvalue[2]), .CLK(clk_c), 
         .R(reset_c));   // decoder.v(48[17] 54[24])
    DFFC key_out_i0_i4 (.Q(key_out_0_c_3), .D(scanvalue[3]), .CLK(clk_c), 
         .CE(reset_c));   // decoder.v(43[13] 75[16])
    OR2 i1 (.O(n328), .I0(n327), .I1(combvalue[3]));
    INV i194 (.O(n152), .I0(n328));
    IBUF key_in_3_pad (.O(key_in_3_c), .I0(key_in_3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OR3 i3 (.O(led_0_N_15[1]), .I0(n179), .I1(n6_adj_3), .I2(n182));
    OR2 equal_27_i15 (.O(n15_adj_27), .I0(n14_adj_9), .I1(n11_adj_23));
    AND2 i1_adj_1 (.O(n360), .I0(n14_adj_9), .I1(n14_adj_5));
    OR3 i3_adj_2 (.O(led_0_N_15[2]), .I0(n285), .I1(n179), .I2(n5));
    OR3 i2 (.O(n11_adj_23), .I0(n9), .I1(n12), .I2(combvalue[2]));
    AND2 i331 (.O(n366), .I0(n338), .I1(n15_adj_24));
    AND2 i341 (.O(n376), .I0(n372), .I1(n236));
    XOR2 i352 (.O(n386), .I0(combvalue[7]), .I1(n275));
    AND3 i345 (.O(n380), .I0(n358), .I1(n15_adj_21), .I2(n376));
    DFFR combvalue_i0 (.Q(combvalue[0]), .D(key_out_3_c_0), .CLK(clk_c), 
         .R(reset_c));   // decoder.v(43[13] 75[16])
    INV i12 (.O(n12), .I0(combvalue[3]));
    OR3 i2_adj_3 (.O(led_0_N_15[0]), .I0(n1), .I1(n16), .I2(n170));
    OR3 i2_adj_4 (.O(n14_adj_9), .I0(n12_adj_14), .I1(n8), .I2(combvalue[6]));
    OR3 i2_adj_5 (.O(n14), .I0(n4), .I1(combvalue[5]), .I2(n13));
    OR2 i324 (.O(n358), .I0(n220), .I1(n14));
    OR2 i347 (.O(n383), .I0(n4_adj_20), .I1(n11_adj_17));
    OR3 i3_adj_6 (.O(led_0_N_15[3]), .I0(n1), .I1(n6), .I2(n182));
    AND2 i348 (.O(n384), .I0(n376), .I1(n15_adj_13));
    AND2 i1_adj_7 (.O(n34), .I0(n9), .I1(combvalue[2]));
    OR2 equal_25_i15 (.O(n15_adj_25), .I0(n14_adj_5), .I1(n11_adj_23));
    OR2 equal_24_i15 (.O(n15_adj_24), .I0(n14), .I1(n11_adj_23));
    OR2 i1_adj_8 (.O(n354), .I0(n360), .I1(n220));
    OR2 equal_23_i15 (.O(n15_adj_22), .I0(n14_adj_9), .I1(n11_adj_17));
    AND2 i170 (.O(n220), .I0(n11_adj_17), .I1(n11_adj_11));
    OR2 equal_22_i15 (.O(n15_adj_21), .I0(n14_adj_8), .I1(n11_adj_17));
    OR2 i322 (.O(n356), .I0(n14_adj_8), .I1(n11_adj_23));
    OR2 i337 (.O(n372), .I0(n14_adj_8), .I1(n11_adj_11));
    OR3 i2_adj_9 (.O(n11), .I0(n1_adj_7), .I1(combvalue[1]), .I2(n10));
    AND2 i2_adj_10 (.O(n261), .I0(n4_adj_20), .I1(n14));
    VCC i351 (.X(pwr));
    OR2 equal_20_i15 (.O(n15_adj_19), .I0(n14), .I1(n11_adj_17));
    OR2 equal_20_i13 (.O(n13), .I0(combvalue[7]), .I1(combvalue[6]));
    OR2 equal_20_i9 (.O(n9), .I0(combvalue[1]), .I1(combvalue[0]));
    AND2 i1_adj_11 (.O(n31_adj_1), .I0(n327), .I1(combvalue[3]));
    OR2 i214 (.O(n236), .I0(n261), .I1(n11));
    OR2 equal_19_i15 (.O(n15_adj_15), .I0(n14_adj_9), .I1(n11_adj_11));
    OR2 equal_19_i10 (.O(n10), .I0(combvalue[3]), .I1(combvalue[2]));
    AND2 i1_adj_12 (.O(n11_adj_2), .I0(combvalue[4]), .I1(combvalue[5]));
    OR3 i2_adj_13 (.O(n11_adj_17), .I0(n9), .I1(combvalue[3]), .I2(n3));
    OR6 i6 (.O(n31), .I0(n11_adj_2), .I1(n28), .I2(n10_adj_26), .I3(n34), 
        .I4(n387), .I5(n152));
    OR2 equal_17_i15 (.O(n15_adj_13), .I0(n14_adj_5), .I1(n11_adj_11));
    OR2 equal_16_i15 (.O(n15_adj_12), .I0(n14), .I1(n11_adj_11));
    AND2 i1_adj_14 (.O(n28), .I0(n12_adj_14), .I1(combvalue[6]));
    INV equal_27_i16 (.O(n30), .I0(n15_adj_27));
    GND i350 (.X(gnd));
    OR2 i3_adj_15 (.O(n10_adj_26), .I0(n22), .I1(n31_adj_1));
    OR2 equal_15_i15 (.O(n15_adj_10), .I0(n14_adj_9), .I1(n11));
    OR4 i6_adj_16 (.O(led_0_N_15[4]), .I0(n347), .I1(n10_adj_18), .I2(n31), 
        .I3(n11_adj_16));
    OR2 i2_adj_17 (.O(n275), .I0(n12_adj_14), .I1(combvalue[6]));
    OR2 reduce_or_61_i1 (.O(n1), .I0(n30), .I1(n31));
    OR2 equal_13_i15 (.O(n15_adj_6), .I0(n14_adj_5), .I1(n11));
    INV i86 (.O(n8), .I0(combvalue[7]));
    OR2 i1_adj_18 (.O(n179), .I0(n333), .I1(n1));
    DFFC key_out_i0_i3 (.Q(key_out_1_c_2), .D(scanvalue[2]), .CLK(clk_c), 
         .CE(reset_c));   // decoder.v(43[13] 75[16])
    INV i85 (.O(n3), .I0(combvalue[2]));
    OR2 equal_12_i15 (.O(n15), .I0(n14), .I1(n11));
    OR3 i2_adj_19 (.O(n14_adj_8), .I0(n12_adj_14), .I1(combvalue[7]), 
        .I2(n7));
    DFFC key_out_i0_i2 (.Q(key_out_2_c_1), .D(scanvalue[1]), .CLK(clk_c), 
         .CE(reset_c));   // decoder.v(43[13] 75[16])
    DFFS scanvalue_FSM_i3 (.Q(scanvalue[0]), .D(scanvalue[3]), .CLK(clk_c), 
         .S(reset_c));   // decoder.v(48[17] 54[24])
    INV i353 (.O(n387), .I0(n386));
    INV i84 (.O(n7), .I0(combvalue[6]));
    INV i82 (.O(n6_adj_4), .I0(combvalue[5]));
    DFFR scanvalue_FSM_i2 (.Q(scanvalue[1]), .D(scanvalue[0]), .CLK(clk_c), 
         .R(reset_c));   // decoder.v(48[17] 54[24])
    INV i80 (.O(n4), .I0(combvalue[4]));
    OR3 i2_adj_20 (.O(n14_adj_5), .I0(combvalue[4]), .I1(n6_adj_4), .I2(n13));
    INV i332 (.O(n10_adj_18), .I0(n366));
    DFFR scanvalue_FSM_i1 (.Q(scanvalue[2]), .D(scanvalue[1]), .CLK(clk_c), 
         .R(reset_c));   // decoder.v(48[17] 54[24])
    DFFR combvalue_i7 (.Q(combvalue[7]), .D(key_in_0_c), .CLK(clk_c), 
         .R(reset_c));   // decoder.v(43[13] 75[16])
    OR3 i2_adj_21 (.O(n327), .I0(combvalue[1]), .I1(combvalue[2]), .I2(combvalue[0]));
    OR3 i2_adj_22 (.O(n11_adj_11), .I0(combvalue[0]), .I1(n2), .I2(n10));
    DFFR combvalue_i6 (.Q(combvalue[6]), .D(key_in_1_c), .CLK(clk_c), 
         .R(reset_c));   // decoder.v(43[13] 75[16])
    DFFR combvalue_i5 (.Q(combvalue[5]), .D(key_in_2_c), .CLK(clk_c), 
         .R(reset_c));   // decoder.v(43[13] 75[16])
    DFFR combvalue_i4 (.Q(combvalue[4]), .D(key_in_3_c), .CLK(clk_c), 
         .R(reset_c));   // decoder.v(43[13] 75[16])
    DFFR combvalue_i3 (.Q(combvalue[3]), .D(key_out_0_c_3), .CLK(clk_c), 
         .R(reset_c));   // decoder.v(43[13] 75[16])
    DFFR combvalue_i2 (.Q(combvalue[2]), .D(key_out_1_c_2), .CLK(clk_c), 
         .R(reset_c));   // decoder.v(43[13] 75[16])
    DFFR combvalue_i1 (.Q(combvalue[1]), .D(key_out_2_c_1), .CLK(clk_c), 
         .R(reset_c));   // decoder.v(43[13] 75[16])
    INV i77 (.O(n2), .I0(combvalue[1]));
    OR2 i1_adj_23 (.O(n12_adj_14), .I0(combvalue[4]), .I1(combvalue[5]));
    DFFS led_i5 (.Q(led_0_c), .D(led_0_N_15[4]), .CLK(clk_c), .S(reset_c));   // decoder.v(43[13] 75[16])
    DFFS led_i4 (.Q(led_1_c), .D(led_0_N_15[3]), .CLK(clk_c), .S(reset_c));   // decoder.v(43[13] 75[16])
    INV i346 (.O(n11_adj_16), .I0(n380));
    AND3 i339 (.O(n374), .I0(n15_adj_22), .I1(n15), .I2(n15_adj_24));
    DFFS led_i3 (.Q(led_2_c), .D(led_0_N_15[2]), .CLK(clk_c), .S(reset_c));   // decoder.v(43[13] 75[16])
    AND2 i1_adj_24 (.O(n22), .I0(combvalue[0]), .I1(combvalue[1]));
    DFFS led_i2 (.Q(led_3_c), .D(led_0_N_15[1]), .CLK(clk_c), .S(reset_c));   // decoder.v(43[13] 75[16])
    DFFS led_i1 (.Q(led_4_c), .D(led_0_N_15[0]), .CLK(clk_c), .S(reset_c));   // decoder.v(43[13] 75[16])
    OBUF key_out_0_pad (.O(key_out_0), .I0(key_out_0_c_3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    INV i252 (.O(n285), .I0(n236));
    AND2 i184 (.O(n216), .I0(n15_adj_10), .I1(n15_adj_12));
    AND3 i1_adj_25 (.O(n338), .I0(n354), .I1(n15_adj_25), .I2(n15_adj_10));
    IBUF key_in_2_pad (.O(key_in_2_c), .I0(key_in_2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF key_in_1_pad (.O(key_in_1_c), .I0(key_in_1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    INV i344 (.O(n5), .I0(n383));
    IBUF key_in_0_pad (.O(key_in_0_c), .I0(key_in_0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF reset_pad (.O(reset_c), .I0(reset));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    INV i185 (.O(n182), .I0(n216));
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OBUF led_4_pad (.O(led_4), .I0(led_4_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF led_3_pad (.O(led_3), .I0(led_3_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i1_adj_26 (.O(n4_adj_20), .I0(n14_adj_8), .I1(n14_adj_5));
    AND2 i329 (.O(n364), .I0(n15_adj_15), .I1(n15_adj_19));
    OBUF led_2_pad (.O(led_2), .I0(led_2_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    INV equal_13_i16 (.O(n16), .I0(n15_adj_6));
    INV i330 (.O(n333), .I0(n364));
    INV i67 (.O(n1_adj_7), .I0(combvalue[0]));
    OBUF led_1_pad (.O(led_1), .I0(led_1_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    INV i340 (.O(n6_adj_3), .I0(n374));
    OBUF led_0_pad (.O(led_0), .I0(led_0_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF key_out_3_pad (.O(key_out_3), .I0(key_out_3_c_0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF key_out_2_pad (.O(key_out_2), .I0(key_out_2_c_1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFC key_out_i0_i1 (.Q(key_out_3_c_0), .D(scanvalue[0]), .CLK(clk_c), 
         .CE(reset_c));   // decoder.v(43[13] 75[16])
    INV i349 (.O(n6), .I0(n384));
    INV i205 (.O(n170), .I0(n338));
    INV i323 (.O(n347), .I0(n356));
    
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

