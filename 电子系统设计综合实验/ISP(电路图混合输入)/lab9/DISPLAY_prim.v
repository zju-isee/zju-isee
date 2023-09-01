// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Thu May 25 00:28:35 2023
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
    
    wire n220, reset_c, num1_c_3, num1_c_2, num1_c_1, num1_c_0, 
        num2_c_3, num2_c_2, num2_c_1, num2_c_0, num3_c_3, num3_c_2, 
        num3_c_1, num3_c_0, num4_c_3, num4_c_2, num4_c_1, num4_c_0, 
        LED_A_c, LED_B_c, LED_C_c, LED_D_c, LED_E_c, LED_F_c, LED_G_c, 
        n1117, n975, LED_VCC3_c, LED_VCC4_c;
    wire [1:0]scancnt;   // display.v(11[11:18])
    wire [12:0]count;   // display.v(12[12:17])
    
    wire n1149, n4, n1044, n1148, n595, n593, n998, n6, n5, 
        n1146, n281, LED_A_N_44, LED_B_N_53, LED_C_N_61, LED_D_N_69, 
        LED_E_N_77, LED_G_N_93, n1145, LED_A_N_42, LED_B_N_52, LED_C_N_60, 
        LED_D_N_68, LED_E_N_76, LED_G_N_92, LED_A_N_41, LED_A_N_40, 
        LED_B_N_51, LED_C_N_59, LED_D_N_67, LED_E_N_75, LED_G_N_91, 
        LED_E_N_74, LED_G_N_90, n1144, n983, n985, LED_A_N_36, LED_B_N_48, 
        LED_C_N_56, LED_D_N_64, LED_E_N_72, LED_G_N_88, n25, n1132, 
        n1142, LED_A_N_35, LED_B_N_47, LED_C_N_55, LED_D_N_63, LED_E_N_71, 
        LED_G_N_87, n969, LED_VCC3_N_103, LED_A_N_34, LED_B_N_46, 
        LED_C_N_54, LED_D_N_62, LED_E_N_70, LED_F_N_78, LED_G_N_86, 
        n5_adj_1, LED_VCC4_N_106, n1140, n752, n1139, n745, n787, 
        n780, n25_adj_2, n1000, n1004, n2, n3, n1137, n1136, 
        n1135, n40, n971, n773, n2_adj_3, n49, n1042, n58, n59, 
        n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, 
        n70, n73, n74, n75, n76, n77, n78, n79, n80, n81, 
        n82, n83, n84, n1134, n349, n351, n353, n355, n1025, 
        n1133, n1131, n1041, n1130, n379, n1129, n1039, n1038, 
        n1127, n738, n2_adj_4, n1125, n1124, n766, n1065, n1122, 
        n7, n1121, n10, n1037, n1035, n1119, pwr, n1034, n1118, 
        n1116, n3_adj_5, n794, n1074, n14, n1115, n394, n759, 
        n1023, n1113, n1112, n1111, n731, n1109, n2_adj_6, n1032, 
        n1031, n1086, n1022, n7_adj_7, n10_adj_8, n1108, n1029, 
        n1106, n3_adj_9, n1105, n1095, n14_adj_10, n1103, n409, 
        n6_adj_11, n1102, n1100, n2_adj_12, n1028, n14_adj_13, n1099, 
        n617, n1114, n1098, n1026, n1096, n1094, n1093, n1020, 
        n3_adj_14, n6_adj_15, n1138, n1092, n3_adj_16, n1090, n1141, 
        n4_adj_17, n979, n1089, n18, n4_adj_18, n14_adj_19, n1087, 
        n17, n1085, n16, n1084, n1120, n1123, n1126, n6_adj_20, 
        n543, n1083, n433, n1081, n1019, n426, n20, n423, n418, 
        n1147, n416, n1080, n1150, n412, n1018, n407, n1016, 
        n1078, n989, n7_adj_21, n1015, n1077, n600, n1075, n1013, 
        n1012, n3_adj_22, n392, n6_adj_23, n1010, n724, n993, 
        n1009, n1007, n3_adj_24, n1006, n1073, n1156, n377, n1072, 
        n623, n14_adj_25, n1071, n1069, n14_adj_26, n995, n12, 
        n1068, n1066, n1064, n1063, n1062, n1003, n1001, n1060, 
        n1059, n1057, n996, n1056, n1054, n1053, n1051, n1050, 
        n1048, n1047, n1045, n891, n1157, n1155, n1154, n1153, 
        n1151;
    
    INV i225 (.O(n2_adj_4), .I0(num1_c_0));
    AND2 i1072 (.O(n1129), .I0(n2), .I1(n1125));
    AND2 i1069 (.O(n1126), .I0(n1098), .I1(n1113));
    AND2 i1066 (.O(n1123), .I0(n2_adj_4), .I1(n971));
    AND2 i1063 (.O(n1120), .I0(n1098), .I1(n1137));
    AND2 i1060 (.O(n1117), .I0(n2_adj_6), .I1(n975));
    AND2 i1057 (.O(n1114), .I0(n426), .I1(n3_adj_22));
    AND3 i1054 (.O(n1111), .I0(n3_adj_16), .I1(n409), .I2(num3_c_0));
    OR2 i1_adj_1 (.O(n49), .I0(n394), .I1(num2_c_1));
    AND2 i1051 (.O(n1108), .I0(n995), .I1(n1131));
    OR2 i1_adj_2 (.O(n40), .I0(num1_c_1), .I1(n379));
    AND2 i1_adj_3 (.O(LED_C_N_61), .I0(n971), .I1(n2_adj_4));
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
    DFF scancnt__i0 (.Q(scancnt[0]), .D(n6), .CLK(clk_c));   // display.v(19[10] 25[24])
    AND2 i687 (.O(n745), .I0(n738), .I1(count[4]));
    OR2 i1044 (.O(LED_A_N_40), .I0(n1100), .I1(n1099));
    DFFR count_186__i0 (.Q(count[0]), .D(n70), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFC scancnt__i1 (.Q(scancnt[1]), .D(n891), .CLK(clk_c), .CE(n4));   // display.v(19[10] 25[24])
    AND2 i1046 (.O(n1103), .I0(num3_c_3), .I1(n14_adj_13));
    OR2 i1047 (.O(LED_B_N_51), .I0(n1103), .I1(n1102));
    AND3 i1048 (.O(n1105), .I0(n4_adj_17), .I1(n1098), .I2(n409));
    OR2 i541 (.O(n7_adj_21), .I0(n600), .I1(num4_c_0));
    OR2 i970 (.O(LED_C_N_55), .I0(n1026), .I1(n1025));
    AND2 i1049 (.O(n1106), .I0(num3_c_3), .I1(n14_adj_13));
    XOR2 i242 (.O(n6_adj_11), .I0(num3_c_1), .I1(num3_c_0));
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    AND3 i1045 (.O(n1102), .I0(num3_c_2), .I1(n1098), .I2(n6_adj_11));
    OR2 i1050 (.O(LED_C_N_59), .I0(n1106), .I1(n1105));
    AND2 i1052 (.O(n1109), .I0(scancnt[0]), .I1(n1134));
    OBUF LED_VCC4_pad (.O(LED_VCC4), .I0(LED_VCC4_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i1053 (.O(LED_F_N_78), .I0(n1109), .I1(n1108));
    AND2 i1_adj_4 (.O(n975), .I0(n394), .I1(num2_c_1));
    OBUF LED_VCC3_pad (.O(LED_VCC3), .I0(LED_VCC3_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFR count_186__i12 (.Q(count[12]), .D(n73), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    AND2 i972 (.O(n1029), .I0(LED_VCC3_N_103), .I1(LED_D_N_68));
    AND2 i694 (.O(n752), .I0(n745), .I1(count[5]));
    AND2 i729 (.O(n787), .I0(n780), .I1(count[10]));
    OR2 i973 (.O(LED_D_N_63), .I0(n1029), .I1(n1028));
    OBUF LED_VCC2_pad (.O(LED_VCC2), .I0(n220));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i1038 (.O(n1095), .I0(n25), .I1(n1094));
    AND2 i1055 (.O(n1112), .I0(num3_c_2), .I1(n353));
    AND2 i701 (.O(n759), .I0(n752), .I1(count[6]));
    OR2 i530 (.O(n14_adj_10), .I0(num2_c_2), .I1(num2_c_1));
    AND2 i1035 (.O(n1092), .I0(n394), .I1(n3_adj_9));
    XOR2 i237 (.O(n10_adj_8), .I0(num2_c_1), .I1(num2_c_0));
    AND2 i736 (.O(n794), .I0(n787), .I1(count[11]));
    OR2 i1056 (.O(n1113), .I0(n1112), .I1(n1111));
    AND2 i1032 (.O(n1089), .I0(n25), .I1(n7_adj_7));
    AND2 i708 (.O(n766), .I0(n759), .I1(count[7]));
    AND2 i1058 (.O(n1115), .I0(num4_c_2), .I1(n6_adj_23));
    AND2 i1029 (.O(n1086), .I0(n25), .I1(n1085));
    OBUF LED_VCC1_pad (.O(LED_VCC1), .I0(n220));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND3 i1026 (.O(n1083), .I0(n3_adj_9), .I1(n394), .I2(num2_c_0));
    AND3 i1023 (.O(n1080), .I0(num2_c_2), .I1(n25), .I2(n10_adj_8));
    OR2 i1059 (.O(n1116), .I0(n1115), .I1(n1114));
    AND2 i975 (.O(n1032), .I0(LED_VCC3_N_103), .I1(LED_E_N_76));
    OBUF LED_G_pad (.O(LED_G), .I0(LED_G_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND3 i1020 (.O(n1077), .I0(n3_adj_9), .I1(n25), .I2(n392));
    AND2 i1017 (.O(n1074), .I0(n2_adj_3), .I1(n1073));
    OR3 i2 (.O(n20), .I0(count[11]), .I1(count[4]), .I2(count[7]));
    OBUF LED_F_pad (.O(LED_F), .I0(LED_F_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i1_adj_5 (.O(n81), .I0(n66), .I1(n25_adj_2));
    OR2 i524 (.O(n14), .I0(num1_c_2), .I1(num1_c_1));
    AND2 i1014 (.O(n1071), .I0(n379), .I1(n3_adj_5));
    AND3 i1061 (.O(n1118), .I0(n49), .I1(num2_c_0), .I2(n25));
    AND3 i1094 (.O(n1151), .I0(n4_adj_18), .I1(num4_c_3), .I2(n426));
    OR2 i1095 (.O(LED_E_N_74), .I0(n1151), .I1(n1150));
    AND2 i1097 (.O(n1154), .I0(num4_c_2), .I1(n6_adj_23));
    XOR2 i224 (.O(n10), .I0(num1_c_1), .I1(num1_c_0));
    AND2 i963 (.O(n1020), .I0(LED_VCC3_N_103), .I1(LED_A_N_42));
    OR2 i1098 (.O(n1155), .I0(n1154), .I1(n1153));
    AND2 i1100 (.O(n1157), .I0(num4_c_3), .I1(n14_adj_25));
    OR2 i1062 (.O(n1119), .I0(n1118), .I1(n1117));
    AND2 i1011 (.O(n1068), .I0(n2_adj_3), .I1(n7));
    OR2 i1101 (.O(LED_G_N_90), .I0(n1157), .I1(n1156));
    AND2 i1064 (.O(n1121), .I0(num3_c_3), .I1(n14_adj_13));
    AND2 i1_adj_6 (.O(n75), .I0(n60), .I1(n25_adj_2));
    OBUF LED_E_pad (.O(LED_E), .I0(LED_E_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i1065 (.O(n1122), .I0(n1121), .I1(n1120));
    XOR2 i15 (.O(n891), .I0(scancnt[0]), .I1(scancnt[1]));
    AND2 i988 (.O(n1045), .I0(LED_VCC4_N_106), .I1(LED_C_N_61));
    OR2 i989 (.O(LED_C_N_54), .I0(n1045), .I1(n1044));
    AND2 i1008 (.O(n1065), .I0(n2_adj_3), .I1(n1064));
    OBUF LED_D_pad (.O(LED_D), .I0(LED_D_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i991 (.O(n1048), .I0(LED_VCC4_N_106), .I1(LED_D_N_69));
    OR2 i976 (.O(LED_E_N_71), .I0(n1032), .I1(n1031));
    AND2 i1_adj_7 (.O(n84), .I0(n69), .I1(n25_adj_2));
    OR2 i992 (.O(LED_D_N_62), .I0(n1048), .I1(n1047));
    AND2 i994 (.O(n1051), .I0(LED_VCC4_N_106), .I1(LED_E_N_77));
    OR2 i995 (.O(LED_E_N_70), .I0(n1051), .I1(n1050));
    AND2 i997 (.O(n1054), .I0(LED_VCC4_N_106), .I1(LED_G_N_93));
    AND3 i1005 (.O(n1062), .I0(n3_adj_5), .I1(n379), .I2(num1_c_0));
    INV i319 (.O(n379), .I0(num1_c_2));
    OR2 i998 (.O(LED_G_N_86), .I0(n1054), .I1(n1053));
    AND2 i978 (.O(n1035), .I0(LED_VCC3_N_103), .I1(LED_G_N_92));
    OBUF LED_C_pad (.O(LED_C), .I0(LED_C_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND3 i1067 (.O(n1124), .I0(n40), .I1(num1_c_0), .I2(n2_adj_3));
    AND2 i1_adj_8 (.O(n76), .I0(n61), .I1(n25_adj_2));
    OR2 i1068 (.O(n1125), .I0(n1124), .I1(n1123));
    INV equal_163_i4 (.O(LED_A_N_41), .I0(n3));
    AND3 i1002 (.O(n1059), .I0(num1_c_2), .I1(n2_adj_3), .I2(n10));
    AND2 i1000 (.O(n1057), .I0(num1_c_3), .I1(LED_C_N_61));
    IBUF num4_pad_0 (.O(num4_c_0), .I0(num4[0]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    AND2 i1070 (.O(n1127), .I0(num3_c_3), .I1(n14_adj_13));
    OR2 i1001 (.O(LED_A_N_44), .I0(n1057), .I1(n1056));
    AND2 i1003 (.O(n1060), .I0(num1_c_3), .I1(LED_C_N_61));
    INV i209 (.O(n2), .I0(scancnt[1]));
    INV i25 (.O(n25), .I0(num2_c_3));
    AND2 i1_adj_9 (.O(n74), .I0(n59), .I1(n25_adj_2));
    INV i980 (.O(n1037), .I0(LED_VCC4_N_106));
    OR2 i1071 (.O(LED_D_N_67), .I0(n1127), .I1(n1126));
    OR2 equal_163_i3 (.O(n3), .I0(n2), .I1(scancnt[0]));
    AND2 i940 (.O(LED_VCC4_N_106), .I0(n996), .I1(n995));
    AND4 i943 (.O(n1000), .I0(n3_adj_24), .I1(n418), .I2(n3), .I3(n423));
    DFFR count_186__i11 (.Q(count[11]), .D(n74), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i10 (.Q(count[10]), .D(n75), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i9 (.Q(count[9]), .D(n76), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i8 (.Q(count[8]), .D(n77), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i7 (.Q(count[7]), .D(n78), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i6 (.Q(count[6]), .D(n79), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i5 (.Q(count[5]), .D(n80), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i4 (.Q(count[4]), .D(n81), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i3 (.Q(count[3]), .D(n82), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i2 (.Q(count[2]), .D(n83), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_186__i1 (.Q(count[1]), .D(n84), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
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
    DFFCS LED_B_109 (.Q(LED_B_c), .D(LED_B_N_46), .CLK(clk_c), .CE(pwr), 
          .S(reset_c));   // display.v(36[10] 343[12])
    OR2 i979 (.O(LED_G_N_87), .I0(n1035), .I1(n1034));
    OR2 i1004 (.O(LED_B_N_53), .I0(n1060), .I1(n1059));
    AND2 i1006 (.O(n1063), .I0(num1_c_2), .I1(n349));
    AND2 i944 (.O(n1001), .I0(LED_A_N_41), .I1(LED_A_N_40));
    OR2 i945 (.O(LED_A_N_36), .I0(n1001), .I1(n1000));
    INV i939 (.O(n996), .I0(scancnt[1]));
    AND2 i1073 (.O(n1130), .I0(scancnt[1]), .I1(n1122));
    OR2 i1007 (.O(n1064), .I0(n1063), .I1(n1062));
    AND2 i1009 (.O(n1066), .I0(num1_c_3), .I1(LED_C_N_61));
    INV i941 (.O(n998), .I0(scancnt[1]));
    INV i937 (.O(n969), .I0(n993));
    INV i938 (.O(n995), .I0(scancnt[0]));
    AND2 i3 (.O(n14_adj_26), .I0(reset_c), .I1(count[5]));
    GND i1 (.X(n220));
    AND2 i5 (.O(n16), .I0(count[0]), .I1(count[8]));
    OR2 i1074 (.O(n1131), .I0(n1130), .I1(n1129));
    XOR2 i296 (.O(n5), .I0(n4), .I1(scancnt[0]));
    AND3 i1076 (.O(n1133), .I0(n1116), .I1(scancnt[1]), .I2(n423));
    INV i289 (.O(n349), .I0(n10));
    OR2 i1010 (.O(LED_D_N_69), .I0(n1066), .I1(n1065));
    AND2 i969 (.O(n1026), .I0(LED_VCC3_N_103), .I1(LED_C_N_60));
    AND2 i1_adj_10 (.O(LED_C_N_60), .I0(n975), .I1(n2_adj_6));
    INV i291 (.O(n351), .I0(n10_adj_8));
    AND3 i1012 (.O(n1069), .I0(n379), .I1(num1_c_3), .I2(n10));
    INV i293 (.O(n353), .I0(n6_adj_11));
    AND2 i947 (.O(n1004), .I0(LED_A_N_41), .I1(LED_B_N_51));
    AND3 i196 (.O(n281), .I0(scancnt[1]), .I1(scancnt[0]), .I2(n4));
    OR2 i1077 (.O(n1134), .I0(n1133), .I1(n1132));
    AND2 i1079 (.O(n1136), .I0(num3_c_2), .I1(n6_adj_15));
    OR2 i1013 (.O(LED_E_N_77), .I0(n1069), .I1(n1068));
    AND3 i1015 (.O(n1072), .I0(num1_c_1), .I1(num1_c_2), .I2(num1_c_0));
    OR2 i964 (.O(LED_A_N_35), .I0(n1020), .I1(n1019));
    AND6 i1_adj_11 (.O(n4), .I0(n18), .I1(count[12]), .I2(n16), .I3(n17), 
         .I4(n543), .I5(count[9]));
    OR2 i1016 (.O(n1073), .I0(n1072), .I1(n1071));
    OR2 i536 (.O(LED_E_N_75), .I0(n595), .I1(num3_c_0));
    INV i295 (.O(n355), .I0(n6_adj_20));
    AND2 i966 (.O(n1023), .I0(LED_VCC3_N_103), .I1(LED_B_N_52));
    AND2 i1018 (.O(n1075), .I0(num1_c_3), .I1(n14));
    OR2 i1019 (.O(LED_G_N_93), .I0(n1075), .I1(n1074));
    OR2 i1080 (.O(n1137), .I0(n1136), .I1(n1135));
    XOR2 i377 (.O(n418), .I0(num4_c_2), .I1(num4_c_0));
    AND3 i999 (.O(n1056), .I0(n3_adj_5), .I1(n2_adj_3), .I2(n377));
    AND2 i1021 (.O(n1078), .I0(num2_c_3), .I1(LED_C_N_60));
    OR2 i1022 (.O(LED_A_N_42), .I0(n1078), .I1(n1077));
    AND2 i996 (.O(n1053), .I0(n1037), .I1(LED_G_N_87));
    AND2 i993 (.O(n1050), .I0(n1037), .I1(LED_E_N_71));
    AND2 i990 (.O(n1047), .I0(n1037), .I1(LED_D_N_63));
    AND2 i1024 (.O(n1081), .I0(num2_c_3), .I1(LED_C_N_60));
    OR2 i1025 (.O(LED_B_N_52), .I0(n1081), .I1(n1080));
    AND2 i1027 (.O(n1084), .I0(num2_c_2), .I1(n351));
    OR2 i1028 (.O(n1085), .I0(n1084), .I1(n1083));
    XOR2 i670 (.O(n68), .I0(n724), .I1(count[2]));
    AND2 i922 (.O(n979), .I0(count[12]), .I1(count[8]));
    INV i661 (.O(n70), .I0(count[0]));
    AND2 i987 (.O(n1044), .I0(n1037), .I1(LED_C_N_55));
    INV i255 (.O(n3_adj_24), .I0(num4_c_1));
    AND2 i984 (.O(n1041), .I0(n1037), .I1(LED_B_N_47));
    AND2 i1_adj_12 (.O(n12), .I0(count[1]), .I1(count[6]));
    AND2 i942 (.O(LED_VCC3_N_103), .I0(n998), .I1(scancnt[0]));
    AND2 i950 (.O(n1007), .I0(LED_A_N_41), .I1(LED_C_N_59));
    AND2 i1082 (.O(n1139), .I0(num3_c_2), .I1(n6_adj_15));
    OR2 i564 (.O(n7), .I0(n623), .I1(num1_c_0));
    AND2 i6 (.O(n17), .I0(n12), .I1(count[3]));
    AND2 i7 (.O(n18), .I0(n14_adj_26), .I1(n983));
    AND2 i977 (.O(n1034), .I0(n1018), .I1(LED_G_N_88));
    AND2 i1_adj_13 (.O(n971), .I0(n379), .I1(num1_c_1));
    INV i2_adj_14 (.O(n2_adj_3), .I0(num1_c_3));
    INV i929 (.O(n5_adj_1), .I0(n985));
    AND2 i974 (.O(n1031), .I0(n1018), .I1(LED_E_N_72));
    INV i563 (.O(n623), .I0(n40));
    AND2 i971 (.O(n1028), .I0(n1018), .I1(LED_D_N_64));
    AND2 i968 (.O(n1025), .I0(n1018), .I1(LED_C_N_56));
    OR2 i577 (.O(n14_adj_25), .I0(num4_c_2), .I1(num4_c_1));
    INV i557 (.O(n617), .I0(n49));
    OR2 i951 (.O(LED_C_N_56), .I0(n1007), .I1(n1006));
    AND2 i965 (.O(n1022), .I0(n1018), .I1(LED_B_N_48));
    AND2 i680 (.O(n738), .I0(n731), .I1(count[3]));
    OR2 i967 (.O(LED_B_N_47), .I0(n1023), .I1(n1022));
    AND2 i666 (.O(n724), .I0(count[0]), .I1(count[1]));
    AND2 i958 (.O(n1015), .I0(n3), .I1(LED_G_N_90));
    AND2 i955 (.O(n1012), .I0(n3), .I1(LED_E_N_74));
    AND2 i1030 (.O(n1087), .I0(num2_c_3), .I1(LED_C_N_60));
    AND3 i952 (.O(n1009), .I0(n423), .I1(n3), .I2(n1149));
    AND4 i949 (.O(n1006), .I0(n423), .I1(num4_c_1), .I2(n3), .I3(n5_adj_1));
    AND2 i1099 (.O(n1156), .I0(n423), .I1(n1155));
    AND4 i946 (.O(n1003), .I0(num4_c_2), .I1(n6_adj_20), .I2(n3), .I3(n423));
    AND2 i953 (.O(n1010), .I0(LED_A_N_41), .I1(LED_D_N_67));
    AND2 i673 (.O(n731), .I0(n724), .I1(count[2]));
    XOR2 i663 (.O(n69), .I0(count[0]), .I1(count[1]));
    XOR2 i684 (.O(n66), .I0(n738), .I1(count[4]));
    XOR2 i691 (.O(n65), .I0(n745), .I1(count[5]));
    AND2 i932 (.O(n989), .I0(n983), .I1(count[1]));
    INV i356 (.O(n416), .I0(n14_adj_13));
    OR2 i1031 (.O(LED_D_N_68), .I0(n1087), .I1(n1086));
    INV i363 (.O(n423), .I0(num4_c_3));
    INV i246 (.O(n3_adj_16), .I0(num3_c_1));
    AND3 i1033 (.O(n1090), .I0(n394), .I1(num2_c_3), .I2(n10_adj_8));
    AND2 i1_adj_15 (.O(n77), .I0(n62), .I1(n25_adj_2));
    AND2 i1_adj_16 (.O(n82), .I0(n67), .I1(n25_adj_2));
    OR2 i1083 (.O(n1140), .I0(n1139), .I1(n1138));
    INV i366 (.O(n426), .I0(num4_c_2));
    AND2 i573 (.O(n73), .I0(n25_adj_2), .I1(n58));
    XOR2 i698 (.O(n64), .I0(n752), .I1(count[6]));
    AND2 i981 (.O(n1038), .I0(n1037), .I1(LED_A_N_35));
    INV i540 (.O(n600), .I0(n433));
    INV i535 (.O(n595), .I0(n1146));
    AND2 i572 (.O(n6_adj_23), .I0(num4_c_1), .I1(num4_c_0));
    INV i533 (.O(n593), .I0(n281));
    INV i243 (.O(n2_adj_12), .I0(num3_c_0));
    AND2 i1096 (.O(n1153), .I0(n426), .I1(n3_adj_24));
    AND2 i1085 (.O(n1142), .I0(num3_c_3), .I1(n14_adj_19));
    OR2 i1086 (.O(LED_G_N_91), .I0(n1142), .I1(n1141));
    AND2 i1088 (.O(n1145), .I0(num3_c_3), .I1(n416));
    INV i349 (.O(n409), .I0(num3_c_2));
    AND2 i1_adj_17 (.O(n83), .I0(n68), .I1(n25_adj_2));
    AND2 i1_adj_18 (.O(n79), .I0(n64), .I1(n25_adj_2));
    AND2 i982 (.O(n1039), .I0(LED_VCC4_N_106), .I1(LED_A_N_44));
    OR2 i983 (.O(LED_A_N_34), .I0(n1039), .I1(n1038));
    OR2 i1089 (.O(n1146), .I0(n1145), .I1(n1144));
    XOR2 i705 (.O(n63), .I0(n759), .I1(count[7]));
    AND2 i1091 (.O(n1148), .I0(num4_c_2), .I1(n355));
    XOR2 i712 (.O(n62), .I0(n766), .I1(count[8]));
    AND2 i1_adj_19 (.O(n78), .I0(n63), .I1(n25_adj_2));
    OR2 i1092 (.O(n1149), .I0(n1148), .I1(n1147));
    AND2 i985 (.O(n1042), .I0(LED_VCC4_N_106), .I1(LED_B_N_53));
    OR2 i571 (.O(n3_adj_22), .I0(num4_c_1), .I1(num4_c_0));
    OR2 i373 (.O(n433), .I0(n426), .I1(num4_c_1));
    OR2 i986 (.O(LED_B_N_46), .I0(n1042), .I1(n1041));
    OR2 i1034 (.O(LED_E_N_76), .I0(n1090), .I1(n1089));
    AND2 i1093 (.O(n1150), .I0(n423), .I1(n7_adj_21));
    XOR2 i719 (.O(n61), .I0(n773), .I1(count[9]));
    AND2 i568 (.O(n6), .I0(n593), .I1(n5));
    XOR2 i726 (.O(n60), .I0(n780), .I1(count[10]));
    OR2 i954 (.O(LED_D_N_64), .I0(n1010), .I1(n1009));
    XOR2 i733 (.O(n59), .I0(n787), .I1(count[11]));
    XOR2 i677 (.O(n67), .I0(n731), .I1(count[3]));
    INV i1041 (.O(n1098), .I0(num3_c_3));
    AND2 i1_adj_20 (.O(n80), .I0(n65), .I1(n25_adj_2));
    AND2 i956 (.O(n1013), .I0(LED_A_N_41), .I1(LED_E_N_75));
    OR2 i948 (.O(LED_B_N_48), .I0(n1004), .I1(n1003));
    INV i239 (.O(n3_adj_9), .I0(num2_c_1));
    XOR2 i740 (.O(n58), .I0(n794), .I1(count[12]));
    AND3 i1036 (.O(n1093), .I0(num2_c_1), .I1(num2_c_2), .I2(num2_c_0));
    OR2 i957 (.O(LED_E_N_72), .I0(n1013), .I1(n1012));
    OR2 i558 (.O(n7_adj_7), .I0(n617), .I1(num2_c_0));
    OR2 i1037 (.O(n1094), .I0(n1093), .I1(n1092));
    AND2 i959 (.O(n1016), .I0(LED_A_N_41), .I1(LED_G_N_91));
    XOR2 i251 (.O(n6_adj_20), .I0(num4_c_1), .I1(num4_c_0));
    OR2 i960 (.O(LED_G_N_88), .I0(n1016), .I1(n1015));
    OR2 i352 (.O(n412), .I0(n409), .I1(num3_c_1));
    AND2 i1039 (.O(n1096), .I0(num2_c_3), .I1(n14_adj_10));
    OR2 i1040 (.O(LED_G_N_92), .I0(n1096), .I1(n1095));
    INV i238 (.O(n2_adj_6), .I0(num2_c_0));
    VCC i746 (.X(pwr));
    XOR2 i360 (.O(n407), .I0(num3_c_2), .I1(num3_c_0));
    AND2 i1090 (.O(n1147), .I0(n426), .I1(n4_adj_18));
    AND2 i1087 (.O(n1144), .I0(n1098), .I1(n412));
    AND2 i926 (.O(n983), .I0(count[10]), .I1(count[2]));
    AND2 i715 (.O(n773), .I0(n766), .I1(count[8]));
    OR2 i551 (.O(n14_adj_19), .I0(num3_c_2), .I1(n4_adj_17));
    AND6 i936 (.O(n993), .I0(count[6]), .I1(n989), .I2(count[9]), .I3(n979), 
         .I4(count[3]), .I5(count[5]));
    AND2 i1084 (.O(n1141), .I0(n1098), .I1(n1140));
    AND2 i962 (.O(n1019), .I0(n1018), .I1(LED_A_N_36));
    AND3 i1042 (.O(n1099), .I0(n3_adj_16), .I1(n1098), .I2(n407));
    XOR2 i369 (.O(n392), .I0(num2_c_2), .I1(num2_c_0));
    INV i8 (.O(n543), .I0(n20));
    OR2 i544 (.O(n14_adj_13), .I0(num3_c_2), .I1(num3_c_1));
    XOR2 i372 (.O(n377), .I0(num1_c_2), .I1(num1_c_0));
    AND2 i1081 (.O(n1138), .I0(n409), .I1(n3_adj_16));
    AND2 i542 (.O(n6_adj_15), .I0(num3_c_1), .I1(num3_c_0));
    OR2 i539 (.O(n3_adj_14), .I0(num3_c_1), .I1(num3_c_0));
    AND2 i1_adj_21 (.O(n4_adj_17), .I0(num3_c_1), .I1(n2_adj_12));
    AND2 i1043 (.O(n1100), .I0(num3_c_3), .I1(n14_adj_13));
    INV i334 (.O(n394), .I0(num2_c_2));
    INV i226 (.O(n3_adj_5), .I0(num1_c_1));
    AND2 i1_adj_22 (.O(n4_adj_18), .I0(n3_adj_24), .I1(num4_c_0));
    OR2 i928 (.O(n985), .I0(num4_c_2), .I1(num4_c_0));
    OR3 i2_adj_23 (.O(n25_adj_2), .I0(n70), .I1(n20), .I2(n969));
    AND2 i722 (.O(n780), .I0(n773), .I1(count[9]));
    AND2 i1078 (.O(n1135), .I0(n409), .I1(n3_adj_14));
    AND2 i1075 (.O(n1132), .I0(n2), .I1(n1119));
    INV i961 (.O(n1018), .I0(LED_VCC3_N_103));
    
endmodule
//
// Verilog Description of module INV
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
// Verilog Description of module OR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module XOR2
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR3
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND4
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

//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

