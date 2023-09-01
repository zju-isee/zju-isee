// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Fri May 26 11:33:44 2023
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
    
    wire n241, reset_c, num1_c_3, num1_c_2, num1_c_1, num1_c_0, 
        num2_c_3, num2_c_2, num2_c_1, num2_c_0, num3_c_3, num3_c_2, 
        num3_c_1, num3_c_0, num4_c_3, num4_c_2, num4_c_1, num4_c_0, 
        LED_A_c, LED_B_c, LED_C_c, LED_D_c, LED_E_c, LED_F_c, LED_G_c, 
        LED_VCC2_c, LED_VCC3_c, LED_VCC4_c;
    wire [1:0]scancnt;   // display.v(11[11:18])
    wire [12:0]count;   // display.v(12[12:17])
    
    wire reset_N_17, n1328, n997, n1326, n4, n1325, n1279, n1277, 
        n582, n3, n6, n5, n14, n292, LED_A_N_45, LED_B_N_55, 
        LED_C_N_64, LED_D_N_73, LED_E_N_82, LED_F_N_91, LED_G_N_100, 
        n1323, LED_A_N_43, LED_B_N_54, LED_C_N_63, LED_D_N_72, LED_E_N_81, 
        LED_F_N_90, LED_G_N_99, n1322, LED_A_N_41, LED_B_N_53, LED_C_N_62, 
        LED_D_N_71, LED_E_N_80, LED_F_N_89, LED_G_N_98, LED_E_N_79, 
        LED_G_N_97, n1320, LED_A_N_37, LED_B_N_50, LED_C_N_59, LED_D_N_68, 
        LED_E_N_77, LED_F_N_86, LED_G_N_95, LED_VCC2_N_109, LED_A_N_36, 
        LED_B_N_49, LED_C_N_58, LED_D_N_67, LED_E_N_76, LED_F_N_85, 
        LED_G_N_94, n976, LED_VCC3_N_113, LED_VCC4_N_117, LED_A_N_34, 
        LED_B_N_47, LED_C_N_56, LED_D_N_65, LED_E_N_74, LED_F_N_83, 
        LED_G_N_92, n300, n298, n296, n13, n25, n1, n3_adj_1, 
        n2, n3_adj_2, n1319, n1318, n1316, n1315, n990, n1276, 
        n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, 
        n68, n69, n70, n73, n74, n75, n76, n77, n78, n79, 
        n80, n81, n82, n83, n84, n356, n358, n360, n362, n386, 
        n6_adj_3, n2_adj_4, n1313, n14_adj_5, n618, n1331, n1312, 
        n1310, n3_adj_6, n6_adj_7, n1337, n1309, n1274, n3_adj_8, 
        n1343, n1273, n1307, n12, n397, n983, n2_adj_9, n1356, 
        n452, n1306, n1304, n7, n10, n3_adj_10, n6_adj_11, n1365, 
        n1303, n1301, n624, pwr, n3_adj_12, n601, n1371, n1300, 
        n1039, n5_adj_13, n14_adj_14, n1421, n1032, n1419, n412, 
        n1418, n1416, n1298, n1297, n6_adj_15, n1025, n1415, n2_adj_16, 
        n1414, n1235, n1018, n1295, n1412, n14_adj_17, n1387, 
        n1410, n1294, n1011, n18, n1409, n3_adj_18, n6_adj_19, 
        n1393, n1407, n969, n1406, n3_adj_20, n1292, n1399, n1004, 
        n1245, n14_adj_21, n1404, n1403, n6_adj_22, n438, n1271, 
        n429, n426, n1402, n421, n1405, n1243, n419, n1411, 
        n1400, n415, n1398, n410, n1270, n7_adj_23, n406, n1268, 
        n640, n1397, n1267, n3_adj_24, n1265, n1264, n6_adj_25, 
        n1417, n1262, n395, n1408, n393, n1261, n3_adj_26, n389, 
        n1259, n1420, n384, n1396, n1394, n14_adj_27, n1392, n1391, 
        n1390, n1291, n1289, n1388, n1386, n1385, n1384, n1288, 
        n1286, n1382, n1285, n1283, n1381, n1379, n1378, n1376, 
        n1375, n1374, n1372, n1370, n1369, n1282, n1368, n1280, 
        n1366, n1364, n1363, n1362, n1253, n1249, n1360, n17, 
        n1359, n1357, n1355, n1354, n1353, n1351, n1350, n1258, 
        n1348, n1347, n16, n1346, n1256, n1344, n1342, n1341, 
        n1255, n1340, n1338, n1336, n1335, n1334, n1332, n1330, 
        n1329, n1159, n4_adj_28, n1239, n1233, n4_adj_29;
    
    DFFC LED_VCC3_126 (.Q(LED_VCC3_c), .D(n298), .CLK(clk_c), .CE(pwr));   // display.v(28[8] 344[8])
    OR3 i527 (.O(LED_C_N_56), .I0(n1304), .I1(reset_N_17), .I2(n1303));
    OR2 i1231 (.O(LED_D_N_67), .I0(n1286), .I1(n1285));
    AND2 i1329 (.O(n1385), .I0(num3_c_2), .I1(n360));
    OR2 i1330 (.O(n1386), .I0(n1385), .I1(n1384));
    AND2 i1332 (.O(n1388), .I0(num3_c_3), .I1(n14_adj_17));
    AND2 i1233 (.O(n1289), .I0(LED_VCC3_N_113), .I1(LED_E_N_81));
    OR2 i1234 (.O(LED_E_N_76), .I0(n1289), .I1(n1288));
    OR2 i1333 (.O(LED_D_N_71), .I0(n1388), .I1(n1387));
    AND2 i1335 (.O(n1391), .I0(num3_c_2), .I1(n6_adj_19));
    OR2 i1336 (.O(n1392), .I0(n1391), .I1(n1390));
    AND2 i1203 (.O(n1259), .I0(LED_VCC2_N_109), .I1(LED_B_N_53));
    OR3 i526 (.O(LED_B_N_47), .I0(n1301), .I1(reset_N_17), .I2(n1300));
    AND2 i1259 (.O(n1315), .I0(n3), .I1(LED_G_N_94));
    GND i1 (.X(n241));
    OR2 i1204 (.O(LED_B_N_50), .I0(n1259), .I1(n1258));
    OR2 i582 (.O(n7), .I0(n640), .I1(num2_c_0));
    OR2 i592 (.O(n3_adj_24), .I0(num4_c_1), .I1(num4_c_0));
    AND2 i1256 (.O(n1312), .I0(n3), .I1(LED_F_N_85));
    AND2 i1253 (.O(n1309), .I0(n3), .I1(LED_E_N_76));
    AND2 i596 (.O(n73), .I0(n25), .I1(n58));
    AND2 i1250 (.O(n1306), .I0(n3), .I1(LED_D_N_67));
    DFFC LED_VCC2_125 (.Q(LED_VCC2_c), .D(n296), .CLK(clk_c), .CE(pwr));   // display.v(28[8] 344[8])
    DFFC LED_B_118 (.Q(LED_B_c), .D(LED_B_N_47), .CLK(clk_c), .CE(pwr));   // display.v(28[8] 344[8])
    DFFC LED_C_119 (.Q(LED_C_c), .D(LED_C_N_56), .CLK(clk_c), .CE(pwr));   // display.v(28[8] 344[8])
    DFFC LED_D_120 (.Q(LED_D_c), .D(LED_D_N_65), .CLK(clk_c), .CE(pwr));   // display.v(28[8] 344[8])
    DFFC LED_E_121 (.Q(LED_E_c), .D(LED_E_N_74), .CLK(clk_c), .CE(pwr));   // display.v(28[8] 344[8])
    DFFC LED_F_122 (.Q(LED_F_c), .D(LED_F_N_83), .CLK(clk_c), .CE(pwr));   // display.v(28[8] 344[8])
    DFFC LED_G_123 (.Q(LED_G_c), .D(LED_G_N_92), .CLK(clk_c), .CE(pwr));   // display.v(28[8] 344[8])
    DFF scancnt__i0 (.Q(scancnt[0]), .D(n6), .CLK(clk_c));   // display.v(19[10] 25[24])
    DFFC LED_VCC4_127 (.Q(LED_VCC4_c), .D(n300), .CLK(clk_c), .CE(pwr));   // display.v(28[8] 344[8])
    DFFR count_196__i0 (.Q(count[0]), .D(n70), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    AND2 i1364 (.O(n1420), .I0(n426), .I1(n1419));
    OR2 i602 (.O(n14_adj_27), .I0(num4_c_2), .I1(num4_c_1));
    AND2 i598 (.O(n75), .I0(n25), .I1(n60));
    AND2 i597 (.O(n74), .I0(n25), .I1(n59));
    AND2 i1206 (.O(n1262), .I0(LED_VCC2_N_109), .I1(LED_C_N_62));
    DFFC scancnt__i1 (.Q(scancnt[1]), .D(n1159), .CLK(clk_c), .CE(n4));   // display.v(19[10] 25[24])
    AND2 i1247 (.O(n1303), .I0(n3), .I1(LED_C_N_58));
    AND2 i940 (.O(n997), .I0(n990), .I1(count[5]));
    AND2 i1244 (.O(n1300), .I0(n3), .I1(LED_B_N_49));
    AND2 i954 (.O(n1011), .I0(n1004), .I1(count[7]));
    AND2 i1361 (.O(n1417), .I0(n429), .I1(n3_adj_26));
    AND2 i593 (.O(n6_adj_25), .I0(num4_c_1), .I1(num4_c_0));
    AND2 i1358 (.O(n1414), .I0(n429), .I1(n3_adj_24));
    OBUF LED_VCC4_pad (.O(LED_VCC4), .I0(LED_VCC4_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i1241 (.O(n1297), .I0(n3), .I1(LED_A_N_36));
    AND2 i1_adj_1 (.O(n77), .I0(n62), .I1(n25));
    AND2 i1238 (.O(n1294), .I0(n3_adj_1), .I1(LED_G_N_95));
    OBUF LED_VCC3_pad (.O(LED_VCC3), .I0(LED_VCC3_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i1338 (.O(n1394), .I0(num3_c_3), .I1(n14_adj_17));
    AND2 i1235 (.O(n1291), .I0(n3_adj_1), .I1(LED_F_N_86));
    AND2 i1_adj_2 (.O(n82), .I0(n67), .I1(n25));
    AND2 i1232 (.O(n1288), .I0(n3_adj_1), .I1(LED_E_N_77));
    OR2 i378 (.O(n438), .I0(n429), .I1(num4_c_1));
    AND2 i1229 (.O(n1285), .I0(n3_adj_1), .I1(LED_D_N_68));
    AND2 i1226 (.O(n1282), .I0(n3_adj_1), .I1(LED_C_N_59));
    AND2 i1223 (.O(n1279), .I0(n3_adj_1), .I1(LED_B_N_50));
    OR2 i329 (.O(n389), .I0(n386), .I1(num1_c_1));
    XOR2 i986 (.O(n58), .I0(n1039), .I1(count[12]));
    OBUF LED_VCC2_pad (.O(LED_VCC2), .I0(LED_VCC2_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFR count_196__i12 (.Q(count[12]), .D(n73), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    AND2 i1220 (.O(n1276), .I0(n3_adj_1), .I1(LED_A_N_37));
    AND2 i1355 (.O(n1411), .I0(n426), .I1(n7_adj_23));
    AND2 i1_adj_3 (.O(n78), .I0(n63), .I1(n25));
    AND2 i1_adj_4 (.O(n79), .I0(n64), .I1(n25));
    AND2 i1_adj_5 (.O(n83), .I0(n68), .I1(n25));
    AND2 i1352 (.O(n1408), .I0(n429), .I1(n4_adj_29));
    AND2 i1217 (.O(n1273), .I0(n3_adj_2), .I1(LED_G_N_97));
    OR2 i1339 (.O(LED_F_N_89), .I0(n1394), .I1(n1393));
    OR2 i1187 (.O(n1243), .I0(num4_c_2), .I1(num4_c_0));
    INV equal_172_i4 (.O(LED_VCC3_N_113), .I0(n3_adj_1));
    AND3 i1214 (.O(n1270), .I0(n426), .I1(n3_adj_2), .I2(n1416));
    AND2 i1211 (.O(n1267), .I0(n3_adj_2), .I1(LED_E_N_79));
    AND2 i1_adj_6 (.O(n80), .I0(n65), .I1(n25));
    INV i222 (.O(n2), .I0(scancnt[1]));
    AND3 i1208 (.O(n1264), .I0(n426), .I1(n3_adj_2), .I2(n1410));
    AND2 i2 (.O(n13), .I0(count[10]), .I1(count[2]));
    AND4 i1205 (.O(n1261), .I0(n426), .I1(num4_c_1), .I2(n3_adj_2), 
         .I3(n5_adj_13));
    AND4 i1202 (.O(n1258), .I0(num4_c_2), .I1(n6_adj_22), .I2(n3_adj_2), 
         .I3(n426));
    AND2 i1341 (.O(n1397), .I0(num3_c_2), .I1(n6_adj_19));
    AND2 i1270 (.O(n1326), .I0(num1_c_3), .I1(n14_adj_5));
    OR2 i1342 (.O(n1398), .I0(n1397), .I1(n1396));
    OR3 i525 (.O(LED_A_N_34), .I0(n1298), .I1(reset_N_17), .I2(n1297));
    OR2 i1222 (.O(LED_A_N_36), .I0(n1277), .I1(n1276));
    AND2 i1_adj_7 (.O(n76), .I0(n61), .I1(n25));
    OBUF LED_VCC1_pad (.O(LED_VCC1), .I0(n241));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i1207 (.O(LED_C_N_59), .I0(n1262), .I1(n1261));
    OR2 i346 (.O(n406), .I0(n397), .I1(num2_c_1));
    OR2 i1271 (.O(LED_C_N_64), .I0(n1326), .I1(n1325));
    XOR2 i258 (.O(n6_adj_22), .I0(num4_c_1), .I1(num4_c_0));
    OBUF LED_G_pad (.O(LED_G), .I0(LED_G_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i1_adj_8 (.O(n81), .I0(n66), .I1(n25));
    XOR2 i916 (.O(n68), .I0(n969), .I1(count[2]));
    AND2 i1209 (.O(n1265), .I0(LED_VCC2_N_109), .I1(LED_D_N_71));
    XOR2 i923 (.O(n67), .I0(n976), .I1(count[3]));
    OBUF LED_F_pad (.O(LED_F), .I0(LED_F_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i355 (.O(n415), .I0(n412), .I1(num3_c_1));
    OR2 i1210 (.O(LED_D_N_68), .I0(n1265), .I1(n1264));
    AND2 i1349 (.O(n1405), .I0(n1318), .I1(n389));
    AND2 i1344 (.O(n1400), .I0(num3_c_3), .I1(n14_adj_21));
    AND2 i1346 (.O(n1402), .I0(n1374), .I1(n415));
    XOR2 i365 (.O(n410), .I0(num3_c_2), .I1(num3_c_0));
    OBUF LED_E_pad (.O(LED_E), .I0(LED_E_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i573 (.O(n14_adj_21), .I0(num3_c_2), .I1(n4_adj_28));
    AND2 i1343 (.O(n1399), .I0(n1374), .I1(n1398));
    OR2 i1345 (.O(LED_G_N_98), .I0(n1400), .I1(n1399));
    OBUF LED_D_pad (.O(LED_D), .I0(LED_D_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i1340 (.O(n1396), .I0(n412), .I1(n3_adj_20));
    XOR2 i372 (.O(n395), .I0(num2_c_2), .I1(num2_c_0));
    OR2 i570 (.O(n14_adj_17), .I0(num3_c_2), .I1(num3_c_1));
    XOR2 i377 (.O(n384), .I0(num1_c_2), .I1(num1_c_0));
    AND2 i1337 (.O(n1393), .I0(n1374), .I1(n1392));
    AND2 i564 (.O(n6_adj_19), .I0(num3_c_1), .I1(num3_c_0));
    INV i1262 (.O(n1318), .I0(num1_c_3));
    OR2 i561 (.O(n3_adj_18), .I0(num3_c_1), .I1(num3_c_0));
    AND2 i1_adj_9 (.O(n4_adj_29), .I0(n3_adj_26), .I1(num4_c_0));
    AND2 i1347 (.O(n1403), .I0(num3_c_3), .I1(n419));
    AND2 i1212 (.O(n1268), .I0(LED_VCC2_N_109), .I1(LED_E_N_80));
    OBUF LED_C_pad (.O(LED_C), .I0(LED_C_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i1348 (.O(n1404), .I0(n1403), .I1(n1402));
    AND2 i1334 (.O(n1390), .I0(n412), .I1(n3_adj_18));
    AND2 i1236 (.O(n1292), .I0(LED_VCC3_N_113), .I1(LED_F_N_90));
    IBUF num4_pad_0 (.O(num4_c_0), .I0(num4[0]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    AND2 i1331 (.O(n1387), .I0(n1374), .I1(n1386));
    AND2 i961 (.O(n1018), .I0(n1011), .I1(count[8]));
    AND2 i3 (.O(n14), .I0(reset_c), .I1(count[5]));
    AND2 i1350 (.O(n1406), .I0(num1_c_3), .I1(n393));
    OR2 i1351 (.O(n1407), .I0(n1406), .I1(n1405));
    AND2 i926 (.O(n983), .I0(n976), .I1(count[3]));
    DFFR count_196__i11 (.Q(count[11]), .D(n74), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_196__i10 (.Q(count[10]), .D(n75), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_196__i9 (.Q(count[9]), .D(n76), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_196__i8 (.Q(count[8]), .D(n77), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_196__i7 (.Q(count[7]), .D(n78), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_196__i6 (.Q(count[6]), .D(n79), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_196__i5 (.Q(count[5]), .D(n80), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_196__i4 (.Q(count[4]), .D(n81), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_196__i3 (.Q(count[3]), .D(n82), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_196__i2 (.Q(count[2]), .D(n83), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    DFFR count_196__i1 (.Q(count[1]), .D(n84), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // display.v(25[16:23])
    AND3 i1328 (.O(n1384), .I0(n3_adj_20), .I1(n412), .I2(num3_c_0));
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
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
    IBUF num1_pad_2 (.O(num1_c_2), .I0(num1[2]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OBUF LED_B_pad (.O(LED_B), .I0(LED_B_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF LED_A_pad (.O(LED_A), .I0(LED_A_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    IBUF num1_pad_3 (.O(num1_c_3), .I0(num1[3]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF reset_pad (.O(reset_c), .I0(reset));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    DFFC LED_A_117 (.Q(LED_A_c), .D(LED_A_N_34), .CLK(clk_c), .CE(pwr));   // display.v(28[8] 344[8])
    AND2 i1_adj_10 (.O(n84), .I0(n69), .I1(n25));
    AND2 i1353 (.O(n1409), .I0(num4_c_2), .I1(n362));
    AND3 i1325 (.O(n1381), .I0(n4_adj_28), .I1(n1374), .I2(n412));
    OR2 i566 (.O(n7_adj_23), .I0(n624), .I1(num4_c_0));
    OR2 i1354 (.O(n1410), .I0(n1409), .I1(n1408));
    AND3 i1356 (.O(n1412), .I0(n4_adj_29), .I1(num4_c_3), .I2(n429));
    AND2 i912 (.O(n969), .I0(count[0]), .I1(count[1]));
    OR3 i2_adj_11 (.O(n25), .I0(n70), .I1(n1233), .I2(n1235));
    XOR2 i249 (.O(n6_adj_15), .I0(num3_c_1), .I1(num3_c_0));
    AND3 i1322 (.O(n1378), .I0(num3_c_2), .I1(n1374), .I2(n6_adj_15));
    OR2 i1237 (.O(LED_F_N_85), .I0(n1292), .I1(n1291));
    OR2 i1213 (.O(LED_E_N_77), .I0(n1268), .I1(n1267));
    AND2 i1239 (.O(n1295), .I0(LED_VCC3_N_113), .I1(LED_G_N_99));
    OR2 i1357 (.O(LED_E_N_79), .I0(n1412), .I1(n1411));
    OR2 i1240 (.O(LED_G_N_94), .I0(n1295), .I1(n1294));
    AND2 i919 (.O(n976), .I0(n969), .I1(count[2]));
    AND2 i1315 (.O(n1371), .I0(n1346), .I1(n1370));
    OR2 i543 (.O(LED_E_N_82), .I0(n601), .I1(num1_c_0));
    AND2 i1359 (.O(n1415), .I0(num4_c_2), .I1(n6_adj_25));
    AND2 i1312 (.O(n1368), .I0(n397), .I1(n3_adj_12));
    AND2 i1242 (.O(n1298), .I0(LED_VCC4_N_117), .I1(LED_A_N_45));
    OR2 i1360 (.O(n1416), .I0(n1415), .I1(n1414));
    AND2 i968 (.O(n1025), .I0(n1018), .I1(count[9]));
    AND2 i1309 (.O(n1365), .I0(n1346), .I1(n1364));
    OR2 i556 (.O(n14_adj_14), .I0(num2_c_2), .I1(num2_c_1));
    AND2 i1362 (.O(n1418), .I0(num4_c_2), .I1(n6_adj_25));
    AND2 i555 (.O(n6_adj_11), .I0(num2_c_1), .I1(num2_c_0));
    OR2 i1363 (.O(n1419), .I0(n1418), .I1(n1417));
    AND2 i1306 (.O(n1362), .I0(n397), .I1(n3_adj_10));
    OR2 i554 (.O(n3_adj_10), .I0(num2_c_1), .I1(num2_c_0));
    AND2 i1365 (.O(n1421), .I0(num4_c_3), .I1(n14_adj_27));
    OR2 i1366 (.O(LED_G_N_97), .I0(n1421), .I1(n1420));
    XOR2 i244 (.O(n10), .I0(num2_c_1), .I1(num2_c_0));
    XOR2 i909 (.O(n69), .I0(count[0]), .I1(count[1]));
    AND2 i1303 (.O(n1359), .I0(n1346), .I1(n7));
    AND2 i975 (.O(n1032), .I0(n1025), .I1(count[10]));
    AND2 i982 (.O(n1039), .I0(n1032), .I1(count[11]));
    AND2 i1215 (.O(n1271), .I0(LED_VCC2_N_109), .I1(LED_F_N_89));
    XOR2 i930 (.O(n66), .I0(n983), .I1(count[4]));
    AND2 i1300 (.O(n1356), .I0(n1346), .I1(n1355));
    XOR2 i937 (.O(n65), .I0(n990), .I1(count[5]));
    AND2 i1245 (.O(n1301), .I0(LED_VCC4_N_117), .I1(LED_B_N_55));
    AND3 i1297 (.O(n1353), .I0(n3_adj_12), .I1(n397), .I2(num2_c_0));
    XOR2 i944 (.O(n64), .I0(n997), .I1(count[6]));
    AND6 i1_adj_12 (.O(n4), .I0(n18), .I1(count[12]), .I2(n16), .I3(n17), 
         .I4(n452), .I5(count[9]));
    XOR2 i951 (.O(n63), .I0(n1004), .I1(count[7]));
    AND3 i1294 (.O(n1350), .I0(num2_c_2), .I1(n1346), .I2(n10));
    XOR2 i958 (.O(n62), .I0(n1011), .I1(count[8]));
    XOR2 i965 (.O(n61), .I0(n1018), .I1(count[9]));
    AND2 i1183 (.O(n1239), .I0(count[10]), .I1(count[12]));
    AND2 i1248 (.O(n1304), .I0(LED_VCC4_N_117), .I1(LED_C_N_64));
    AND2 i1287 (.O(n1343), .I0(n1318), .I1(n1342));
    OR2 i560 (.O(LED_E_N_80), .I0(n618), .I1(num3_c_0));
    AND2 i1284 (.O(n1340), .I0(n386), .I1(n3_adj_8));
    OR2 i1216 (.O(LED_F_N_86), .I0(n1271), .I1(n1270));
    AND2 i5 (.O(n16), .I0(count[0]), .I1(count[8]));
    INV i1198 (.O(n1235), .I0(n1253));
    AND2 i1193 (.O(n1249), .I0(n1245), .I1(count[8]));
    AND2 i1281 (.O(n1337), .I0(n1318), .I1(n1336));
    AND2 i6 (.O(n17), .I0(n12), .I1(count[3]));
    OR2 i546 (.O(n14_adj_5), .I0(num1_c_2), .I1(num1_c_1));
    AND2 i1251 (.O(n1307), .I0(LED_VCC4_N_117), .I1(LED_D_N_73));
    INV i296 (.O(n356), .I0(n6_adj_3));
    INV i298 (.O(n358), .I0(n10));
    INV i300 (.O(n360), .I0(n6_adj_15));
    AND2 i545 (.O(n6_adj_7), .I0(num1_c_1), .I1(num1_c_0));
    INV i302 (.O(n362), .I0(n6_adj_22));
    INV i262 (.O(n3_adj_26), .I0(num4_c_1));
    AND2 i1218 (.O(n1274), .I0(LED_VCC2_N_109), .I1(LED_G_N_98));
    INV i333 (.O(n393), .I0(n14_adj_5));
    AND2 i1_adj_13 (.O(n12), .I0(count[1]), .I1(count[6]));
    OR2 i544 (.O(n3_adj_6), .I0(num1_c_1), .I1(num1_c_0));
    XOR2 i972 (.O(n60), .I0(n1025), .I1(count[10]));
    INV i581 (.O(n640), .I0(n406));
    XOR2 i979 (.O(n59), .I0(n1032), .I1(count[11]));
    AND2 i933 (.O(n990), .I0(n983), .I1(count[4]));
    AND2 i1278 (.O(n1334), .I0(n386), .I1(n3_adj_6));
    AND2 i1254 (.O(n1310), .I0(LED_VCC4_N_117), .I1(LED_E_N_82));
    AND2 i1275 (.O(n1331), .I0(n1318), .I1(n1330));
    AND2 i1257 (.O(n1313), .I0(LED_VCC4_N_117), .I1(LED_F_N_91));
    AND3 i1272 (.O(n1328), .I0(n3_adj_8), .I1(n386), .I2(num1_c_0));
    INV i366 (.O(n426), .I0(num4_c_3));
    INV i1188 (.O(n5_adj_13), .I0(n1243));
    AND4 i1269 (.O(n1325), .I0(num1_c_1), .I1(n2_adj_4), .I2(n1318), 
         .I3(n386));
    INV i359 (.O(n419), .I0(n14_adj_17));
    OR2 i1219 (.O(LED_G_N_95), .I0(n1274), .I1(n1273));
    AND2 i1189 (.O(n1245), .I0(count[6]), .I1(count[3]));
    INV i369 (.O(n429), .I0(num4_c_2));
    AND3 i2_adj_14 (.O(LED_C_N_63), .I0(num2_c_1), .I1(n2_adj_9), .I2(n397));
    INV i253 (.O(n3_adj_20), .I0(num3_c_1));
    INV i565 (.O(n624), .I0(n438));
    XOR2 i229 (.O(n6_adj_3), .I0(num1_c_1), .I1(num1_c_0));
    INV i559 (.O(n618), .I0(n1404));
    AND3 i1266 (.O(n1322), .I0(num1_c_2), .I1(n1318), .I2(n6_adj_3));
    INV i611 (.O(n452), .I0(n1233));
    INV i250 (.O(n2_adj_16), .I0(num3_c_0));
    XOR2 i15 (.O(n1159), .I0(scancnt[0]), .I1(scancnt[1]));
    INV i352 (.O(n412), .I0(num3_c_2));
    INV i1318 (.O(n1374), .I0(num3_c_3));
    AND2 i7 (.O(n18), .I0(n14), .I1(n13));
    AND2 i1273 (.O(n1329), .I0(num1_c_2), .I1(n356));
    AND2 i1260 (.O(n1316), .I0(LED_VCC4_N_117), .I1(LED_G_N_100));
    OR2 equal_173_i3 (.O(n3_adj_2), .I0(n2), .I1(scancnt[0]));
    OR2 equal_172_i3 (.O(n3_adj_1), .I0(scancnt[1]), .I1(n1));
    INV i246 (.O(n3_adj_12), .I0(num2_c_1));
    OR2 i1274 (.O(n1330), .I0(n1329), .I1(n1328));
    AND2 i1276 (.O(n1332), .I0(num1_c_3), .I1(n14_adj_5));
    XOR2 i303 (.O(n5), .I0(n4), .I1(scancnt[0]));
    INV i245 (.O(n2_adj_9), .I0(num2_c_0));
    INV i907 (.O(n70), .I0(count[0]));
    OR2 i1277 (.O(LED_D_N_73), .I0(n1332), .I1(n1331));
    VCC i992 (.X(pwr));
    INV i337 (.O(n397), .I0(num2_c_2));
    AND2 i1279 (.O(n1335), .I0(num1_c_2), .I1(n6_adj_7));
    AND2 i1221 (.O(n1277), .I0(LED_VCC3_N_113), .I1(LED_A_N_43));
    AND3 i1263 (.O(n1319), .I0(n3_adj_8), .I1(n1318), .I2(n384));
    AND2 i535 (.O(n300), .I0(reset_c), .I1(LED_VCC4_N_117));
    INV i1290 (.O(n1346), .I0(num2_c_3));
    OR2 i1280 (.O(n1336), .I0(n1335), .I1(n1334));
    AND2 i1282 (.O(n1338), .I0(num1_c_3), .I1(n14_adj_5));
    AND3 i208 (.O(n292), .I0(scancnt[1]), .I1(scancnt[0]), .I2(n4));
    AND2 i1_adj_15 (.O(n4_adj_28), .I0(num3_c_1), .I1(n2_adj_16));
    AND2 i947 (.O(n1004), .I0(n997), .I1(count[6]));
    OR2 i1283 (.O(LED_F_N_91), .I0(n1338), .I1(n1337));
    AND2 i1264 (.O(n1320), .I0(num1_c_3), .I1(n14_adj_5));
    AND4 i1199 (.O(n1255), .I0(n3_adj_26), .I1(n421), .I2(n3_adj_2), 
         .I3(n426));
    OR2 i1265 (.O(LED_A_N_45), .I0(n1320), .I1(n1319));
    OR2 equal_171_i3 (.O(n3), .I0(scancnt[1]), .I1(scancnt[0]));
    AND2 i1267 (.O(n1323), .I0(num1_c_3), .I1(n14_adj_5));
    AND2 i1285 (.O(n1341), .I0(num1_c_2), .I1(n6_adj_7));
    OR2 i1286 (.O(n1342), .I0(n1341), .I1(n1340));
    OR2 i1268 (.O(LED_B_N_55), .I0(n1323), .I1(n1322));
    AND2 i1288 (.O(n1344), .I0(num1_c_3), .I1(n14_adj_5));
    OR2 i1289 (.O(LED_G_N_100), .I0(n1344), .I1(n1343));
    AND3 i1291 (.O(n1347), .I0(n3_adj_12), .I1(n1346), .I2(n395));
    AND2 i1200 (.O(n1256), .I0(LED_VCC2_N_109), .I1(LED_A_N_41));
    AND2 i1292 (.O(n1348), .I0(num2_c_3), .I1(LED_C_N_63));
    OR2 i1201 (.O(LED_A_N_37), .I0(n1256), .I1(n1255));
    OR2 i1293 (.O(LED_A_N_43), .I0(n1348), .I1(n1347));
    XOR2 i382 (.O(n421), .I0(num4_c_2), .I1(num4_c_0));
    INV i233 (.O(n3_adj_8), .I0(num1_c_1));
    AND2 i1295 (.O(n1351), .I0(num2_c_3), .I1(LED_C_N_63));
    OR2 i1296 (.O(LED_B_N_54), .I0(n1351), .I1(n1350));
    AND3 i2_adj_16 (.O(n298), .I0(n2), .I1(scancnt[0]), .I2(reset_c));
    OR3 i2_adj_17 (.O(n1233), .I0(count[7]), .I1(count[11]), .I2(count[4]));
    AND2 i532 (.O(n6), .I0(n582), .I1(n5));
    OR3 i531 (.O(LED_G_N_92), .I0(n1316), .I1(reset_N_17), .I2(n1315));
    AND2 i1298 (.O(n1354), .I0(num2_c_2), .I1(n358));
    OR2 i1299 (.O(n1355), .I0(n1354), .I1(n1353));
    AND2 i1301 (.O(n1357), .I0(num2_c_3), .I1(LED_C_N_63));
    OR2 i1302 (.O(LED_D_N_72), .I0(n1357), .I1(n1356));
    AND3 i2_adj_18 (.O(n296), .I0(reset_c), .I1(n1), .I2(scancnt[1]));
    AND3 i1304 (.O(n1360), .I0(n397), .I1(num2_c_3), .I2(n10));
    OR2 i1305 (.O(LED_E_N_81), .I0(n1360), .I1(n1359));
    AND6 i1197 (.O(n1253), .I0(count[1]), .I1(n1249), .I2(count[9]), 
         .I3(n1239), .I4(count[2]), .I5(count[5]));
    AND2 i1307 (.O(n1363), .I0(num2_c_2), .I1(n6_adj_11));
    OR2 i1308 (.O(n1364), .I0(n1363), .I1(n1362));
    AND2 i1310 (.O(n1366), .I0(num2_c_3), .I1(LED_C_N_63));
    OR2 i1311 (.O(LED_F_N_90), .I0(n1366), .I1(n1365));
    AND2 i1313 (.O(n1369), .I0(num2_c_2), .I1(n6_adj_11));
    AND2 i1224 (.O(n1280), .I0(LED_VCC3_N_113), .I1(LED_B_N_54));
    OR3 i530 (.O(LED_F_N_83), .I0(n1313), .I1(reset_N_17), .I2(n1312));
    OR2 i1314 (.O(n1370), .I0(n1369), .I1(n1368));
    OR2 i1225 (.O(LED_B_N_49), .I0(n1280), .I1(n1279));
    AND2 i1316 (.O(n1372), .I0(num2_c_3), .I1(n14_adj_14));
    OR2 i1317 (.O(LED_G_N_99), .I0(n1372), .I1(n1371));
    AND3 i1319 (.O(n1375), .I0(n3_adj_20), .I1(n1374), .I2(n410));
    AND2 i1320 (.O(n1376), .I0(num3_c_3), .I1(n14_adj_17));
    OR2 i1321 (.O(LED_A_N_41), .I0(n1376), .I1(n1375));
    INV reset_I_0 (.O(reset_N_17), .I0(reset_c));
    INV i542 (.O(n601), .I0(n1407));
    INV i230 (.O(n2_adj_4), .I0(num1_c_0));
    OR3 i529 (.O(LED_E_N_74), .I0(n1310), .I1(reset_N_17), .I2(n1309));
    OR3 i528 (.O(LED_D_N_65), .I0(n1307), .I1(reset_N_17), .I2(n1306));
    AND2 i1323 (.O(n1379), .I0(num3_c_3), .I1(n14_adj_17));
    INV equal_171_i4 (.O(LED_VCC4_N_117), .I0(n3));
    OR2 i1324 (.O(LED_B_N_53), .I0(n1379), .I1(n1378));
    AND2 i1227 (.O(n1283), .I0(LED_VCC3_N_113), .I1(LED_C_N_63));
    OR2 i1228 (.O(LED_C_N_58), .I0(n1283), .I1(n1282));
    AND2 i1326 (.O(n1382), .I0(num3_c_3), .I1(n14_adj_17));
    OR2 i1327 (.O(LED_C_N_62), .I0(n1382), .I1(n1381));
    AND2 i1230 (.O(n1286), .I0(LED_VCC3_N_113), .I1(LED_D_N_72));
    INV i225 (.O(n1), .I0(scancnt[0]));
    INV i326 (.O(n386), .I0(num1_c_2));
    INV i523 (.O(n582), .I0(n292));
    INV equal_173_i4 (.O(LED_VCC2_N_109), .I0(n3_adj_2));
    
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

//
// Verilog Description of module AND3
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

