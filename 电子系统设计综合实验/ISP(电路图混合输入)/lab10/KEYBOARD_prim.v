// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Fri May 26 11:55:02 2023
//
// Verilog Description of module KEYBOARD
//

module KEYBOARD (clk, reset, KeyClock, KeyData, PS_Data, save) /* synthesis syn_module_defined=1 */ ;   // keyboard.v(1[8:16])
    input clk;   // keyboard.v(2[7:10])
    input reset;   // keyboard.v(2[11:16])
    input KeyClock;   // keyboard.v(2[17:25])
    input KeyData;   // keyboard.v(2[26:33])
    output [3:0]PS_Data;   // keyboard.v(3[14:21])
    output [3:0]save;   // keyboard.v(4[14:18])
    
    wire clk_c /* synthesis SET_AS_NETWORK=clk_c, is_clock=1 */ ;   // keyboard.v(2[7:10])
    wire RxEn /* synthesis is_clock=1 */ ;   // keyboard.v(8[41:45])
    wire RxEn_N_39 /* synthesis is_inv_clock=1, SET_AS_NETWORK=RxEn_N_39, is_clock=1 */ ;   // keyboard.v(10[11:21])
    
    wire pwr, gnd, reset_c, KeyClock_c, KeyData_c, neg_KeyClock, 
        KeyClock_r0, KeyClock_r1, KeyClock_r2, LedEn, save_c_3, save_c_2, 
        save_c_1, save_c_0;
    wire [3:0]counter;   // keyboard.v(9[16:23])
    
    wire PS_Data_c_3, PS_Data_c_2, PS_Data_c_1, PS_Data_c_0;
    wire [7:0]LastRxData;   // keyboard.v(10[11:21])
    
    wire n1132;
    wire [10:0]RxData;   // keyboard.v(11[12:18])
    
    wire KeyClock_r1_N_71, n1009, RxEn_N_41, n41, n56, n57, n5, 
        n44, n1155, n59, n498, n48, n1152, n25, n12, n1146, 
        n1130, n34, n1141, n18, LedEn_N_75, n17, n1148, n11, 
        n979, n32, n1013, save_3__N_9;
    wire [3:0]PS_Data_3__N_26;
    wire [3:0]save_3__N_1;
    
    wire n4, save_3__N_5, n1149, n14, n484, n13, n40, n9, n996, 
        n5_adj_1, n1161, n23, n46, n50, n52, n53, n55, n1158, 
        n1164, n45, n496, n30, n51, n13_adj_2, n19, n1168, n50_adj_3, 
        n31, n10, n1126, n1124, n1120, n10_adj_4, n39, n1171, 
        n42, n1174, n11_adj_5, n44_adj_6, n50_adj_7, n67, n1177, 
        n12_adj_8, n1137, n1116, n839, n17_adj_9, n22, n1140, 
        n12_adj_10, n10_adj_11, n4_adj_12, n9_adj_13, n5_adj_14, n4_adj_15, 
        n9_adj_16, n4_adj_17, n5_adj_18, n14_adj_19, n20, n14_adj_20, 
        n1147, n490, n1115, n42_adj_21, n16, n14_adj_22, n39_adj_23, 
        n37, n833, n999, n831, n29, n497, n7, n1144, n24, 
        n1007, n1010, n986, n491, n22_adj_24, n23_adj_25, n1003, 
        n821, n30_adj_26, n1121, n28, n493, n1020, n27, n63, 
        n62, n55_adj_27, n33, n771, n5_adj_28, n767, n58, n59_adj_29, 
        n760, n60, n754, n752, n751, n1150, n745, n1134, n34_adj_30, 
        n1179, n1178, n1175, n1173, n1172, n1170, n1169, n10_adj_31, 
        n1167, n1143, n1166, n1165, n1162, n1160, n1159, n1156, 
        n1153, n1151, n1145;
    
    DFFR KeyClock_r2_111 (.Q(KeyClock_r2), .D(KeyClock_r1), .CLK(clk_c), 
         .R(reset_c));   // keyboard.v(23[9] 27[12])
    DLATR PS_Data_3__I_0_i1 (.Q(PS_Data_c_0), .D(PS_Data_3__N_26[0]), .LAT(save_3__N_9), 
          .R(reset_c));   // keyboard.v(73[1] 97[4])
    OR3 i1 (.O(n491), .I0(n1153), .I1(n490), .I2(n1152));
    OR2 i1_adj_1 (.O(n490), .I0(n57), .I1(n5_adj_14));
    DFFCR counter_185__i0 (.Q(counter[0]), .D(n996), .CLK(clk_c), .CE(neg_KeyClock), 
          .R(reset_c));   // keyboard.v(52[26:35])
    DFFR LedEn_117 (.Q(LedEn), .D(LedEn_N_75), .CLK(RxEn_N_39), .R(reset_c));   // keyboard.v(64[10] 70[12])
    DLAT save_3__I_0_i1 (.Q(save_c_0), .D(save_3__N_1[0]), .LAT(save_3__N_5));   // keyboard.v(73[1] 97[4])
    DLAT save_3__I_0_i3 (.Q(save_c_2), .D(save_3__N_1[2]), .LAT(save_3__N_5));   // keyboard.v(73[1] 97[4])
    AND2 i1018 (.O(n1153), .I0(LastRxData[0]), .I1(n1009));
    AND3 i1011 (.O(n1146), .I0(n4_adj_17), .I1(n19), .I2(LastRxData[0]));
    DFFR KeyClock_r0_109 (.Q(KeyClock_r0), .D(KeyClock_c), .CLK(clk_c), 
         .R(reset_c));   // keyboard.v(23[9] 27[12])
    DLAT save_3__I_0_i2 (.Q(save_c_1), .D(save_3__N_1[1]), .LAT(save_3__N_5));   // keyboard.v(73[1] 97[4])
    DLAT save_3__I_0_i4 (.Q(save_c_3), .D(save_3__N_1[3]), .LAT(save_3__N_5));   // keyboard.v(73[1] 97[4])
    DLATR PS_Data_3__I_0_i2 (.Q(PS_Data_c_1), .D(PS_Data_3__N_26[1]), .LAT(save_3__N_9), 
          .R(reset_c));   // keyboard.v(73[1] 97[4])
    DLATR PS_Data_3__I_0_i3 (.Q(PS_Data_c_2), .D(PS_Data_3__N_26[2]), .LAT(save_3__N_9), 
          .R(reset_c));   // keyboard.v(73[1] 97[4])
    DLATR PS_Data_3__I_0_i4 (.Q(PS_Data_c_3), .D(PS_Data_3__N_26[3]), .LAT(save_3__N_9), 
          .R(reset_c));   // keyboard.v(73[1] 97[4])
    OR2 i1_adj_2 (.O(n5_adj_14), .I0(n31), .I1(LastRxData[7]));
    OR2 i1_adj_3 (.O(n497), .I0(n496), .I1(n53));
    OR2 i1_adj_4 (.O(n498), .I0(n496), .I1(n51));
    OR2 i1_adj_5 (.O(n1116), .I0(n1115), .I1(n14_adj_22));
    OR2 LastRxData_7__I_0_132_i13 (.O(n13), .I0(LastRxData[7]), .I1(LastRxData[6]));
    AND2 i2 (.O(save_3__N_1[0]), .I0(n4_adj_12), .I1(n1151));
    XOR2 i837 (.O(n24), .I0(counter[0]), .I1(counter[1]));
    AND2 i1_adj_6 (.O(n4_adj_12), .I0(LastRxData[2]), .I1(n12));
    AND2 neg_KeyClock_I_0 (.O(neg_KeyClock), .I0(KeyClock_r2), .I1(KeyClock_r1_N_71));
    OR2 LastRxData_7__I_0_128_i9 (.O(n9_adj_16), .I0(LastRxData[1]), .I1(n5));
    OR2 LastRxData_7__I_0_128_i12 (.O(n12_adj_8), .I0(LastRxData[5]), .I1(LastRxData[4]));
    DFFR LastRxData_i0_i7 (.Q(LastRxData[7]), .D(RxData[8]), .CLK(RxEn_N_39), 
         .R(reset_c));   // keyboard.v(64[10] 70[12])
    DFFC RxData_i0_i7 (.Q(RxData[7]), .D(KeyData_c), .CLK(clk_c), .CE(n59_adj_29));   // keyboard.v(40[10] 53[12])
    DFFC RxData_i0_i3 (.Q(RxData[3]), .D(KeyData_c), .CLK(clk_c), .CE(n60));   // keyboard.v(40[10] 53[12])
    DFFC RxData_i0_i4 (.Q(RxData[4]), .D(KeyData_c), .CLK(clk_c), .CE(n34_adj_30));   // keyboard.v(40[10] 53[12])
    DFFC RxData_i0_i5 (.Q(RxData[5]), .D(KeyData_c), .CLK(clk_c), .CE(n32));   // keyboard.v(40[10] 53[12])
    DFFC RxData_i0_i8 (.Q(RxData[8]), .D(KeyData_c), .CLK(clk_c), .CE(n1007));   // keyboard.v(40[10] 53[12])
    DFFC RxData_i0_i2 (.Q(RxData[2]), .D(KeyData_c), .CLK(clk_c), .CE(n1020));   // keyboard.v(40[10] 53[12])
    OR2 i691 (.O(n831), .I0(LastRxData[5]), .I1(LastRxData[6]));
    AND2 i1_adj_7 (.O(n57), .I0(n56), .I1(LastRxData[6]));
    AND2 i987 (.O(n1124), .I0(n14_adj_19), .I1(n14));
    OR2 i1_adj_8 (.O(PS_Data_3__N_26[0]), .I0(n48), .I1(save_3__N_1[0]));
    XOR2 i844 (.O(n23_adj_25), .I0(n979), .I1(counter[2]));
    AND2 i1_adj_9 (.O(n17_adj_9), .I0(n1160), .I1(LastRxData[4]));
    AND2 i693 (.O(n833), .I0(LastRxData[3]), .I1(LastRxData[2]));
    XOR2 i77 (.O(n67), .I0(LastRxData[4]), .I1(LastRxData[3]));
    DFFS LastRxData_i0_i6 (.Q(LastRxData[6]), .D(RxData[7]), .CLK(RxEn_N_39), 
         .S(reset_c));   // keyboard.v(64[10] 70[12])
    DFFR LastRxData_i0_i5 (.Q(LastRxData[5]), .D(RxData[6]), .CLK(RxEn_N_39), 
         .R(reset_c));   // keyboard.v(64[10] 70[12])
    AND3 i1008 (.O(n1143), .I0(n4), .I1(n17), .I2(LastRxData[4]));
    DFFR LastRxData_i0_i4 (.Q(LastRxData[4]), .D(RxData[5]), .CLK(RxEn_N_39), 
         .R(reset_c));   // keyboard.v(64[10] 70[12])
    DFFR LastRxData_i0_i3 (.Q(LastRxData[3]), .D(RxData[4]), .CLK(RxEn_N_39), 
         .R(reset_c));   // keyboard.v(64[10] 70[12])
    DFFS LastRxData_i0_i2 (.Q(LastRxData[2]), .D(RxData[3]), .CLK(RxEn_N_39), 
         .S(reset_c));   // keyboard.v(64[10] 70[12])
    DFFR LastRxData_i0_i1 (.Q(LastRxData[1]), .D(RxData[2]), .CLK(RxEn_N_39), 
         .R(reset_c));   // keyboard.v(64[10] 70[12])
    DFFCR counter_185__i3 (.Q(counter[3]), .D(n28), .CLK(clk_c), .CE(neg_KeyClock), 
          .R(reset_c));   // keyboard.v(52[26:35])
    OR2 i1007 (.O(RxEn_N_41), .I0(n1141), .I1(n1140));
    OR2 i989 (.O(n1126), .I0(counter[3]), .I1(counter[0]));
    AND2 i1021 (.O(n1156), .I0(LastRxData[0]), .I1(n55));
    OR2 i1_adj_10 (.O(n44_adj_6), .I0(LastRxData[3]), .I1(n13_adj_2));
    AND3 i1042 (.O(n1177), .I0(n5_adj_1), .I1(n4), .I2(LastRxData[5]));
    OR3 i993 (.O(n1130), .I0(n10_adj_11), .I1(n9_adj_16), .I2(n14_adj_20));
    AND2 i1039 (.O(n1174), .I0(n5), .I1(n19));
    AND3 i2_adj_11 (.O(n1121), .I0(LastRxData[4]), .I1(n17), .I2(n5_adj_18));
    AND2 i1024 (.O(n1159), .I0(LastRxData[5]), .I1(n9));
    AND2 i1036 (.O(n1171), .I0(n5), .I1(n18));
    OR2 i1025 (.O(n1160), .I0(n1159), .I1(n1158));
    AND3 i1027 (.O(n1162), .I0(n17_adj_9), .I1(LastRxData[3]), .I2(n4_adj_12));
    DFFCR counter_185__i2 (.Q(counter[2]), .D(n29), .CLK(clk_c), .CE(neg_KeyClock), 
          .R(reset_c));   // keyboard.v(52[26:35])
    DFFCR counter_185__i1 (.Q(counter[1]), .D(n30_adj_26), .CLK(clk_c), 
          .CE(neg_KeyClock), .R(reset_c));   // keyboard.v(52[26:35])
    DFFC RxData_i0_i1 (.Q(RxData[1]), .D(KeyData_c), .CLK(clk_c), .CE(n33));   // keyboard.v(40[10] 53[12])
    OR4 i3 (.O(n39_adj_23), .I0(n42_adj_21), .I1(n34), .I2(n37), .I3(n1120));
    OR4 i2_adj_12 (.O(n1013), .I0(n490), .I1(n1175), .I2(n42), .I3(n1174));
    AND2 i1030 (.O(n1165), .I0(n1164), .I1(n9));
    OR2 i1_adj_13 (.O(n50_adj_7), .I0(n67), .I1(LastRxData[1]));
    AND3 i2_adj_14 (.O(n1003), .I0(save_c_1), .I1(LastRxData[0]), .I2(n17));
    AND2 i1031 (.O(n1166), .I0(n67), .I1(n5_adj_1));
    DFFR KeyClock_r1_110 (.Q(KeyClock_r1), .D(KeyClock_r0), .CLK(clk_c), 
         .R(reset_c));   // keyboard.v(23[9] 27[12])
    AND2 i1009 (.O(n1144), .I0(LastRxData[5]), .I1(n18));
    AND3 i2_adj_15 (.O(n4_adj_17), .I0(LastRxData[3]), .I1(LastRxData[5]), 
         .I2(LastRxData[4]));
    AND2 i1003 (.O(n996), .I0(n1137), .I1(RxEn_N_41));
    IBUF KeyData_pad (.O(KeyData_c), .I0(KeyData));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF KeyClock_pad (.O(KeyClock_c), .I0(KeyClock));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF reset_pad (.O(reset_c), .I0(reset));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OBUF save_pad_0 (.O(save[0]), .I0(save_c_0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF save_pad_1 (.O(save[1]), .I0(save_c_1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF save_pad_2 (.O(save[2]), .I0(save_c_2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF save_pad_3 (.O(save[3]), .I0(save_c_3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF PS_Data_pad_0 (.O(PS_Data[0]), .I0(PS_Data_c_0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF PS_Data_pad_1 (.O(PS_Data[1]), .I0(PS_Data_c_1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF PS_Data_pad_2 (.O(PS_Data[2]), .I0(PS_Data_c_2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFCS RxEn_114 (.Q(RxEn), .D(RxEn_N_41), .CLK(clk_c), .CE(neg_KeyClock), 
          .S(reset_c));   // keyboard.v(40[10] 53[12])
    AND2 i1_adj_16 (.O(n39), .I0(n1013), .I1(save_c_3));
    OR2 i1032 (.O(n1167), .I0(n1166), .I1(n1165));
    OBUF PS_Data_pad_3 (.O(PS_Data[3]), .I0(PS_Data_c_3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFS LastRxData_i0_i0 (.Q(LastRxData[0]), .D(RxData[1]), .CLK(RxEn_N_39), 
         .S(reset_c));   // keyboard.v(64[10] 70[12])
    DFFC RxData_i0_i6 (.Q(RxData[6]), .D(KeyData_c), .CLK(clk_c), .CE(n62));   // keyboard.v(40[10] 53[12])
    OR4 i4 (.O(n10_adj_31), .I0(LastRxData[2]), .I1(LastRxData[0]), .I2(n493), 
        .I3(n12));
    OR2 LastRxData_7__I_0_130_i9 (.O(n9_adj_13), .I0(n19), .I1(LastRxData[0]));
    AND2 i840 (.O(n979), .I0(counter[0]), .I1(counter[1]));
    AND2 i1034 (.O(n1169), .I0(LastRxData[6]), .I1(n10_adj_4));
    OR2 i1_adj_17 (.O(PS_Data_3__N_26[3]), .I0(n39), .I1(save_3__N_1[3]));
    OR2 i1035 (.O(n1170), .I0(n1169), .I1(n1168));
    AND2 i1_adj_18 (.O(n42), .I0(n1173), .I1(n17));
    AND2 i1037 (.O(n1172), .I0(LastRxData[0]), .I1(n44_adj_6));
    OR2 i1_adj_19 (.O(n50_adj_3), .I0(LastRxData[3]), .I1(n25));
    OR3 i2_adj_20 (.O(n14), .I0(LastRxData[4]), .I1(n17), .I2(n13));
    OR2 i1038 (.O(n1173), .I0(n1172), .I1(n1171));
    AND2 i1040 (.O(n1175), .I0(LastRxData[0]), .I1(n50_adj_7));
    INV i1005 (.O(n1140), .I0(n27));
    INV i1006 (.O(n1141), .I0(counter[3]));
    INV i999 (.O(n1134), .I0(n10_adj_31));
    AND2 i1043 (.O(n1178), .I0(LastRxData[3]), .I1(n17_adj_9));
    OR2 i1044 (.O(n1179), .I0(n1178), .I1(n1177));
    AND2 i1033 (.O(n1168), .I0(n13_adj_2), .I1(n4_adj_17));
    INV i9 (.O(n745), .I0(n5_adj_28));
    INV i612 (.O(n752), .I0(counter[2]));
    INV i635 (.O(n767), .I0(counter[1]));
    INV i639 (.O(n751), .I0(counter[3]));
    AND3 i2_adj_21 (.O(save_3__N_5), .I0(save_3__N_9), .I1(reset_c), .I2(n39_adj_23));
    OR3 i995 (.O(n1132), .I0(n10), .I1(n1124), .I2(n9_adj_16));
    INV i19 (.O(n16), .I0(n11_adj_5));
    AND2 i1_adj_22 (.O(n48), .I0(n491), .I1(save_c_0));
    AND3 i2_adj_23 (.O(save_3__N_1[3]), .I0(n5_adj_1), .I1(n4_adj_12), 
         .I2(n1170));
    OR3 i2_adj_24 (.O(n1010), .I0(LastRxData[5]), .I1(LastRxData[3]), 
        .I2(LastRxData[4]));
    INV i20 (.O(n20), .I0(n14_adj_20));
    OR2 i1010 (.O(n1145), .I0(n1144), .I1(n1143));
    AND3 i2_adj_25 (.O(save_3__N_1[1]), .I0(n5_adj_18), .I1(n1179), .I2(LastRxData[2]));
    AND2 i1_adj_26 (.O(n5_adj_1), .I0(n5), .I1(LastRxData[1]));
    OR2 LastRxData_7__I_0_131_i11 (.O(n11_adj_5), .I0(n10), .I1(n9_adj_13));
    AND3 i2_adj_27 (.O(save_3__N_1[2]), .I0(n1167), .I1(n484), .I2(n5_adj_18));
    INV i22 (.O(n22), .I0(n14));
    AND2 i1_adj_28 (.O(n45), .I0(n498), .I1(save_c_2));
    INV i990 (.O(n4_adj_15), .I0(n1126));
    OR2 i1_adj_29 (.O(n5_adj_28), .I0(counter[0]), .I1(counter[2]));
    AND2 i1_adj_30 (.O(n760), .I0(n55_adj_27), .I1(counter[2]));
    INV i700 (.O(n12_adj_10), .I0(n839));
    AND2 i1_adj_31 (.O(n32), .I0(n760), .I1(n30));
    INV i698 (.O(n10_adj_4), .I0(n1010));
    OR2 i1_adj_32 (.O(PS_Data_3__N_26[2]), .I0(save_3__N_1[2]), .I1(n45));
    INV i10 (.O(n5), .I0(LastRxData[0]));
    AND3 i1012 (.O(n1147), .I0(n1145), .I1(LastRxData[1]), .I2(n5));
    INV i9_adj_33 (.O(n18), .I0(LastRxData[4]));
    AND2 i1_adj_34 (.O(n51), .I0(n50_adj_3), .I1(n18));
    INV i4_adj_35 (.O(n4), .I0(LastRxData[3]));
    AND2 i1_adj_36 (.O(n58), .I0(n63), .I1(counter[1]));
    AND2 i1_adj_37 (.O(n30), .I0(n63), .I1(n767));
    INV i1_adj_38 (.O(n12), .I0(LastRxData[7]));
    AND2 i1_adj_39 (.O(n63), .I0(reset_c), .I1(neg_KeyClock));
    OR2 i1_adj_40 (.O(n46), .I0(n23), .I1(n999));
    INV i2_adj_41 (.O(n13_adj_2), .I0(LastRxData[6]));
    AND2 i1_adj_42 (.O(n23), .I0(save_c_1), .I1(n18));
    INV i219 (.O(n19), .I0(LastRxData[1]));
    AND2 i1_adj_43 (.O(n754), .I0(n55_adj_27), .I1(n752));
    INV i696 (.O(n5_adj_18), .I0(n13));
    INV i28 (.O(n31), .I0(LastRxData[2]));
    INV i694 (.O(n10_adj_11), .I0(n833));
    AND2 i1_adj_44 (.O(n62), .I0(n58), .I1(n771));
    OR2 i1013 (.O(n1148), .I0(n1147), .I1(n1146));
    AND2 i1_adj_45 (.O(n55_adj_27), .I0(n751), .I1(counter[0]));
    AND2 i1_adj_46 (.O(n60), .I0(n58), .I1(n754));
    AND2 i1_adj_47 (.O(n30_adj_26), .I0(n24), .I1(RxEn_N_41));
    OR2 i1_adj_48 (.O(n52), .I0(LastRxData[0]), .I1(n17));
    AND2 i1_adj_49 (.O(n33), .I0(n754), .I1(n30));
    AND2 i1_adj_50 (.O(n34_adj_30), .I0(n771), .I1(n30));
    OR2 i1_adj_51 (.O(n55), .I0(LastRxData[1]), .I1(LastRxData[4]));
    AND3 i1015 (.O(n1150), .I0(n10_adj_4), .I1(LastRxData[6]), .I2(n5_adj_1));
    AND2 i1_adj_52 (.O(n28), .I0(n22_adj_24), .I1(RxEn_N_41));
    INV i7 (.O(n7), .I0(n11));
    INV i1029 (.O(n1164), .I0(n67));
    INV i1002 (.O(n1137), .I0(counter[0]));
    AND2 i1_adj_53 (.O(n29), .I0(n23_adj_25), .I1(RxEn_N_41));
    INV i692 (.O(n25), .I0(n831));
    AND3 i1026 (.O(n1161), .I0(n46), .I1(n4), .I2(n5));
    OR2 i1_adj_54 (.O(n27), .I0(counter[2]), .I1(counter[1]));
    AND2 i1_adj_55 (.O(n59_adj_29), .I0(n58), .I1(n760));
    AND2 i1023 (.O(n1158), .I0(n17), .I1(n5_adj_1));
    XOR2 i851 (.O(n22_adj_24), .I0(n986), .I1(counter[3]));
    OR3 i1_adj_56 (.O(n40), .I0(n1162), .I1(n1161), .I2(n1003));
    AND3 i1000 (.O(LedEn_N_75), .I0(LastRxData[6]), .I1(n1134), .I2(n839));
    INV i996 (.O(n42_adj_21), .I0(n1132));
    INV i205 (.O(n17), .I0(LastRxData[5]));
    AND2 i699 (.O(n839), .I0(LastRxData[5]), .I1(LastRxData[4]));
    INV i14 (.O(n14_adj_22), .I0(n14_adj_19));
    INV i994 (.O(n1120), .I0(n1130));
    OR2 i1016 (.O(n1151), .I0(n1150), .I1(n1149));
    VCC i998 (.X(pwr));
    INV i177 (.O(save_3__N_9), .I0(LedEn));
    INV RxEn_I_0_140 (.O(RxEn_N_39), .I0(RxEn));
    INV i683 (.O(n59), .I0(n821));
    AND3 i2_adj_57 (.O(n999), .I0(n12), .I1(n484), .I2(LastRxData[1]));
    AND2 i682 (.O(n821), .I0(LastRxData[1]), .I1(LastRxData[4]));
    AND2 i1_adj_58 (.O(n9), .I0(LastRxData[0]), .I1(n19));
    INV KeyClock_r1_I_0 (.O(KeyClock_r1_N_71), .I0(KeyClock_r1));
    AND2 i847 (.O(n986), .I0(n979), .I1(counter[2]));
    AND2 i1_adj_59 (.O(n37), .I0(n1116), .I1(n16));
    OR3 i2_adj_60 (.O(n1009), .I0(n25), .I1(n493), .I2(LastRxData[4]));
    AND2 i1_adj_61 (.O(n41), .I0(n40), .I1(n13_adj_2));
    AND2 i2_adj_62 (.O(n771), .I0(n4_adj_15), .I1(counter[2]));
    AND2 i1_adj_63 (.O(n44), .I0(n497), .I1(save_c_1));
    OR2 LastRxData_7__I_0_132_i10 (.O(n10), .I0(LastRxData[3]), .I1(n31));
    OR2 i1_adj_64 (.O(PS_Data_3__N_26[1]), .I0(n44), .I1(n41));
    OR3 i2_adj_65 (.O(n14_adj_19), .I0(n12_adj_8), .I1(LastRxData[7]), 
        .I2(n13_adj_2));
    AND3 i2_adj_66 (.O(n1020), .I0(n58), .I1(n751), .I2(n745));
    AND2 i1_adj_67 (.O(n484), .I0(LastRxData[2]), .I1(LastRxData[5]));
    AND3 i2_adj_68 (.O(n1007), .I0(n30), .I1(n745), .I2(counter[3]));
    OR2 LastRxData_7__I_0_134_i14 (.O(n14_adj_20), .I0(n13), .I1(n12_adj_10));
    OR2 LastRxData_7__I_0_133_i11 (.O(n11), .I0(n10_adj_11), .I1(n9_adj_13));
    AND2 i1_adj_69 (.O(n50), .I0(n12_adj_8), .I1(LastRxData[6]));
    AND2 i1_adj_70 (.O(n53), .I0(n52), .I1(LastRxData[3]));
    AND2 i1020 (.O(n1155), .I0(n5), .I1(n19));
    OR2 i1_adj_71 (.O(n56), .I0(n5), .I1(LastRxData[5]));
    OR3 i2_adj_72 (.O(n1115), .I0(n20), .I1(n1121), .I2(n22));
    AND2 i1017 (.O(n1152), .I0(n5), .I1(n59));
    AND2 i1_adj_73 (.O(n34), .I0(n1115), .I1(n7));
    AND2 i1014 (.O(n1149), .I0(n13_adj_2), .I1(n1148));
    OR4 i1_adj_74 (.O(n496), .I0(n1156), .I1(n50), .I2(n1155), .I3(n5_adj_14));
    GND i997 (.X(gnd));
    OR2 i1_adj_75 (.O(n493), .I0(LastRxData[3]), .I1(LastRxData[1]));
    
endmodule
//
// Verilog Description of module OR3
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
// Verilog Description of module AND3
// module not written out since it is a black-box. 
//

//
// Verilog Description of module XOR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR4
// module not written out since it is a black-box. 
//

//
// Verilog Description of module INV
// module not written out since it is a black-box. 
//

//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

//
// Verilog Description of module GND
// module not written out since it is a black-box. 
//

