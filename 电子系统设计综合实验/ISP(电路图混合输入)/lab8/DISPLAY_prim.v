// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Mon May 29 00:01:26 2023
//
// Verilog Description of module DISPLAY
//

module DISPLAY (clk, reset, num1, num2, num3, num4, LED_A, LED_B, 
            LED_C, LED_D, LED_E, LED_F, LED_G, LED_VCC1, LED_VCC2, 
            LED_VCC3, LED_VCC4) /* synthesis syn_module_defined=1 */ ;   // display.v(1[8:15])
    input clk;   // display.v(2[7:10])
    input reset;   // display.v(3[7:12])
    input [3:0]num1;   // display.v(4[13:17])
    input [3:0]num2;   // display.v(5[13:17])
    input [3:0]num3;   // display.v(6[13:17])
    input [3:0]num4;   // display.v(7[13:17])
    output LED_A;   // display.v(9[12:17])
    output LED_B;   // display.v(9[18:23])
    output LED_C;   // display.v(9[24:29])
    output LED_D;   // display.v(9[30:35])
    output LED_E;   // display.v(9[36:41])
    output LED_F;   // display.v(9[42:47])
    output LED_G;   // display.v(9[48:53])
    output LED_VCC1;   // display.v(9[54:62])
    output LED_VCC2;   // display.v(9[63:71])
    output LED_VCC3;   // display.v(9[72:80])
    output LED_VCC4;   // display.v(9[81:89])
    
    wire clk_c /* synthesis SET_AS_NETWORK=clk_c, is_clock=1 */ ;   // display.v(2[7:10])
    
    wire n220, pwr, reset_c, num1_c_3, num1_c_2, num1_c_1, num1_c_0, 
        num2_c_3, num2_c_2, num2_c_1, num2_c_0, num3_c_3, num3_c_2, 
        num3_c_1, num3_c_0, num4_c_3, num4_c_2, num4_c_1, num4_c_0, 
        LED_A_c, LED_B_c, LED_C_c, LED_D_c, LED_E_c, LED_F_c, LED_G_c, 
        LED_VCC2_c, LED_VCC3_c, LED_VCC4_c;
    wire [1:0]scancnt;   // display.v(11[11:18])
    wire [12:0]count;   // display.v(12[12:17])
    
    wire n51, n4, n1139, n600, n1102, n9, n1199, n1152, n1151, 
        n1132, n6, n5, n281, LED_A_N_44, LED_B_N_53, LED_C_N_61, 
        LED_D_N_69, LED_E_N_77, LED_G_N_93, LED_A_N_42, LED_B_N_52, 
        LED_C_N_60, LED_D_N_68, LED_E_N_76, LED_G_N_92, LED_A_N_40, 
        LED_B_N_51, LED_C_N_59, LED_D_N_67, LED_E_N_75, LED_G_N_91, 
        LED_E_N_74, LED_G_N_90, n50, n1149, n1094, n1148, n1123, 
        n1146, LED_A_N_36, LED_B_N_48, LED_C_N_56, LED_D_N_64, LED_E_N_72, 
        LED_G_N_88, n881, LED_VCC2_N_100, LED_A_N_35, LED_B_N_47, 
        LED_C_N_55, LED_D_N_63, LED_E_N_71, LED_G_N_87, LED_VCC3_N_103, 
        LED_A_N_34, LED_B_N_46, LED_C_N_54, LED_D_N_62, LED_E_N_70, 
        LED_F_N_78, LED_G_N_86, n1138, LED_VCC4_N_106, n749, n1198, 
        n874, n811, n867, n25, n1135, n1141, n1134, n1129, n860, 
        n1197, n1196, n371, n1195, n58, n59, n60, n61, n62, 
        n64, n65, n66, n67, n73, n74, n75, n76, n77, n79, 
        n80, n81, n82, n85, n349, n351, n353, n355, n1194, 
        n1192, n1191, n1130, n1157, n1189, n1188, n2, n1301, 
        n4_adj_1, n1143, n1226, n1147, n1150, n1108, n1140, n1154, 
        n1110, n30, n7, n10, n1153, n25_adj_2, n1121, n1155, 
        n1156, n40, n3, n2_adj_3, n49, n3_adj_4, n1235, n1186, 
        n1300, n14, n1185, n1299, n1101, n1145, n1298, n1296, 
        n1183, n839, n1182, n2_adj_5, n1294, n1247, n1293, n1292, 
        n7_adj_6, n1290, n10_adj_7, n1288, n3_adj_8, n1256, n1287, 
        n14_adj_9, n1285, n1284, n403, n6_adj_10, n1283, n1281, 
        n2_adj_11, n1279, n1180, n1278, n1276, n1275, n14_adj_12, 
        n610, n1271, n1274, n1272, n1270, n3_adj_13, n1269, n6_adj_14, 
        n1277, n1268, n3_adj_15, n1266, n1280, n10_adj_16, n14_adj_17, 
        n1265, n1179, n1263, n1177, n1262, n1260, n6_adj_18, n1259, 
        n1257, n1255, n1144, n427, n421, n418, n1176, n1127, 
        n1289, n412, n1286, n410, n406, n1254, n401, n1253, 
        n7_adj_19, n1158, n5_adj_20, n3_adj_21, n853, n825, n6_adj_22, 
        n1161, n604, n386, n901, n3_adj_23, n634, n1160, n1295, 
        n818, n626, n1142, n14_adj_24, n1251, n1250, n1248, n1175, 
        n1173, n1246, n1245, n1244, n1242, n1172, n1170, n1241, 
        n1239, n1238, n1236, n1234, n1233, n1169, n1232, n1167, 
        n1230, n1229, n1227, n992, n1225, n1166, n1164, n1163, 
        n1224, n1223, n1221, n1220, n1218, n1217, n1215, n1214, 
        n1212, n1211, n1209, n1208, n1206, n1205, n1203, n1202, 
        n1200, n4_adj_25, n1137, n1104, n8, n1062, n1115;
    
    AND2 i1084 (.O(n1140), .I0(n2_adj_5), .I1(n1108));
    AND3 i1098 (.O(n1154), .I0(n1139), .I1(scancnt[1]), .I2(n418));
    OR2 i1193 (.O(LED_D_N_68), .I0(n1248), .I1(n1247));
    AND3 i1195 (.O(n1251), .I0(n30), .I1(num2_c_3), .I2(n10_adj_7));
    AND2 i1081 (.O(n1137), .I0(n421), .I1(n3_adj_21));
    AND2 i1120 (.O(n1176), .I0(n1175), .I1(LED_A_N_36));
    AND2 i1121 (.O(n1177), .I0(LED_VCC3_N_103), .I1(LED_A_N_42));
    OR2 i1196 (.O(LED_E_N_76), .I0(n1251), .I1(n1250));
    AND3 i1198 (.O(n1254), .I0(num2_c_1), .I1(num2_c_2), .I2(num2_c_0));
    OR2 i1199 (.O(n1255), .I0(n1254), .I1(n1253));
    DFFCS LED_B_109 (.Q(LED_B_c), .D(LED_B_N_46), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    DFFCS LED_C_110 (.Q(LED_C_c), .D(LED_C_N_54), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    DFFCS LED_D_111 (.Q(LED_D_c), .D(LED_D_N_62), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    DFFCS LED_E_112 (.Q(LED_E_c), .D(LED_E_N_70), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    DFFCS LED_F_113 (.Q(LED_F_c), .D(LED_F_N_78), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    DFFCS LED_G_114 (.Q(LED_G_c), .D(LED_G_N_86), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    DFFCR LED_VCC3_117 (.Q(LED_VCC3_c), .D(LED_VCC3_N_103), .CLK(clk_c), 
          .CE(pwr), .R(reset_c));   // display.v(36[10] 343[12])
    DFFCR LED_VCC4_118 (.Q(LED_VCC4_c), .D(LED_VCC4_N_106), .CLK(clk_c), 
          .CE(pwr), .R(reset_c));   // display.v(36[10] 343[12])
    DFFCS LED_A_108 (.Q(LED_A_c), .D(LED_A_N_34), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    OR2 i1122 (.O(LED_A_N_35), .I0(n1177), .I1(n1176));
    DFF scancnt__i0 (.Q(scancnt[0]), .D(n6), .CLK(clk_c));   // display.v(19[10] 25[24])
    AND2 i782 (.O(n839), .I0(n4_adj_25), .I1(count[5]));
    AND2 i1124 (.O(n1180), .I0(LED_VCC3_N_103), .I1(LED_B_N_52));
    DFFR count_186__i0 (.Q(count[0]), .D(n85), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFC scancnt__i1 (.Q(scancnt[1]), .D(n992), .CLK(clk_c), .CE(n4));   // display.v(19[10] 25[24])
    OR2 i1_adj_1 (.O(n49), .I0(n30), .I1(num2_c_1));
    OR2 i568 (.O(n7_adj_6), .I0(n626), .I1(num2_c_0));
    OR2 i576 (.O(n7), .I0(n634), .I1(num1_c_0));
    OR2 i1_adj_2 (.O(n40), .I0(num1_c_1), .I1(n3));
    OR2 i589 (.O(n14_adj_24), .I0(num4_c_2), .I1(num4_c_1));
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    AND2 i810 (.O(n867), .I0(n860), .I1(count[9]));
    AND2 i1143 (.O(n1199), .I0(n1198), .I1(LED_A_N_35));
    AND2 i803 (.O(n860), .I0(n853), .I1(count[8]));
    XOR2 i800 (.O(n62), .I0(n853), .I1(count[8]));
    AND2 i1239 (.O(n1295), .I0(n418), .I1(n1294));
    OBUF LED_VCC4_pad (.O(LED_VCC4), .I0(LED_VCC4_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i1_adj_3 (.O(n4_adj_25), .I0(count[4]), .I1(n825));
    XOR2 i807 (.O(n61), .I0(n860), .I1(count[9]));
    XOR2 i814 (.O(n60), .I0(n867), .I1(count[10]));
    XOR2 i821 (.O(n59), .I0(n874), .I1(count[11]));
    XOR2 i828 (.O(n58), .I0(n881), .I1(count[12]));
    XOR2 i765 (.O(n67), .I0(n818), .I1(count[3]));
    OBUF LED_VCC3_pad (.O(LED_VCC3), .I0(LED_VCC3_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFR count_186__i12 (.Q(count[12]), .D(n73), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    AND2 i1088 (.O(n1144), .I0(n1143), .I1(n1276));
    OBUF LED_VCC2_pad (.O(LED_VCC2), .I0(LED_VCC2_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND4 i1_adj_4 (.O(n51), .I0(n1094), .I1(n9), .I2(n50), .I3(n1102));
    AND2 i580 (.O(n6_adj_22), .I0(num4_c_1), .I1(num4_c_0));
    AND2 i1236 (.O(n1292), .I0(n421), .I1(n3_adj_23));
    AND2 i1_adj_5 (.O(n80), .I0(n65), .I1(n25));
    OR2 i579 (.O(n3_adj_21), .I0(num4_c_1), .I1(num4_c_0));
    OR2 i546 (.O(LED_E_N_75), .I0(n604), .I1(num3_c_0));
    AND2 i1233 (.O(n1289), .I0(n418), .I1(n7_adj_19));
    AND2 i574 (.O(n6), .I0(n600), .I1(n5));
    AND4 i1_adj_6 (.O(n4), .I0(n50), .I1(n1094), .I2(n749), .I3(reset_c));
    AND2 i1201 (.O(n1257), .I0(num2_c_3), .I1(n14_adj_9));
    AND4 i1101 (.O(n1157), .I0(n3_adj_23), .I1(n412), .I2(n1156), .I3(n418));
    OBUF LED_VCC1_pad (.O(LED_VCC1), .I0(n220));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFCR LED_VCC2_116 (.Q(LED_VCC2_c), .D(LED_VCC2_N_100), .CLK(clk_c), 
          .CE(pwr), .R(reset_c));   // display.v(36[10] 343[12])
    OR2 i552 (.O(n7_adj_19), .I0(n610), .I1(num4_c_0));
    OBUF LED_G_pad (.O(LED_G), .I0(LED_G_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i1202 (.O(LED_G_N_92), .I0(n1257), .I1(n1256));
    AND2 i1102 (.O(n1158), .I0(LED_VCC2_N_100), .I1(LED_A_N_40));
    OR2 i1103 (.O(LED_A_N_36), .I0(n1158), .I1(n1157));
    XOR2 i251 (.O(n6_adj_18), .I0(num4_c_1), .I1(num4_c_0));
    OBUF LED_F_pad (.O(LED_F), .I0(LED_F_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i346 (.O(n406), .I0(n403), .I1(num3_c_1));
    AND2 i1230 (.O(n1286), .I0(n421), .I1(n4_adj_1));
    XOR2 i354 (.O(n412), .I0(num4_c_2), .I1(num4_c_0));
    XOR2 i357 (.O(n401), .I0(num3_c_2), .I1(num3_c_0));
    AND2 i1072 (.O(LED_VCC2_N_100), .I0(scancnt[1]), .I1(n1127));
    AND2 i761 (.O(n818), .I0(n811), .I1(count[2]));
    AND2 i1105 (.O(n1161), .I0(LED_VCC2_N_100), .I1(LED_B_N_51));
    AND2 i1227 (.O(n1283), .I0(n1143), .I1(n406));
    OBUF LED_E_pad (.O(LED_E), .I0(LED_E_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i1204 (.O(n1260), .I0(num3_c_3), .I1(n14_adj_12));
    AND2 i1224 (.O(n1280), .I0(n1143), .I1(n1279));
    XOR2 i364 (.O(n386), .I0(num2_c_2), .I1(num2_c_0));
    AND3 i796 (.O(n853), .I0(n839), .I1(count[6]), .I2(count[7]));
    OR2 i367 (.O(n427), .I0(n421), .I1(num4_c_1));
    OR2 i553 (.O(n14_adj_12), .I0(num3_c_2), .I1(num3_c_1));
    XOR2 i369 (.O(n371), .I0(num1_c_2), .I1(num1_c_0));
    OBUF LED_D_pad (.O(LED_D), .I0(LED_D_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i1221 (.O(n1277), .I0(n403), .I1(n3_adj_15));
    AND2 i548 (.O(n6_adj_14), .I0(num3_c_1), .I1(num3_c_0));
    OR2 i547 (.O(n3_adj_13), .I0(num3_c_1), .I1(num3_c_0));
    OR2 i1205 (.O(LED_A_N_40), .I0(n1260), .I1(n1259));
    AND2 i1218 (.O(n1274), .I0(n403), .I1(n3_adj_13));
    INV i1060 (.O(n5_adj_20), .I0(n1115));
    AND2 i1207 (.O(n1263), .I0(num3_c_3), .I1(n14_adj_12));
    OR2 i1208 (.O(LED_B_N_51), .I0(n1263), .I1(n1262));
    AND2 i1210 (.O(n1266), .I0(num3_c_3), .I1(n14_adj_12));
    OR2 i1125 (.O(LED_B_N_47), .I0(n1180), .I1(n1179));
    AND2 i1215 (.O(n1271), .I0(n1143), .I1(n1270));
    AND2 i1127 (.O(n1183), .I0(LED_VCC3_N_103), .I1(LED_C_N_60));
    AND3 i1212 (.O(n1268), .I0(n3_adj_15), .I1(n403), .I2(num3_c_0));
    OBUF LED_C_pad (.O(LED_C), .I0(LED_C_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i1211 (.O(LED_C_N_59), .I0(n1266), .I1(n1265));
    INV i30 (.O(n30), .I0(num2_c_2));
    AND2 i1213 (.O(n1269), .I0(num3_c_2), .I1(n353));
    IBUF num4_pad_0 (.O(num4_c_0), .I0(num4[0]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    AND3 i1209 (.O(n1265), .I0(n10_adj_16), .I1(n1143), .I2(n403));
    INV i1100 (.O(n1156), .I0(LED_VCC2_N_100));
    INV i1087 (.O(n1143), .I0(num3_c_3));
    XOR2 i242 (.O(n6_adj_10), .I0(num3_c_1), .I1(num3_c_0));
    OR2 i1214 (.O(n1270), .I0(n1269), .I1(n1268));
    AND3 i1206 (.O(n1262), .I0(num3_c_2), .I1(n1143), .I2(n6_adj_10));
    AND2 i1216 (.O(n1272), .I0(num3_c_3), .I1(n14_adj_12));
    OR2 i1217 (.O(LED_D_N_67), .I0(n1272), .I1(n1271));
    DFFR count_186__i11 (.Q(count[11]), .D(n74), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i10 (.Q(count[10]), .D(n75), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i9 (.Q(count[9]), .D(n76), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i8 (.Q(count[8]), .D(n77), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i7 (.Q(count[7]), .D(n1197), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i6 (.Q(count[6]), .D(n79), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i5 (.Q(count[5]), .D(n80), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i4 (.Q(count[4]), .D(n81), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i3 (.Q(count[3]), .D(n82), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i2 (.Q(count[2]), .D(n1301), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i1 (.Q(count[1]), .D(n1062), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    IBUF reset_pad (.O(reset_c), .I0(reset));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num4_pad_1 (.O(num4_c_1), .I0(num4[1]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num4_pad_2 (.O(num4_c_2), .I0(num4[2]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num4_pad_3 (.O(num4_c_3), .I0(num4[3]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num3_pad_0 (.O(num3_c_0), .I0(num3[0]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num3_pad_1 (.O(num3_c_1), .I0(num3[1]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num3_pad_2 (.O(num3_c_2), .I0(num3[2]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num3_pad_3 (.O(num3_c_3), .I0(num3[3]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num2_pad_0 (.O(num2_c_0), .I0(num2[0]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num2_pad_1 (.O(num2_c_1), .I0(num2[1]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num2_pad_2 (.O(num2_c_2), .I0(num2[2]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num2_pad_3 (.O(num2_c_3), .I0(num2[3]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num1_pad_0 (.O(num1_c_0), .I0(num1[0]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num1_pad_1 (.O(num1_c_1), .I0(num1[1]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OBUF LED_B_pad (.O(LED_B), .I0(LED_B_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF LED_A_pad (.O(LED_A), .I0(LED_A_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    IBUF num1_pad_2 (.O(num1_c_2), .I0(num1[2]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF num1_pad_3 (.O(num1_c_3), .I0(num1[3]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    AND2 i1219 (.O(n1275), .I0(num3_c_2), .I1(n6_adj_14));
    AND3 i1203 (.O(n1259), .I0(n3_adj_15), .I1(n1143), .I2(n401));
    OR2 i1220 (.O(n1276), .I0(n1275), .I1(n1274));
    AND2 i1200 (.O(n1256), .I0(n25_adj_2), .I1(n1255));
    AND2 i1222 (.O(n1278), .I0(num3_c_2), .I1(n6_adj_14));
    OR2 i538 (.O(n14_adj_9), .I0(num2_c_2), .I1(num2_c_1));
    OR2 i1223 (.O(n1279), .I0(n1278), .I1(n1277));
    AND2 i1225 (.O(n1281), .I0(num3_c_3), .I1(n14_adj_17));
    AND2 i1197 (.O(n1253), .I0(n30), .I1(n3_adj_8));
    OR2 i1226 (.O(LED_G_N_91), .I0(n1281), .I1(n1280));
    XOR2 i237 (.O(n10_adj_7), .I0(num2_c_1), .I1(num2_c_0));
    AND2 i1228 (.O(n1284), .I0(num3_c_3), .I1(n410));
    AND2 i1194 (.O(n1250), .I0(n25_adj_2), .I1(n7_adj_6));
    OR2 i1229 (.O(n1285), .I0(n1284), .I1(n1283));
    AND2 i1191 (.O(n1247), .I0(n25_adj_2), .I1(n1246));
    AND2 i817 (.O(n874), .I0(n867), .I1(count[10]));
    AND3 i1188 (.O(n1244), .I0(n3_adj_8), .I1(n30), .I2(num2_c_0));
    AND2 i1231 (.O(n1287), .I0(num4_c_2), .I1(n355));
    AND2 i768 (.O(n825), .I0(n818), .I1(count[3]));
    AND2 i824 (.O(n881), .I0(n874), .I1(count[11]));
    OR2 i1232 (.O(n1288), .I0(n1287), .I1(n1286));
    AND3 i1234 (.O(n1290), .I0(n4_adj_1), .I1(num4_c_3), .I2(n421));
    AND3 i1185 (.O(n1241), .I0(num2_c_2), .I1(n25_adj_2), .I2(n10_adj_7));
    AND2 i1077 (.O(LED_VCC3_N_103), .I0(n1132), .I1(scancnt[0]));
    AND2 i754 (.O(n811), .I0(count[0]), .I1(count[1]));
    XOR2 i772 (.O(n66), .I0(n825), .I1(count[4]));
    XOR2 i779 (.O(n65), .I0(n4_adj_25), .I1(count[5]));
    OR2 i1235 (.O(LED_E_N_74), .I0(n1290), .I1(n1289));
    AND2 i1237 (.O(n1293), .I0(num4_c_2), .I1(n6_adj_22));
    AND3 i1182 (.O(n1238), .I0(n3_adj_8), .I1(n25_adj_2), .I2(n386));
    OR2 i1238 (.O(n1294), .I0(n1293), .I1(n1292));
    AND2 i1240 (.O(n1296), .I0(num4_c_3), .I1(n14_adj_24));
    AND2 i1179 (.O(n1235), .I0(n2_adj_3), .I1(n1234));
    OR2 i1241 (.O(LED_G_N_90), .I0(n1296), .I1(n1295));
    AND2 i1243 (.O(n1299), .I0(n1298), .I1(n811));
    OR2 i532 (.O(n14), .I0(num1_c_2), .I1(num1_c_1));
    AND2 i1176 (.O(n1232), .I0(n3), .I1(n3_adj_4));
    XOR2 i224 (.O(n10), .I0(num1_c_1), .I1(num1_c_0));
    AND2 i1244 (.O(n1300), .I0(count[2]), .I1(n8));
    OR2 i1128 (.O(LED_C_N_55), .I0(n1183), .I1(n1182));
    OR2 i1245 (.O(n1301), .I0(n1300), .I1(n1299));
    AND2 i1_adj_7 (.O(n4_adj_1), .I0(n3_adj_23), .I1(num4_c_0));
    AND2 i1173 (.O(n1229), .I0(n2_adj_3), .I1(n7));
    AND2 i1130 (.O(n1186), .I0(LED_VCC3_N_103), .I1(LED_D_N_68));
    AND2 i1_adj_8 (.O(LED_C_N_61), .I0(n1104), .I1(n2));
    INV i1070 (.O(n8), .I0(n811));
    INV i1068 (.O(n1101), .I0(n1123));
    INV i289 (.O(n349), .I0(n10));
    INV i291 (.O(n351), .I0(n10_adj_7));
    AND2 i1170 (.O(n1226), .I0(n2_adj_3), .I1(n1225));
    OR2 i1131 (.O(LED_D_N_63), .I0(n1186), .I1(n1185));
    AND2 i1133 (.O(n1189), .I0(LED_VCC3_N_103), .I1(LED_E_N_76));
    INV i545 (.O(n604), .I0(n1285));
    AND3 i1167 (.O(n1223), .I0(n3_adj_4), .I1(n3), .I2(num1_c_0));
    INV i293 (.O(n353), .I0(n6_adj_10));
    INV i295 (.O(n355), .I0(n6_adj_18));
    AND2 i1089 (.O(n1145), .I0(num3_c_3), .I1(n14_adj_12));
    AND2 i1_adj_9 (.O(n1108), .I0(n30), .I1(num2_c_1));
    AND3 i1164 (.O(n1220), .I0(num1_c_2), .I1(n2_adj_3), .I2(n10));
    OR2 i1134 (.O(LED_E_N_71), .I0(n1189), .I1(n1188));
    AND2 i1_adj_10 (.O(LED_C_N_60), .I0(n1108), .I1(n2_adj_5));
    AND2 i1136 (.O(n1192), .I0(LED_VCC3_N_103), .I1(LED_G_N_92));
    OR2 i1080 (.O(LED_F_N_78), .I0(n1135), .I1(n1134));
    INV i1242 (.O(n1298), .I0(count[2]));
    AND2 i1082 (.O(n1138), .I0(num4_c_2), .I1(n6_adj_22));
    OR2 i1083 (.O(n1139), .I0(n1138), .I1(n1137));
    AND2 i1078 (.O(n1134), .I0(n1129), .I1(n1152));
    OR2 i1137 (.O(LED_G_N_87), .I0(n1192), .I1(n1191));
    AND3 i1139 (.O(n1195), .I0(n4_adj_25), .I1(n1194), .I2(n1110));
    AND2 i1140 (.O(n1196), .I0(count[7]), .I1(n1101));
    XOR2 i296 (.O(n5), .I0(n4), .I1(scancnt[0]));
    INV i1066 (.O(n1102), .I0(n1121));
    INV i255 (.O(n3_adj_23), .I0(num4_c_1));
    INV i1071 (.O(n1127), .I0(scancnt[0]));
    INV i575 (.O(n634), .I0(n40));
    VCC i836 (.X(pwr));
    AND2 i557 (.O(n10_adj_16), .I0(num3_c_1), .I1(n2_adj_11));
    INV i1076 (.O(n1132), .I0(scancnt[1]));
    OR2 i1141 (.O(n1197), .I0(n1196), .I1(n1195));
    INV i567 (.O(n626), .I0(n49));
    OR2 i560 (.O(n14_adj_17), .I0(num3_c_2), .I1(n10_adj_16));
    INV i358 (.O(n418), .I0(num4_c_3));
    INV i350 (.O(n410), .I0(n14_adj_12));
    INV i361 (.O(n421), .I0(num4_c_2));
    AND3 i1085 (.O(n1141), .I0(n49), .I1(num2_c_0), .I2(n25_adj_2));
    INV i246 (.O(n3_adj_15), .I0(num3_c_1));
    INV i551 (.O(n610), .I0(n427));
    OR2 i1090 (.O(n1146), .I0(n1145), .I1(n1144));
    INV i541 (.O(n600), .I0(n281));
    GND i1 (.X(n220));
    AND3 i196 (.O(n281), .I0(scancnt[1]), .I1(scancnt[0]), .I2(n4));
    AND3 i1092 (.O(n1148), .I0(n40), .I1(num1_c_0), .I2(n2_adj_3));
    INV i243 (.O(n2_adj_11), .I0(num3_c_0));
    AND2 i1_adj_11 (.O(n74), .I0(n59), .I1(n25));
    AND2 i1_adj_12 (.O(n73), .I0(n58), .I1(n25));
    AND2 i1_adj_13 (.O(n79), .I0(n64), .I1(n25));
    OR2 i1093 (.O(n1149), .I0(n1148), .I1(n1147));
    AND2 i1_adj_14 (.O(n76), .I0(n61), .I1(n25));
    AND2 i1095 (.O(n1151), .I0(scancnt[1]), .I1(n1146));
    AND2 i1_adj_15 (.O(n82), .I0(n67), .I1(n25));
    INV i343 (.O(n403), .I0(num3_c_2));
    INV i239 (.O(n3_adj_8), .I0(num2_c_1));
    INV i238 (.O(n2_adj_5), .I0(num2_c_0));
    INV i226 (.O(n3_adj_4), .I0(num1_c_1));
    AND2 i1_adj_16 (.O(n1104), .I0(n3), .I1(num1_c_1));
    OR2 i1086 (.O(n1142), .I0(n1141), .I1(n1140));
    OR2 i1099 (.O(n1155), .I0(n1154), .I1(n1153));
    INV i225 (.O(n2), .I0(num1_c_0));
    AND3 i1161 (.O(n1217), .I0(n3_adj_4), .I1(n2_adj_3), .I2(n371));
    INV i55 (.O(n25), .I0(n51));
    INV i1073 (.O(n1129), .I0(scancnt[0]));
    INV i28 (.O(n749), .I0(n901));
    INV i2 (.O(n2_adj_3), .I0(num1_c_3));
    AND2 i1158 (.O(n1214), .I0(n1198), .I1(LED_G_N_87));
    AND2 i1155 (.O(n1211), .I0(n1198), .I1(LED_E_N_71));
    AND2 i1152 (.O(n1208), .I0(n1198), .I1(LED_D_N_63));
    INV i1074 (.O(n1130), .I0(scancnt[1]));
    AND2 i1149 (.O(n1205), .I0(n1198), .I1(LED_C_N_55));
    AND2 i1146 (.O(n1202), .I0(n1198), .I1(LED_B_N_47));
    AND2 i1_adj_17 (.O(n77), .I0(n62), .I1(n25));
    AND2 i1135 (.O(n1191), .I0(n1175), .I1(LED_G_N_88));
    AND2 i1132 (.O(n1188), .I0(n1175), .I1(LED_E_N_72));
    AND2 i1129 (.O(n1185), .I0(n1175), .I1(LED_D_N_64));
    AND2 i1126 (.O(n1182), .I0(n1175), .I1(LED_C_N_56));
    AND2 i1123 (.O(n1179), .I0(n1175), .I1(LED_B_N_48));
    OR2 i1059 (.O(n1115), .I0(num4_c_2), .I1(num4_c_0));
    XOR2 i15 (.O(n1062), .I0(count[1]), .I1(count[0]));
    OR2 i1106 (.O(LED_B_N_48), .I0(n1161), .I1(n1160));
    AND3 i1067 (.O(n1123), .I0(n1110), .I1(n825), .I2(count[4]));
    AND2 i1075 (.O(LED_VCC4_N_106), .I0(n1130), .I1(n1129));
    XOR2 i786 (.O(n64), .I0(n839), .I1(count[6]));
    INV i9 (.O(n9), .I0(count[4]));
    AND2 i1116 (.O(n1172), .I0(n1156), .I1(LED_G_N_90));
    AND2 i1113 (.O(n1169), .I0(n1156), .I1(LED_E_N_74));
    AND2 i1144 (.O(n1200), .I0(LED_VCC4_N_106), .I1(LED_A_N_44));
    AND3 i1110 (.O(n1166), .I0(n418), .I1(n1156), .I2(n1288));
    AND4 i1107 (.O(n1163), .I0(n418), .I1(num4_c_1), .I2(n1156), .I3(n5_adj_20));
    OR2 i1145 (.O(LED_A_N_34), .I0(n1200), .I1(n1199));
    AND2 i1147 (.O(n1203), .I0(LED_VCC4_N_106), .I1(LED_B_N_53));
    AND4 i1104 (.O(n1160), .I0(num4_c_2), .I1(n6_adj_18), .I2(n1156), 
         .I3(n418));
    AND2 i1_adj_18 (.O(n81), .I0(n66), .I1(n25));
    OR2 i1148 (.O(LED_B_N_46), .I0(n1203), .I1(n1202));
    AND2 i1_adj_19 (.O(n75), .I0(n60), .I1(n25));
    OR2 i1096 (.O(n1152), .I0(n1151), .I1(n1150));
    AND2 i1150 (.O(n1206), .I0(LED_VCC4_N_106), .I1(LED_C_N_61));
    OR2 i1151 (.O(LED_C_N_54), .I0(n1206), .I1(n1205));
    INV i835 (.O(n85), .I0(count[0]));
    INV i1142 (.O(n1198), .I0(LED_VCC4_N_106));
    INV i1138 (.O(n1194), .I0(count[7]));
    AND2 i1079 (.O(n1135), .I0(scancnt[0]), .I1(n1155));
    INV i1119 (.O(n1175), .I0(LED_VCC3_N_103));
    AND2 i1153 (.O(n1209), .I0(LED_VCC4_N_106), .I1(LED_D_N_69));
    OR2 i1154 (.O(LED_D_N_62), .I0(n1209), .I1(n1208));
    AND2 i1_adj_20 (.O(n50), .I0(count[3]), .I1(count[12]));
    OR2 i1065 (.O(n1121), .I0(count[7]), .I1(count[11]));
    AND2 i1156 (.O(n1212), .I0(LED_VCC4_N_106), .I1(LED_E_N_77));
    OR2 i1157 (.O(LED_E_N_70), .I0(n1212), .I1(n1211));
    AND2 i1159 (.O(n1215), .I0(LED_VCC4_N_106), .I1(LED_G_N_93));
    OR2 i1160 (.O(LED_G_N_86), .I0(n1215), .I1(n1214));
    AND2 i1162 (.O(n1218), .I0(num1_c_3), .I1(LED_C_N_61));
    OR2 i1163 (.O(LED_A_N_44), .I0(n1218), .I1(n1217));
    AND2 i1165 (.O(n1221), .I0(num1_c_3), .I1(LED_C_N_61));
    OR2 i1166 (.O(LED_B_N_53), .I0(n1221), .I1(n1220));
    AND6 i5 (.O(n1094), .I0(count[8]), .I1(count[10]), .I2(count[9]), 
         .I3(n811), .I4(count[2]), .I5(n1110));
    AND2 i1168 (.O(n1224), .I0(num1_c_2), .I1(n349));
    OR2 i1169 (.O(n1225), .I0(n1224), .I1(n1223));
    OR2 i2_adj_21 (.O(n901), .I0(n1121), .I1(count[4]));
    AND2 i1_adj_22 (.O(n1110), .I0(count[5]), .I1(count[6]));
    AND2 i1108 (.O(n1164), .I0(LED_VCC2_N_100), .I1(LED_C_N_59));
    OR2 i1109 (.O(LED_C_N_56), .I0(n1164), .I1(n1163));
    XOR2 i15_adj_23 (.O(n992), .I0(scancnt[0]), .I1(scancnt[1]));
    AND2 i1171 (.O(n1227), .I0(num1_c_3), .I1(LED_C_N_61));
    OR2 i1172 (.O(LED_D_N_69), .I0(n1227), .I1(n1226));
    AND3 i1174 (.O(n1230), .I0(n3), .I1(num1_c_3), .I2(n10));
    OR2 i1175 (.O(LED_E_N_77), .I0(n1230), .I1(n1229));
    AND3 i1177 (.O(n1233), .I0(num1_c_1), .I1(num1_c_2), .I2(num1_c_0));
    AND2 i1111 (.O(n1167), .I0(LED_VCC2_N_100), .I1(LED_D_N_67));
    OR2 i1178 (.O(n1234), .I0(n1233), .I1(n1232));
    OR2 i1112 (.O(LED_D_N_64), .I0(n1167), .I1(n1166));
    AND2 i1097 (.O(n1153), .I0(n1130), .I1(n1142));
    AND2 i1180 (.O(n1236), .I0(num1_c_3), .I1(n14));
    OR2 i1181 (.O(LED_G_N_93), .I0(n1236), .I1(n1235));
    AND2 i1183 (.O(n1239), .I0(num2_c_3), .I1(LED_C_N_60));
    OR2 i1184 (.O(LED_A_N_42), .I0(n1239), .I1(n1238));
    AND2 i1186 (.O(n1242), .I0(num2_c_3), .I1(LED_C_N_60));
    AND2 i1114 (.O(n1170), .I0(LED_VCC2_N_100), .I1(LED_E_N_75));
    OR2 i1115 (.O(LED_E_N_72), .I0(n1170), .I1(n1169));
    INV i3 (.O(n3), .I0(num1_c_2));
    AND2 i1094 (.O(n1150), .I0(n1130), .I1(n1149));
    AND2 i1091 (.O(n1147), .I0(n2), .I1(n1104));
    OR2 i1187 (.O(LED_B_N_52), .I0(n1242), .I1(n1241));
    AND2 i1189 (.O(n1245), .I0(num2_c_2), .I1(n351));
    OR2 i1190 (.O(n1246), .I0(n1245), .I1(n1244));
    AND2 i1117 (.O(n1173), .I0(LED_VCC2_N_100), .I1(LED_G_N_91));
    OR2 i1118 (.O(LED_G_N_88), .I0(n1173), .I1(n1172));
    AND2 i1192 (.O(n1248), .I0(num2_c_3), .I1(LED_C_N_60));
    INV i25 (.O(n25_adj_2), .I0(num2_c_3));
    
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
// Verilog Description of module OR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module XOR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND4
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

//
// Verilog Description of module AND6
// module not written out since it is a black-box. 
//

