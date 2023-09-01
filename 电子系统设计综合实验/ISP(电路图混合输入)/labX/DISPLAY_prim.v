// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Fri Jun 09 10:00:06 2023
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
    
    wire n229, pwr, reset_c, num1_c_3, num1_c_2, num1_c_1, num1_c_0, 
        num2_c_3, num2_c_2, num2_c_1, num2_c_0, num3_c_3, num3_c_2, 
        num3_c_1, num3_c_0, num4_c_3, num4_c_2, num4_c_1, num4_c_0, 
        LED_A_c, LED_B_c, LED_C_c, LED_D_c, LED_E_c, LED_F_c, LED_G_c, 
        LED_VCC3_c, LED_VCC4_c;
    wire [1:0]scancnt;   // display.v(11[11:18])
    wire [15:0]count;   // display.v(12[12:17])
    
    wire n1198, n817, n8, n1196, n601, n1194, n1193, n1191, 
        n1043, n6, n5, n689, n293, LED_A_N_50, LED_B_N_59, LED_C_N_67, 
        LED_D_N_75, LED_E_N_83, LED_G_N_99, n1190, LED_A_N_48, LED_B_N_58, 
        LED_C_N_66, LED_D_N_74, LED_E_N_82, LED_G_N_98, LED_A_N_47, 
        LED_A_N_46, LED_B_N_57, LED_C_N_65, LED_D_N_73, LED_E_N_81, 
        LED_G_N_97, LED_E_N_80, LED_G_N_96, n1054, n5_adj_1, LED_A_N_42, 
        LED_B_N_54, LED_C_N_62, LED_D_N_70, LED_E_N_78, LED_G_N_94, 
        n1165, n1032, n810, LED_A_N_41, LED_B_N_53, LED_C_N_61, 
        LED_D_N_69, LED_E_N_77, LED_G_N_93, n1174, n1171, LED_VCC3_N_109, 
        LED_A_N_40, LED_B_N_52, LED_C_N_60, LED_D_N_68, LED_E_N_76, 
        LED_F_N_84, LED_G_N_92, n7, n1168, LED_VCC4_N_112, n1189, 
        n803, n1187, n1028, n31, n1045, n1049, n2, n3, n30, 
        n1177, n25, n1036, n386, n1185, n1034, n390, n1184, 
        n1092, n70, n71, n72, n73, n74, n75, n76, n77, n78, 
        n79, n80, n81, n82, n83, n84, n85, n88, n89, n90, 
        n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, 
        n101, n102, n103, n1182, n360, n362, n364, n366, n1180, 
        n40, n1020, n1181, n2_adj_2, n49, n1179, n1178, n1176, 
        n1175, n1173, n1172, n845, n2_adj_3, n1170, n775, n1110, 
        n1090, n1089, n7_adj_4, n1169, n10, n1167, n1166, n3_adj_5, 
        n1119, n1164, n1163, n1087, n14, n1086, n1024, n1162, 
        n768, n1160, n761, n2_adj_6, n1159, n1131, n1157, n796, 
        n1155, n1154, n1084, n7_adj_7, n10_adj_8, n1153, n1052, 
        n789, n3_adj_9, n1051, n1140, n14_adj_10, n1151, n420, 
        n589, n1150, n6_adj_11, n2_adj_12, n1148, n14_adj_13, n1156, 
        n1083, n838, n1147, n831, n3_adj_14, n6_adj_15, n1183, 
        n583, n3_adj_16, n581, n1186, n1145, n607, n1057, n1082, 
        n14_adj_17, n1144, n1080, n824, n1143, n1141, n1139, n1079, 
        n4, n1138, n4_adj_18, n6_adj_19, n1137, n1077, n1076, 
        n1135, n1074, n1048, n1046, n1134, n1073, n444, n1071, 
        n1132, n1130, n437, n1058, n1195, n434, n429, n1192, 
        n427, n1040, n1129, n1128, n423, n1070, n754, n7_adj_20, 
        n1126, n418, n1125, n1123, n1122, n4_adj_21, n3_adj_22, 
        n1060, n1120, n6_adj_23, n1068, n1041, n1067, n3_adj_24, 
        n403, n1065, n1201, n1022, n782, n1061, n14_adj_25, n1118, 
        n1117, n1064, n1063, n1116, n1026, n1114, n1113, n1111, 
        n1109, n10_adj_26, n1108, n1107, n1105, n1104, n1102, 
        n1101, n1099, n1098, n1096, n1095, n1093, n944, n1202, 
        n1200, n1199, n1055;
    
    OR2 i985 (.O(LED_C_N_62), .I0(n1052), .I1(n1051));
    AND2 i1094 (.O(n1162), .I0(n437), .I1(n3_adj_22));
    AND2 i1091 (.O(n1159), .I0(n1143), .I1(n1155));
    OR2 i1_adj_1 (.O(n49), .I0(n30), .I1(num2_c_1));
    OR2 i1001 (.O(LED_B_N_53), .I0(n1068), .I1(n1067));
    AND2 i1088 (.O(n1156), .I0(n1040), .I1(n1176));
    OR2 i1_adj_2 (.O(n40), .I0(num1_c_1), .I1(n390));
    DFFCS LED_C_110 (.Q(LED_C_c), .D(LED_C_N_60), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    DFFCS LED_D_111 (.Q(LED_D_c), .D(LED_D_N_68), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    DFFCS LED_E_112 (.Q(LED_E_c), .D(LED_E_N_76), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    DFFCS LED_F_113 (.Q(LED_F_c), .D(LED_F_N_84), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    DFFCS LED_G_114 (.Q(LED_G_c), .D(LED_G_N_92), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    DFFCR LED_VCC3_117 (.Q(LED_VCC3_c), .D(LED_VCC3_N_109), .CLK(clk_c), 
          .CE(pwr), .R(reset_c));   // display.v(36[10] 343[12])
    DFFCR LED_VCC4_118 (.Q(LED_VCC4_c), .D(LED_VCC4_N_112), .CLK(clk_c), 
          .CE(pwr), .R(reset_c));   // display.v(36[10] 343[12])
    DFFCS LED_A_108 (.Q(LED_A_c), .D(LED_A_N_40), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    DFF scancnt__i0 (.Q(scancnt[0]), .D(n6), .CLK(clk_c));   // display.v(19[10] 25[24])
    AND3 i1085 (.O(n1153), .I0(n3_adj_16), .I1(n420), .I2(num3_c_0));
    DFFR count_186__i0 (.Q(count[0]), .D(n103), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    AND2 i1080 (.O(n1148), .I0(num3_c_3), .I1(n14_adj_13));
    AND3 i1_adj_3 (.O(n1026), .I0(count[2]), .I1(n7), .I2(count[8]));
    OR2 i1081 (.O(LED_B_N_57), .I0(n1148), .I1(n1147));
    DFFC scancnt__i1 (.Q(scancnt[1]), .D(n944), .CLK(clk_c), .CE(n8));   // display.v(19[10] 25[24])
    AND2 i1083 (.O(n1151), .I0(num3_c_3), .I1(n14_adj_13));
    AND2 i1003 (.O(n1071), .I0(LED_VCC3_N_109), .I1(LED_C_N_66));
    AND2 i776 (.O(n845), .I0(n838), .I1(count[14]));
    OR2 i1084 (.O(LED_C_N_65), .I0(n1151), .I1(n1150));
    AND3 i1082 (.O(n1150), .I0(n4), .I1(n1143), .I2(n420));
    AND2 i1086 (.O(n1154), .I0(num3_c_2), .I1(n364));
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OR2 i1087 (.O(n1155), .I0(n1154), .I1(n1153));
    AND2 i713 (.O(n782), .I0(n775), .I1(count[5]));
    AND2 i1_adj_4 (.O(n1028), .I0(n390), .I1(num1_c_1));
    OBUF LED_VCC4_pad (.O(LED_VCC4), .I0(LED_VCC4_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    XOR2 i241 (.O(n6_adj_11), .I0(num3_c_1), .I1(num3_c_0));
    AND3 i1079 (.O(n1147), .I0(num3_c_2), .I1(n1143), .I2(n6_adj_11));
    OR2 i1004 (.O(LED_C_N_61), .I0(n1071), .I1(n1070));
    AND2 i1006 (.O(n1074), .I0(LED_VCC3_N_109), .I1(LED_D_N_74));
    OBUF LED_VCC3_pad (.O(LED_VCC3), .I0(LED_VCC3_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFR count_186__i15 (.Q(count[15]), .D(n88), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    OR2 i1007 (.O(LED_D_N_69), .I0(n1074), .I1(n1073));
    AND2 i1072 (.O(n1140), .I0(n25), .I1(n1139));
    AND2 i1089 (.O(n1157), .I0(scancnt[0]), .I1(n1179));
    OBUF LED_VCC2_pad (.O(LED_VCC2), .I0(n229));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i500 (.O(n14_adj_10), .I0(num2_c_2), .I1(num2_c_1));
    AND2 i1069 (.O(n1137), .I0(n30), .I1(n3_adj_9));
    XOR2 i236 (.O(n10_adj_8), .I0(num2_c_1), .I1(num2_c_0));
    AND2 i1009 (.O(n1077), .I0(LED_VCC3_N_109), .I1(LED_E_N_82));
    AND2 i1_adj_5 (.O(LED_C_N_67), .I0(n1028), .I1(n2_adj_3));
    AND2 i1066 (.O(n1134), .I0(n25), .I1(n7_adj_7));
    OR2 i1090 (.O(LED_F_N_84), .I0(n1157), .I1(n1156));
    AND2 i1092 (.O(n1160), .I0(num3_c_3), .I1(n14_adj_13));
    AND2 i727 (.O(n796), .I0(n789), .I1(count[7]));
    AND2 i1063 (.O(n1131), .I0(n25), .I1(n1130));
    AND3 i1060 (.O(n1128), .I0(n3_adj_9), .I1(n30), .I2(num2_c_0));
    AND2 i987 (.O(n1055), .I0(LED_A_N_47), .I1(LED_D_N_73));
    AND2 i1131 (.O(n1199), .I0(num4_c_2), .I1(n6_adj_23));
    OR2 i1132 (.O(n1200), .I0(n1199), .I1(n1198));
    AND2 i486 (.O(n103), .I0(n31), .I1(n85));
    AND2 i734 (.O(n803), .I0(n796), .I1(count[8]));
    OBUF LED_VCC1_pad (.O(LED_VCC1), .I0(n229));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND3 i1057 (.O(n1125), .I0(num2_c_2), .I1(n25), .I2(n10_adj_8));
    AND2 i1134 (.O(n1202), .I0(num4_c_3), .I1(n14_adj_25));
    OR2 i1010 (.O(LED_E_N_77), .I0(n1077), .I1(n1076));
    OR2 i1135 (.O(LED_G_N_96), .I0(n1202), .I1(n1201));
    XOR2 i15 (.O(n944), .I0(scancnt[0]), .I1(scancnt[1]));
    INV i13 (.O(n7), .I0(n689));
    OBUF LED_G_pad (.O(LED_G), .I0(LED_G_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND4 i3 (.O(n8), .I0(n1026), .I1(n1020), .I2(n1024), .I3(reset_c));
    AND3 i1054 (.O(n1122), .I0(n3_adj_9), .I1(n25), .I2(n403));
    AND2 i1051 (.O(n1119), .I0(n2_adj_2), .I1(n1118));
    OR2 i1093 (.O(LED_D_N_73), .I0(n1160), .I1(n1159));
    AND2 i1025 (.O(n1093), .I0(LED_VCC4_N_112), .I1(LED_D_N_75));
    OBUF LED_F_pad (.O(LED_F), .I0(LED_F_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i1026 (.O(LED_D_N_68), .I0(n1093), .I1(n1092));
    AND2 i1095 (.O(n1163), .I0(num4_c_2), .I1(n6_adj_23));
    OR2 i1096 (.O(n1164), .I0(n1163), .I1(n1162));
    AND3 i1098 (.O(n1166), .I0(n49), .I1(num2_c_0), .I2(n25));
    AND2 i1028 (.O(n1096), .I0(LED_VCC4_N_112), .I1(LED_E_N_83));
    OR2 i1029 (.O(LED_E_N_76), .I0(n1096), .I1(n1095));
    AND2 i1031 (.O(n1099), .I0(LED_VCC4_N_112), .I1(LED_G_N_99));
    OR2 i1032 (.O(LED_G_N_92), .I0(n1099), .I1(n1098));
    OR2 i494 (.O(n14), .I0(num1_c_2), .I1(num1_c_1));
    AND2 i1048 (.O(n1116), .I0(n390), .I1(n3_adj_5));
    XOR2 i223 (.O(n10), .I0(num1_c_1), .I1(num1_c_0));
    AND2 i1034 (.O(n1102), .I0(num1_c_3), .I1(LED_C_N_67));
    OR2 i1035 (.O(LED_A_N_50), .I0(n1102), .I1(n1101));
    AND2 i1012 (.O(n1080), .I0(LED_VCC3_N_109), .I1(LED_G_N_98));
    AND2 i1045 (.O(n1113), .I0(n2_adj_2), .I1(n7_adj_4));
    OR2 i1013 (.O(LED_G_N_93), .I0(n1080), .I1(n1079));
    AND2 i741 (.O(n810), .I0(n803), .I1(count[9]));
    AND2 i1037 (.O(n1105), .I0(num1_c_3), .I1(LED_C_N_67));
    OR2 i1038 (.O(LED_B_N_59), .I0(n1105), .I1(n1104));
    AND2 i1042 (.O(n1110), .I0(n2_adj_2), .I1(n1109));
    OR2 i1099 (.O(n1167), .I0(n1166), .I1(n1165));
    AND2 i1040 (.O(n1108), .I0(num1_c_2), .I1(n360));
    OBUF LED_E_pad (.O(LED_E), .I0(LED_E_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND3 i1039 (.O(n1107), .I0(n3_adj_5), .I1(n390), .I2(num1_c_0));
    XOR2 i682 (.O(n84), .I0(count[0]), .I1(count[1]));
    AND3 i1036 (.O(n1104), .I0(num1_c_2), .I1(n2_adj_2), .I2(n10));
    AND2 i1101 (.O(n1169), .I0(num3_c_3), .I1(n14_adj_13));
    OR2 i1041 (.O(n1109), .I0(n1108), .I1(n1107));
    AND2 i1043 (.O(n1111), .I0(num1_c_3), .I1(LED_C_N_67));
    OBUF LED_D_pad (.O(LED_D), .I0(LED_D_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i1044 (.O(LED_D_N_75), .I0(n1111), .I1(n1110));
    AND2 i748 (.O(n817), .I0(n810), .I1(count[10]));
    OR2 equal_163_i3 (.O(n3), .I0(n2), .I1(scancnt[0]));
    AND3 i1046 (.O(n1114), .I0(n390), .I1(num1_c_3), .I2(n10));
    AND6 i6 (.O(n1020), .I0(count[1]), .I1(count[9]), .I2(n10_adj_26), 
         .I3(count[3]), .I4(count[14]), .I5(count[0]));
    OR2 i1047 (.O(LED_E_N_83), .I0(n1114), .I1(n1113));
    AND2 i978 (.O(n1046), .I0(LED_A_N_47), .I1(LED_A_N_46));
    INV i30 (.O(n30), .I0(num2_c_2));
    OR2 i979 (.O(LED_A_N_42), .I0(n1046), .I1(n1045));
    OR2 i994 (.O(LED_G_N_94), .I0(n1061), .I1(n1060));
    AND3 i1049 (.O(n1117), .I0(num1_c_1), .I1(num1_c_2), .I2(num1_c_0));
    OR2 i1102 (.O(n1170), .I0(n1169), .I1(n1168));
    AND2 i976 (.O(LED_VCC3_N_109), .I0(n1043), .I1(scancnt[0]));
    AND3 i1104 (.O(n1172), .I0(n40), .I1(num1_c_0), .I2(n2_adj_2));
    AND2 i996 (.O(n1064), .I0(n1063), .I1(LED_A_N_42));
    OBUF LED_C_pad (.O(LED_C), .I0(LED_C_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i1105 (.O(n1173), .I0(n1172), .I1(n1171));
    AND2 i1107 (.O(n1175), .I0(scancnt[1]), .I1(n1170));
    IBUF num4_pad_0 (.O(num4_c_0), .I0(num4[0]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OR2 i1050 (.O(n1118), .I0(n1117), .I1(n1116));
    XOR2 i295 (.O(n5), .I0(n8), .I1(scancnt[0]));
    INV i1014 (.O(n1082), .I0(LED_VCC4_N_112));
    INV i995 (.O(n1063), .I0(LED_VCC3_N_109));
    AND2 i1015 (.O(n1083), .I0(n1082), .I1(LED_A_N_41));
    AND2 i1052 (.O(n1120), .I0(num1_c_3), .I1(n14));
    OR2 i1053 (.O(LED_G_N_99), .I0(n1120), .I1(n1119));
    AND2 i1055 (.O(n1123), .I0(num2_c_3), .I1(LED_C_N_66));
    OR2 i1056 (.O(LED_A_N_48), .I0(n1123), .I1(n1122));
    AND2 i1016 (.O(n1084), .I0(LED_VCC4_N_112), .I1(LED_A_N_50));
    VCC i788 (.X(pwr));
    AND4 i977 (.O(n1045), .I0(n3_adj_24), .I1(n429), .I2(n3), .I3(n434));
    DFFR count_186__i14 (.Q(count[14]), .D(n89), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i13 (.Q(count[13]), .D(n90), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i12 (.Q(count[12]), .D(n91), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i11 (.Q(count[11]), .D(n92), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i10 (.Q(count[10]), .D(n93), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i9 (.Q(count[9]), .D(n94), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i8 (.Q(count[8]), .D(n95), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i7 (.Q(count[7]), .D(n96), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i6 (.Q(count[6]), .D(n97), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i5 (.Q(count[5]), .D(n98), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i4 (.Q(count[4]), .D(n99), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i3 (.Q(count[3]), .D(n100), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i2 (.Q(count[2]), .D(n101), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i1 (.Q(count[1]), .D(n102), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
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
    DFFCS LED_B_109 (.Q(LED_B_c), .D(LED_B_N_52), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    AND2 i1_adj_6 (.O(n1032), .I0(n30), .I1(num2_c_1));
    OR2 i1108 (.O(n1176), .I0(n1175), .I1(n1174));
    AND2 i997 (.O(n1065), .I0(LED_VCC3_N_109), .I1(LED_A_N_48));
    AND2 i1058 (.O(n1126), .I0(num2_c_3), .I1(LED_C_N_66));
    AND2 i3_adj_7 (.O(n10_adj_26), .I0(count[15]), .I1(count[6]));
    AND2 i720 (.O(n789), .I0(n782), .I1(count[6]));
    AND2 i981 (.O(n1049), .I0(LED_A_N_47), .I1(LED_B_N_57));
    AND3 i1110 (.O(n1178), .I0(n1164), .I1(scancnt[1]), .I2(n434));
    INV i288 (.O(n360), .I0(n10));
    OR2 i998 (.O(LED_A_N_41), .I0(n1065), .I1(n1064));
    OR2 i1059 (.O(LED_B_N_58), .I0(n1126), .I1(n1125));
    AND3 i196 (.O(n293), .I0(scancnt[1]), .I1(scancnt[0]), .I2(n8));
    INV i290 (.O(n362), .I0(n10_adj_8));
    AND2 i1061 (.O(n1129), .I0(num2_c_2), .I1(n362));
    INV i292 (.O(n364), .I0(n6_adj_11));
    AND2 i755 (.O(n824), .I0(n817), .I1(count[11]));
    XOR2 i703 (.O(n81), .I0(n768), .I1(count[4]));
    OR2 i1111 (.O(n1179), .I0(n1178), .I1(n1177));
    OR2 i518 (.O(n7_adj_20), .I0(n589), .I1(num4_c_0));
    OR2 i1062 (.O(n1130), .I0(n1129), .I1(n1128));
    AND2 i1064 (.O(n1132), .I0(num2_c_3), .I1(LED_C_N_66));
    AND2 i1_adj_8 (.O(LED_C_N_66), .I0(n1032), .I1(n2_adj_6));
    XOR2 i689 (.O(n83), .I0(n754), .I1(count[2]));
    XOR2 i717 (.O(n79), .I0(n782), .I1(count[6]));
    AND2 i984 (.O(n1052), .I0(LED_A_N_47), .I1(LED_C_N_65));
    INV i294 (.O(n366), .I0(n6_adj_19));
    AND2 i1113 (.O(n1181), .I0(num3_c_2), .I1(n6_adj_15));
    OR2 i530 (.O(n7_adj_7), .I0(n601), .I1(num2_c_0));
    XOR2 i724 (.O(n78), .I0(n789), .I1(count[7]));
    OR2 i1114 (.O(n1182), .I0(n1181), .I1(n1180));
    AND2 i1116 (.O(n1184), .I0(num3_c_2), .I1(n6_adj_15));
    XOR2 i376 (.O(n429), .I0(num4_c_2), .I1(num4_c_0));
    AND2 i706 (.O(n775), .I0(n768), .I1(count[4]));
    AND2 i561 (.O(n102), .I0(n31), .I1(n84));
    AND3 i1033 (.O(n1101), .I0(n3_adj_5), .I1(n2_adj_2), .I2(n386));
    AND2 i1030 (.O(n1098), .I0(n1082), .I1(LED_G_N_93));
    AND2 i1027 (.O(n1095), .I0(n1082), .I1(LED_E_N_77));
    AND2 i560 (.O(n101), .I0(n31), .I1(n83));
    AND2 i559 (.O(n100), .I0(n31), .I1(n82));
    AND2 i558 (.O(n99), .I0(n31), .I1(n81));
    AND2 i557 (.O(n98), .I0(n31), .I1(n80));
    AND2 i556 (.O(n97), .I0(n31), .I1(n79));
    INV i971 (.O(n1024), .I0(n4_adj_21));
    INV i254 (.O(n3_adj_24), .I0(num4_c_1));
    INV i2 (.O(n2_adj_2), .I0(num1_c_3));
    INV i969 (.O(n5_adj_1), .I0(n1036));
    AND2 i1024 (.O(n1092), .I0(n1082), .I1(LED_D_N_69));
    INV i25 (.O(n25), .I0(num2_c_3));
    AND2 i1021 (.O(n1089), .I0(n1082), .I1(LED_C_N_61));
    INV i318 (.O(n390), .I0(num1_c_2));
    AND2 i555 (.O(n96), .I0(n31), .I1(n78));
    OR2 i554 (.O(n14_adj_25), .I0(num4_c_2), .I1(num4_c_1));
    AND2 i1018 (.O(n1086), .I0(n1082), .I1(LED_B_N_53));
    AND2 i553 (.O(n95), .I0(n31), .I1(n77));
    INV i973 (.O(n1041), .I0(scancnt[1]));
    INV i535 (.O(n607), .I0(n40));
    INV i529 (.O(n601), .I0(n49));
    OR2 i1_adj_9 (.O(n689), .I0(count[11]), .I1(count[5]));
    AND2 i552 (.O(n94), .I0(n31), .I1(n76));
    INV i362 (.O(n434), .I0(num4_c_3));
    INV i355 (.O(n427), .I0(n14_adj_13));
    AND2 i1011 (.O(n1079), .I0(n1063), .I1(LED_G_N_94));
    INV i967 (.O(n1022), .I0(n1034));
    AND2 i1008 (.O(n1076), .I0(n1063), .I1(LED_E_N_78));
    AND2 i1005 (.O(n1073), .I0(n1063), .I1(LED_D_N_70));
    AND2 i551 (.O(n93), .I0(n31), .I1(n75));
    INV i365 (.O(n437), .I0(num4_c_2));
    AND2 i550 (.O(n92), .I0(n31), .I1(n74));
    AND2 i1002 (.O(n1070), .I0(n1063), .I1(LED_C_N_62));
    AND2 i549 (.O(n91), .I0(n31), .I1(n73));
    AND2 i999 (.O(n1067), .I0(n1063), .I1(LED_B_N_54));
    AND2 i1133 (.O(n1201), .I0(n434), .I1(n1200));
    OR2 i1017 (.O(LED_A_N_40), .I0(n1084), .I1(n1083));
    OR2 i1117 (.O(n1185), .I0(n1184), .I1(n1183));
    XOR2 i731 (.O(n77), .I0(n796), .I1(count[8]));
    AND2 i1019 (.O(n1087), .I0(LED_VCC4_N_112), .I1(LED_B_N_59));
    AND2 i992 (.O(n1060), .I0(n3), .I1(LED_G_N_96));
    XOR2 i738 (.O(n76), .I0(n803), .I1(count[9]));
    AND2 i989 (.O(n1057), .I0(n3), .I1(LED_E_N_80));
    AND2 i545 (.O(n89), .I0(n31), .I1(n71));
    AND2 i544 (.O(n88), .I0(n31), .I1(n70));
    XOR2 i745 (.O(n75), .I0(n810), .I1(count[10]));
    OR2 i1065 (.O(LED_D_N_74), .I0(n1132), .I1(n1131));
    XOR2 i752 (.O(n74), .I0(n817), .I1(count[11]));
    INV i245 (.O(n3_adj_16), .I0(num3_c_1));
    INV i517 (.O(n589), .I0(n444));
    XOR2 i759 (.O(n73), .I0(n824), .I1(count[12]));
    GND i1 (.X(n229));
    INV i511 (.O(n583), .I0(n1191));
    INV i509 (.O(n581), .I0(n293));
    XOR2 i766 (.O(n72), .I0(n831), .I1(count[13]));
    AND3 i986 (.O(n1054), .I0(n434), .I1(n3), .I2(n1194));
    AND4 i983 (.O(n1051), .I0(n434), .I1(num4_c_1), .I2(n3), .I3(n5_adj_1));
    AND4 i980 (.O(n1048), .I0(num4_c_2), .I1(n6_adj_19), .I2(n3), .I3(n434));
    INV i242 (.O(n2_adj_12), .I0(num3_c_0));
    XOR2 i773 (.O(n71), .I0(n838), .I1(count[14]));
    AND2 i542 (.O(n6_adj_23), .I0(num4_c_1), .I1(num4_c_0));
    XOR2 i710 (.O(n80), .I0(n775), .I1(count[5]));
    INV i348 (.O(n420), .I0(num3_c_2));
    INV i1075 (.O(n1143), .I0(num3_c_3));
    XOR2 i780 (.O(n70), .I0(n845), .I1(count[15]));
    INV i238 (.O(n3_adj_9), .I0(num2_c_1));
    INV i237 (.O(n2_adj_6), .I0(num2_c_0));
    AND2 i1130 (.O(n1198), .I0(n437), .I1(n3_adj_24));
    AND2 i762 (.O(n831), .I0(n824), .I1(count[12]));
    OR2 i1020 (.O(LED_B_N_52), .I0(n1087), .I1(n1086));
    OR5 i1_adj_10 (.O(n4_adj_21), .I0(count[10]), .I1(count[13]), .I2(count[7]), 
        .I3(count[4]), .I4(count[12]));
    INV i972 (.O(n1040), .I0(scancnt[0]));
    OR2 i968 (.O(n1036), .I0(num4_c_2), .I1(num4_c_0));
    AND2 i769 (.O(n838), .I0(n831), .I1(count[13]));
    AND2 i1119 (.O(n1187), .I0(num3_c_3), .I1(n14_adj_17));
    OR2 i1120 (.O(LED_G_N_97), .I0(n1187), .I1(n1186));
    AND2 i1122 (.O(n1190), .I0(num3_c_3), .I1(n427));
    OR2 i372 (.O(n444), .I0(n437), .I1(num4_c_1));
    OR2 i1123 (.O(n1191), .I0(n1190), .I1(n1189));
    OR2 i541 (.O(n3_adj_22), .I0(num4_c_1), .I1(num4_c_0));
    AND2 i1125 (.O(n1193), .I0(num4_c_2), .I1(n366));
    AND2 i1022 (.O(n1090), .I0(LED_VCC4_N_112), .I1(LED_C_N_67));
    OR2 i1023 (.O(LED_C_N_60), .I0(n1090), .I1(n1089));
    OR2 i536 (.O(n7_adj_4), .I0(n607), .I1(num1_c_0));
    AND2 i1127 (.O(n1195), .I0(n434), .I1(n7_adj_20));
    OR2 i1126 (.O(n1194), .I0(n1193), .I1(n1192));
    OR2 i988 (.O(LED_D_N_70), .I0(n1055), .I1(n1054));
    AND2 i538 (.O(n6), .I0(n581), .I1(n5));
    AND2 i990 (.O(n1058), .I0(LED_A_N_47), .I1(LED_E_N_81));
    AND3 i1067 (.O(n1135), .I0(n30), .I1(num2_c_3), .I2(n10_adj_8));
    AND2 i1000 (.O(n1068), .I0(LED_VCC3_N_109), .I1(LED_B_N_58));
    OR2 i1068 (.O(LED_E_N_82), .I0(n1135), .I1(n1134));
    AND3 i1070 (.O(n1138), .I0(num2_c_1), .I1(num2_c_2), .I2(num2_c_0));
    AND3 i1128 (.O(n1196), .I0(n4_adj_18), .I1(num4_c_3), .I2(n437));
    INV i225 (.O(n3_adj_5), .I0(num1_c_1));
    AND2 i699 (.O(n768), .I0(n761), .I1(count[3]));
    OR2 i1071 (.O(n1139), .I0(n1138), .I1(n1137));
    XOR2 i696 (.O(n82), .I0(n761), .I1(count[3]));
    OR2 i982 (.O(LED_B_N_54), .I0(n1049), .I1(n1048));
    AND2 i1073 (.O(n1141), .I0(num2_c_3), .I1(n14_adj_10));
    AND2 i974 (.O(LED_VCC4_N_112), .I0(n1041), .I1(n1040));
    OR2 i991 (.O(LED_E_N_78), .I0(n1058), .I1(n1057));
    AND2 i685 (.O(n754), .I0(count[0]), .I1(count[1]));
    OR2 i512 (.O(LED_E_N_81), .I0(n583), .I1(num3_c_0));
    XOR2 i250 (.O(n6_adj_19), .I0(num4_c_1), .I1(num4_c_0));
    OR2 i351 (.O(n423), .I0(n420), .I1(num3_c_1));
    OR2 i1074 (.O(LED_G_N_98), .I0(n1141), .I1(n1140));
    AND2 i1124 (.O(n1192), .I0(n437), .I1(n4_adj_18));
    AND3 i1076 (.O(n1144), .I0(n3_adj_16), .I1(n1143), .I2(n418));
    OR2 i2_adj_11 (.O(n31), .I0(n4_adj_21), .I1(n1022));
    OR2 i1129 (.O(LED_E_N_80), .I0(n1196), .I1(n1195));
    INV i224 (.O(n2_adj_3), .I0(num1_c_0));
    AND2 i1077 (.O(n1145), .I0(num3_c_3), .I1(n14_adj_13));
    AND2 i1121 (.O(n1189), .I0(n1143), .I1(n423));
    XOR2 i361 (.O(n418), .I0(num3_c_2), .I1(num3_c_0));
    OR2 i523 (.O(n14_adj_17), .I0(num3_c_2), .I1(n4));
    AND2 i993 (.O(n1061), .I0(LED_A_N_47), .I1(LED_G_N_97));
    OR2 i1078 (.O(LED_A_N_46), .I0(n1145), .I1(n1144));
    AND2 i1118 (.O(n1186), .I0(n1143), .I1(n1185));
    AND2 i548 (.O(n90), .I0(n31), .I1(n72));
    XOR2 i368 (.O(n403), .I0(num2_c_2), .I1(num2_c_0));
    OR2 i520 (.O(n14_adj_13), .I0(num3_c_2), .I1(num3_c_1));
    XOR2 i371 (.O(n386), .I0(num1_c_2), .I1(num1_c_0));
    INV i680 (.O(n85), .I0(count[0]));
    AND2 i1115 (.O(n1183), .I0(n420), .I1(n3_adj_16));
    AND2 i1_adj_12 (.O(n4), .I0(num3_c_1), .I1(n2_adj_12));
    AND2 i966 (.O(n1034), .I0(n1020), .I1(n1026));
    AND2 i1_adj_13 (.O(n4_adj_18), .I0(n3_adj_24), .I1(num4_c_0));
    AND2 i514 (.O(n6_adj_15), .I0(num3_c_1), .I1(num3_c_0));
    OR2 i513 (.O(n3_adj_14), .I0(num3_c_1), .I1(num3_c_0));
    AND2 i1112 (.O(n1180), .I0(n420), .I1(n3_adj_14));
    INV equal_163_i4 (.O(LED_A_N_47), .I0(n3));
    INV i208 (.O(n2), .I0(scancnt[1]));
    AND2 i1109 (.O(n1177), .I0(n2), .I1(n1167));
    AND2 i1106 (.O(n1174), .I0(n2), .I1(n1173));
    AND2 i1103 (.O(n1171), .I0(n2_adj_3), .I1(n1028));
    AND2 i692 (.O(n761), .I0(n754), .I1(count[2]));
    AND2 i1100 (.O(n1168), .I0(n1143), .I1(n1182));
    AND2 i1097 (.O(n1165), .I0(n2_adj_6), .I1(n1032));
    INV i975 (.O(n1043), .I0(scancnt[1]));
    
endmodule
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
// Verilog Description of module INV
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND4
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND6
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
// Verilog Description of module OR5
// module not written out since it is a black-box. 
//

