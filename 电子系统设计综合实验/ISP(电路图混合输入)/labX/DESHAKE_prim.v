// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Fri Jun 09 10:00:00 2023
//
// Verilog Description of module DESHAKE
//

module DESHAKE (clk, RESET, din, dout) /* synthesis syn_module_defined=1 */ ;   // deshake.v(1[8:15])
    input clk;   // deshake.v(3[11:14])
    input RESET;   // deshake.v(3[15:20])
    input din;   // deshake.v(3[21:24])
    output dout;   // deshake.v(4[12:16])
    
    wire clk_c /* synthesis SET_AS_NETWORK=clk_c, is_clock=1 */ ;   // deshake.v(3[11:14])
    wire keyclk /* synthesis is_clock=1, SET_AS_NETWORK=keyclk */ ;   // deshake.v(9[9:15])
    
    wire n434, pwr, RESET_c, din_c;
    wire [1:0]pre_s;   // deshake.v(6[15:20])
    wire [1:0]next_s;   // deshake.v(7[15:21])
    wire [18:0]counter;   // deshake.v(8[16:23])
    
    wire dout_c, n232, gnd, n423, n416, n409, n240, n402, n395, 
        n388, n381, keyclk_N_53, n238, n37, n374, n367, n360, 
        n353, n346, n339, n332, n325, n18, n16, n449, n318;
    wire [1:0]pre_s_1__N_1;
    wire [1:0]next_s_1__N_48;
    
    wire n14, n13, n311, n12;
    wire [1:0]next_s_1__N_3;
    
    wire n4, n448, n10, n234, n444, n12_adj_1, n11, n196, n252, 
        n203, n82, n83, n84, n85, n86, n87, n88, n89, n90, 
        n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, 
        n103, n104, n105, n106, n107, n108, n109, n110, n111, 
        n112, n113, n114, n115, n116, n117, n118, n119, n120, 
        n121;
    
    AND2 i5 (.O(n16), .I0(counter[4]), .I1(counter[1]));
    AND2 i124 (.O(n121), .I0(n37), .I1(n100));
    AND3 i2 (.O(next_s_1__N_3[1]), .I0(pre_s[0]), .I1(next_s_1__N_48[1]), 
         .I2(n234));
    DFFR counter_71__i0 (.Q(counter[0]), .D(n121), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    AND2 i292 (.O(n423), .I0(n416), .I1(counter[17]));
    OR6 i1 (.O(n37), .I0(n12_adj_1), .I1(counter[12]), .I2(n10), .I3(n11), 
        .I4(n232), .I5(counter[11]));
    XOR2 i296 (.O(n82), .I0(n423), .I1(counter[18]));
    DFFC dout_34 (.Q(dout_c), .D(n196), .CLK(keyclk), .CE(n240));   // deshake.v(29[12] 43[8])
    XOR2 i282 (.O(n84), .I0(n409), .I1(counter[16]));
    DFFC keyclk_31 (.Q(keyclk), .D(keyclk_N_53), .CLK(clk_c), .CE(RESET_c));   // deshake.v(16[14] 20[33])
    AND2 i285 (.O(n416), .I0(n409), .I1(counter[16]));
    AND2 i278 (.O(n409), .I0(n402), .I1(counter[15]));
    DFFC next_s_i0 (.Q(next_s[0]), .D(next_s_1__N_3[0]), .CLK(keyclk), 
         .CE(n4));   // deshake.v(29[12] 43[8])
    XOR2 i191 (.O(n97), .I0(n318), .I1(counter[3]));
    XOR2 i184 (.O(n98), .I0(n311), .I1(counter[2]));
    AND2 i1_adj_1 (.O(n240), .I0(n203), .I1(n444));
    DFFR counter_71__i18 (.Q(counter[18]), .D(n103), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    GND i319 (.X(gnd));
    VCC i320 (.X(pwr));
    XOR2 i289 (.O(n83), .I0(n416), .I1(counter[17]));
    AND2 i180 (.O(n311), .I0(counter[0]), .I1(counter[1]));
    XOR2 i1_adj_2 (.O(keyclk_N_53), .I0(n37), .I1(n448));
    OR2 i3 (.O(n11), .I0(counter[5]), .I1(counter[7]));
    OR2 i4 (.O(n12_adj_1), .I0(counter[14]), .I1(counter[9]));
    INV i121 (.O(n252), .I0(RESET_c));
    INV i322 (.O(n449), .I0(pre_s[1]));
    AND2 i1_adj_3 (.O(n12), .I0(counter[18]), .I1(counter[15]));
    INV i175 (.O(n100), .I0(counter[0]));
    INV i103 (.O(n234), .I0(pre_s[1]));
    INV i166 (.O(n232), .I0(n434));
    AND2 i2_adj_4 (.O(n13), .I0(counter[17]), .I1(counter[13]));
    INV i321 (.O(n448), .I0(keyclk));
    AND2 i3_adj_5 (.O(n14), .I0(counter[0]), .I1(counter[2]));
    INV i107 (.O(n238), .I0(pre_s[0]));
    DFFR counter_71__i17 (.Q(counter[17]), .D(n104), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i16 (.Q(counter[16]), .D(n105), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i15 (.Q(counter[15]), .D(n106), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i14 (.Q(counter[14]), .D(n107), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i13 (.Q(counter[13]), .D(n108), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i12 (.Q(counter[12]), .D(n109), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i11 (.Q(counter[11]), .D(n110), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i10 (.Q(counter[10]), .D(n111), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i9 (.Q(counter[9]), .D(n112), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i8 (.Q(counter[8]), .D(n113), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i7 (.Q(counter[7]), .D(n114), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i6 (.Q(counter[6]), .D(n115), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i5 (.Q(counter[5]), .D(n116), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i4 (.Q(counter[4]), .D(n117), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i3 (.Q(counter[3]), .D(n118), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i2 (.Q(counter[2]), .D(n119), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFR counter_71__i1 (.Q(counter[1]), .D(n120), .CLK(clk_c), .R(RESET_c)) /* synthesis syn_use_carry_chain=1 */ ;   // deshake.v(20[23:32])
    DFFC next_s_i1 (.Q(next_s[1]), .D(next_s_1__N_3[1]), .CLK(keyclk), 
         .CE(n4));   // deshake.v(29[12] 43[8])
    INV i69 (.O(next_s_1__N_48[1]), .I0(din_c));
    DFF pre_s_i1 (.Q(pre_s[1]), .D(pre_s_1__N_1[1]), .CLK(keyclk));   // deshake.v(23[12] 27[8])
    OR2 i2_adj_6 (.O(n10), .I0(counter[10]), .I1(counter[6]));
    DFF pre_s_i0 (.Q(pre_s[0]), .D(pre_s_1__N_1[0]), .CLK(keyclk));   // deshake.v(23[12] 27[8])
    IBUF din_pad (.O(din_c), .I0(din));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF RESET_pad (.O(RESET_c), .I0(RESET));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OBUF dout_pad (.O(dout), .I0(dout_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i7 (.O(n18), .I0(n14), .I1(n13));
    AND2 i271 (.O(n402), .I0(n395), .I1(counter[14]));
    OR2 i125 (.O(n196), .I0(pre_s[0]), .I1(din_c));
    XOR2 i275 (.O(n85), .I0(n402), .I1(counter[15]));
    XOR2 i268 (.O(n86), .I0(n395), .I1(counter[14]));
    AND6 i10 (.O(n434), .I0(n12), .I1(n18), .I2(counter[3]), .I3(n16), 
         .I4(counter[16]), .I5(counter[8]));
    AND2 i264 (.O(n395), .I0(n388), .I1(counter[13]));
    AND2 i257 (.O(n388), .I0(n381), .I1(counter[12]));
    XOR2 i15 (.O(n203), .I0(pre_s[1]), .I1(pre_s[0]));
    AND2 i250 (.O(n381), .I0(n374), .I1(counter[11]));
    AND2 i243 (.O(n374), .I0(n367), .I1(counter[10]));
    AND2 i236 (.O(n367), .I0(n360), .I1(counter[9]));
    AND2 i229 (.O(n360), .I0(n353), .I1(counter[8]));
    AND2 i222 (.O(n353), .I0(n346), .I1(counter[7]));
    OR2 i1_adj_7 (.O(next_s_1__N_3[0]), .I0(n444), .I1(pre_s[1]));
    AND2 i215 (.O(n346), .I0(n339), .I1(counter[6]));
    AND2 i208 (.O(n339), .I0(n332), .I1(counter[5]));
    OR2 i1_adj_8 (.O(n444), .I0(n238), .I1(din_c));
    AND2 i201 (.O(n332), .I0(n325), .I1(counter[4]));
    XOR2 i261 (.O(n87), .I0(n388), .I1(counter[13]));
    XOR2 i254 (.O(n88), .I0(n381), .I1(counter[12]));
    XOR2 i247 (.O(n89), .I0(n374), .I1(counter[11]));
    XOR2 i240 (.O(n90), .I0(n367), .I1(counter[10]));
    XOR2 i233 (.O(n91), .I0(n360), .I1(counter[9]));
    XOR2 i226 (.O(n92), .I0(n353), .I1(counter[8]));
    XOR2 i219 (.O(n93), .I0(n346), .I1(counter[7]));
    XOR2 i212 (.O(n94), .I0(n339), .I1(counter[6]));
    XOR2 i205 (.O(n95), .I0(n332), .I1(counter[5]));
    XOR2 i198 (.O(n96), .I0(n325), .I1(counter[4]));
    XOR2 i177 (.O(n99), .I0(counter[0]), .I1(counter[1]));
    AND2 i187 (.O(n318), .I0(n311), .I1(counter[2]));
    AND2 i194 (.O(n325), .I0(n318), .I1(counter[3]));
    OR2 i122 (.O(pre_s_1__N_1[0]), .I0(n252), .I1(next_s[0]));
    AND2 i140 (.O(n103), .I0(n37), .I1(n82));
    AND2 i141 (.O(n104), .I0(n37), .I1(n83));
    AND2 i142 (.O(n105), .I0(n37), .I1(n84));
    AND2 i143 (.O(n106), .I0(n37), .I1(n85));
    AND2 i144 (.O(n107), .I0(n37), .I1(n86));
    AND2 i145 (.O(n108), .I0(n37), .I1(n87));
    AND2 i146 (.O(n109), .I0(n37), .I1(n88));
    AND2 i147 (.O(n110), .I0(n37), .I1(n89));
    AND2 i148 (.O(n111), .I0(n37), .I1(n90));
    AND2 i149 (.O(n112), .I0(n37), .I1(n91));
    AND2 i150 (.O(n113), .I0(n37), .I1(n92));
    AND2 i151 (.O(n114), .I0(n37), .I1(n93));
    AND2 i152 (.O(n115), .I0(n37), .I1(n94));
    AND2 i153 (.O(n116), .I0(n37), .I1(n95));
    AND2 i154 (.O(n117), .I0(n37), .I1(n96));
    AND2 i155 (.O(n118), .I0(n37), .I1(n97));
    AND2 i156 (.O(n119), .I0(n37), .I1(n98));
    AND2 i157 (.O(n120), .I0(n37), .I1(n99));
    AND2 i158 (.O(pre_s_1__N_1[1]), .I0(RESET_c), .I1(next_s[1]));
    OR2 i323 (.O(n4), .I0(n196), .I1(n449));
    
endmodule
//
// Verilog Description of module AND2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND3
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR6
// module not written out since it is a black-box. 
//

//
// Verilog Description of module XOR2
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

//
// Verilog Description of module OR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module INV
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND6
// module not written out since it is a black-box. 
//

