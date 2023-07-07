// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Thu May 25 00:20:09 2023
//
// Verilog Description of module SERIAL
//

module SERIAL (clk, reset, dout, Rx, Tx, Data1, Data2) /* synthesis syn_module_defined=1 */ ;   // serial.v(1[8:14])
    input clk;   // serial.v(2[11:14])
    input reset;   // serial.v(2[15:20])
    input dout;   // serial.v(2[24:28])
    input Rx;   // serial.v(2[21:23])
    output Tx;   // serial.v(3[12:14])
    output [3:0]Data1;   // serial.v(4[18:23])
    output [3:0]Data2;   // serial.v(5[18:23])
    
    wire clk_c /* synthesis SET_AS_NETWORK=clk_c, is_clock=1 */ ;   // serial.v(2[11:14])
    wire dout_c /* synthesis is_clock=1, SET_AS_NETWORK=dout_c */ ;   // serial.v(2[24:28])
    wire Clock9600 /* synthesis is_clock=1, SET_AS_NETWORK=Clock9600 */ ;   // serial.v(12[9:18])
    wire Clock16 /* synthesis is_clock=1, SET_AS_NETWORK=Clock16 */ ;   // serial.v(12[19:26])
    wire Rx_Valid /* synthesis is_clock=1 */ ;   // serial.v(12[53:61])
    wire Rx_Valid_N_3 /* synthesis is_inv_clock=1, SET_AS_NETWORK=Rx_Valid_N_3, is_clock=1 */ ;   // serial.v(4[18:23])
    
    wire n699, n743, reset_c, Rx_c, Tx_c, Data1_c_3, Data1_c_2, 
        Data1_c_1, Data1_c_0, Data2_c_3, Data2_c_2, Data2_c_1, Data2_c_0;
    wire [9:0]ClockCount;   // serial.v(10[15:25])
    wire [5:0]ClockCount_Rx;   // serial.v(11[15:28])
    
    wire Send_en, Send_over;
    wire [3:0]Send_count;   // serial.v(13[15:25])
    wire [9:0]Send_data;   // serial.v(14[15:24])
    
    wire n58, n2046;
    wire [7:0]m;   // serial.v(15[15:16])
    wire [7:0]Rx_Data;   // serial.v(16[15:22])
    
    wire Clock9600_N_108, n2014, n866, n4, n2044, n2023, n2043, 
        Clock16_N_110, n1950, n1968, n55, n1810, n2039, n2020, 
        n8, n1423, n2019, n1963, n5, n1960, Send_count_3__N_80;
    wire [31:0]Send_count_3__N_76;
    
    wire Tx_N_105, n1976, n1614, Send_data_9__N_42;
    wire [31:0]m_7__N_89;
    
    wire n2018, n54, n53;
    wire [7:0]m_7__N_44;
    
    wire n1425, n7, n2017, n1153, n1881, n2016, n1972, n52, 
        n67, n66, n1789, n51, n65, n64, n63, n1971, n1958, 
        n894, n1860, n1160, n2015, n6, n11, n2052, n2042, n2051, 
        n2049, n1146, n2002, n1952, n16, n1969, n1953, n1448, 
        n12, n43, n42, n41, n40, n39, n2033, n2012, n2048, 
        n50, n49, n62, n2022, n48, n47, n61, n2040, n46, n60, 
        n2034, n59, n2030, n2038, n1942, n2031, n2011, n1466, 
        n2037, n2010, n1973, n1463, n1106, n1125, n2027, n1460, 
        n1139, n1964, n1132, n38, n35, n34, n33, n32, n31, 
        n30, n1462, n2028, n1997, n1993, n1999, n2050, n2009, 
        n2008, n5_adj_1, n1221, n2000, n2036, n1967, n1867, n1984, 
        n1948, n1982, n1970, n6_adj_2, n1979, n2025, n2007, n4_adj_3, 
        n1978, n1893, n1917, n1916, n2047, n52_adj_4, n1796, n1424, 
        n1956, n1461, n1465, n2006, n2005, n4_adj_5, n4_adj_6, 
        n1469, n4_adj_7, n1874, n1824, n1838, n1817, n1831, n1803, 
        n4_adj_8, n1452, n1367, n2004, n2003, n1468;
    
    IBUF reset_pad (.O(reset_c), .I0(reset));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OR2 i1_adj_1 (.O(n52_adj_4), .I0(n1963), .I1(n1953));
    AND3 i1_adj_2 (.O(n1978), .I0(n1463), .I1(n4_adj_3), .I2(n5));
    AND4 i1239 (.O(n2050), .I0(n5), .I1(Rx_c), .I2(n4), .I3(n866));
    AND2 i1202 (.O(Clock9600_N_108), .I0(n2012), .I1(n2011));
    AND2 i822 (.O(m_7__N_44[4]), .I0(n1367), .I1(m_7__N_89[4]));
    XOR2 i326 (.O(m_7__N_89[5]), .I0(n1146), .I1(m[5]));
    AND2 i1_adj_3 (.O(n60), .I0(n48), .I1(n2010));
    DFFCR Rx_Valid_102 (.Q(Rx_Valid), .D(n894), .CLK(Clock16), .CE(n1969), 
          .R(reset_c));   // serial.v(79[9] 103[12])
    DFFR m_i0 (.Q(m[0]), .D(m_7__N_44[0]), .CLK(Clock16), .R(reset_c));   // serial.v(79[9] 103[12])
    AND2 i1_adj_4 (.O(n64), .I0(n52), .I1(n2002));
    OR3 i2_adj_5 (.O(n1948), .I0(ClockCount_Rx[4]), .I1(ClockCount_Rx[3]), 
        .I2(n1960));
    DFFR Data1_i1 (.Q(Data1_c_0), .D(Rx_Data[0]), .CLK(Rx_Valid_N_3), 
         .R(reset_c));   // serial.v(111[9] 114[12])
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    AND2 i1_adj_6 (.O(n67), .I0(n55), .I1(n1950));
    AND2 i300 (.O(n1125), .I0(m[0]), .I1(m[1]));
    OR2 i1_adj_7 (.O(n1452), .I0(m[6]), .I1(m[4]));
    AND2 i314 (.O(n1139), .I0(n1132), .I1(m[3]));
    GND i1 (.X(n699));
    AND2 i1218 (.O(n1461), .I0(n2028), .I1(n2027));
    DFFR Data2_i1 (.Q(Data2_c_0), .D(Rx_Data[4]), .CLK(Rx_Valid_N_3), 
         .R(reset_c));   // serial.v(111[9] 114[12])
    AND2 i1229 (.O(n2040), .I0(m[7]), .I1(m[3]));
    DFFRH Send_data_i1 (.Q(Send_data[7]), .D(n743), .CLK(dout_c), .R(Send_data_9__N_42));   // serial.v(55[13] 59[16])
    DFFSH Tx_98 (.Q(Tx_c), .D(Tx_N_105), .CLK(Clock9600), .S(Send_en));   // serial.v(43[14] 45[75])
    OR2 i1_adj_8 (.O(n1466), .I0(n1452), .I1(n866));
    DFFCRH Send_count_i0_i3 (.Q(Send_count[3]), .D(Send_count_3__N_76[3]), 
           .CLK(Clock9600), .CE(n7), .R(Send_en));   // serial.v(43[14] 45[75])
    AND2 i821 (.O(m_7__N_44[5]), .I0(n1367), .I1(m_7__N_89[5]));
    OR2 i1_adj_9 (.O(n1463), .I0(n1452), .I1(m[5]));
    DFFCRH Send_count_i0_i2 (.Q(Send_count[2]), .D(Send_count_3__N_76[2]), 
           .CLK(Clock9600), .CE(n7), .R(Send_en));   // serial.v(43[14] 45[75])
    AND2 i1221 (.O(n1468), .I0(n2031), .I1(n2030));
    OR2 i1230 (.O(n11), .I0(n2040), .I1(n2039));
    DFFC Clock16_94 (.Q(Clock16), .D(Clock16_N_110), .CLK(clk_c), .CE(reset_c));   // serial.v(24[9] 32[12])
    XOR2 i1004 (.O(n50), .I0(n1810), .I1(ClockCount[5]));
    AND2 i1_adj_10 (.O(n63), .I0(n51), .I1(n2008));
    AND2 i1_adj_11 (.O(n1971), .I0(n1448), .I1(m[6]));
    AND2 i1224 (.O(m_7__N_44[0]), .I0(n2034), .I1(n2033));
    XOR2 i15 (.O(n1942), .I0(m[7]), .I1(n1463));
    AND2 i1057 (.O(n1867), .I0(n1860), .I1(ClockCount_Rx[2]));
    XOR2 i1047 (.O(n34), .I0(ClockCount_Rx[0]), .I1(ClockCount_Rx[1]));
    AND2 i1_adj_12 (.O(n61), .I0(n49), .I1(n2007));
    OBUF Data2_pad_0 (.O(Data2[0]), .I0(Data2_c_0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    XOR2 i1011 (.O(n49), .I0(n1817), .I1(ClockCount[6]));
    AND2 i1071 (.O(n1881), .I0(n1874), .I1(ClockCount_Rx[4]));
    XOR2 i1075 (.O(n30), .I0(n1881), .I1(ClockCount_Rx[5]));
    IBUF Rx_pad (.O(Rx_c), .I0(Rx));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    INV i1209 (.O(n2020), .I0(n1948));
    OBUF Data2_pad_1 (.O(Data2[1]), .I0(Data2_c_1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i820 (.O(m_7__N_44[1]), .I0(n1367), .I1(m_7__N_89[1]));
    AND2 i1226 (.O(n2037), .I0(m[3]), .I1(m[4]));
    AND2 i1_adj_13 (.O(n1424), .I0(n866), .I1(n1423));
    DFFCRH Send_count_i0_i1 (.Q(Send_count[1]), .D(Send_count_3__N_76[1]), 
           .CLK(Clock9600), .CE(n7), .R(Send_en));   // serial.v(43[14] 45[75])
    AND2 i1228 (.O(n2039), .I0(n5), .I1(n6));
    XOR2 i1018 (.O(n48), .I0(n1824), .I1(ClockCount[7]));
    INV i6 (.O(n866), .I0(m[5]));
    DFFC Clock9600_92 (.Q(Clock9600), .D(Clock9600_N_108), .CLK(clk_c), 
         .CE(reset_c));   // serial.v(24[9] 32[12])
    AND2 i1_adj_14 (.O(n43), .I0(n35), .I1(n1948));
    AND2 i816 (.O(m_7__N_44[3]), .I0(n1367), .I1(m_7__N_89[3]));
    AND2 i986 (.O(n1796), .I0(n1789), .I1(ClockCount[2]));
    INV i5 (.O(n5), .I0(m[7]));
    OR2 i1227 (.O(n2038), .I0(n2037), .I1(n2036));
    AND2 i1215 (.O(n1462), .I0(n2025), .I1(m[5]));
    AND2 i2_adj_15 (.O(n1893), .I0(n4_adj_8), .I1(Send_count[2]));
    DFFCSH Send_over_99 (.Q(Send_over), .D(n699), .CLK(Clock9600), .CE(Send_count_3__N_80), 
           .S(Send_en));   // serial.v(43[14] 45[75])
    AND2 i1_adj_16 (.O(n1970), .I0(n1968), .I1(n1952));
    XOR2 i1054 (.O(n33), .I0(n1860), .I1(ClockCount_Rx[2]));
    AND2 i1_adj_17 (.O(n1969), .I0(n1968), .I1(n52_adj_4));
    XOR2 i997 (.O(n51), .I0(n1803), .I1(ClockCount[4]));
    AND2 i1050 (.O(n1860), .I0(ClockCount_Rx[0]), .I1(ClockCount_Rx[1]));
    AND2 i1_adj_18 (.O(n1423), .I0(n1448), .I1(n16));
    AND2 i1007 (.O(n1817), .I0(n1810), .I1(ClockCount[5]));
    DFFRH Send_count_i0_i0 (.Q(Send_count[0]), .D(n8), .CLK(Clock9600), 
          .R(Send_en));   // serial.v(43[14] 45[75])
    AND5 i3 (.O(n1963), .I0(n1979), .I1(n6_adj_2), .I2(n16), .I3(m[3]), 
         .I4(m[7]));
    AND3 i1232 (.O(n2043), .I0(n2049), .I1(n2042), .I2(Send_data[7]));
    AND2 i1_adj_19 (.O(n62), .I0(n50), .I1(n2006));
    AND2 i1_adj_20 (.O(n66), .I0(n54), .I1(n2005));
    DFFC ClockCount_281__i0 (.Q(ClockCount[0]), .D(n67), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(26[49:61])
    AND3 i1233 (.O(n2044), .I0(n1964), .I1(Send_count[3]), .I2(Send_count[0]));
    AND2 i1_adj_21 (.O(n1953), .I0(n2038), .I1(n1952));
    AND2 i1_adj_22 (.O(n4_adj_8), .I0(Send_count[1]), .I1(Send_count[0]));
    AND2 i1_adj_23 (.O(n59), .I0(n47), .I1(n2004));
    OBUF Data2_pad_2 (.O(Data2[2]), .I0(Data2_c_2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    XOR2 i1068 (.O(n31), .I0(n1874), .I1(ClockCount_Rx[4]));
    DFFC ClockCount_Rx_280__i0 (.Q(ClockCount_Rx[0]), .D(n43), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(29[51:66])
    OR2 i1234 (.O(Tx_N_105), .I0(n2044), .I1(n2043));
    OBUF Data2_pad_3 (.O(Data2[3]), .I0(Data2_c_3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i804 (.O(n894), .I0(n1469), .I1(m[3]));
    DFFC Rx_Data_i0_i0 (.Q(Rx_Data[0]), .D(Rx_c), .CLK(Clock16), .CE(n1424));   // serial.v(79[9] 103[12])
    OBUF Data1_pad_0 (.O(Data1[0]), .I0(Data1_c_0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF Data1_pad_1 (.O(Data1[1]), .I0(Data1_c_1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF Data1_pad_2 (.O(Data1[2]), .I0(Data1_c_2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF Data1_pad_3 (.O(Data1[3]), .I0(Data1_c_3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF Tx_pad (.O(Tx), .I0(Tx_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFR Data2_i4 (.Q(Data2_c_3), .D(Rx_Data[7]), .CLK(Rx_Valid_N_3), 
         .R(reset_c));   // serial.v(111[9] 114[12])
    AND3 i2_adj_24 (.O(n1967), .I0(n4_adj_5), .I1(n4_adj_6), .I2(n2052));
    XOR2 i1032 (.O(n46), .I0(n1838), .I1(ClockCount[9]));
    AND2 i1014 (.O(n1824), .I0(n1817), .I1(ClockCount[6]));
    XOR2 i976 (.O(n54), .I0(ClockCount[0]), .I1(ClockCount[1]));
    DFFR Data2_i3 (.Q(Data2_c_2), .D(Rx_Data[6]), .CLK(Rx_Valid_N_3), 
         .R(reset_c));   // serial.v(111[9] 114[12])
    DFFR Data2_i2 (.Q(Data2_c_1), .D(Rx_Data[5]), .CLK(Rx_Valid_N_3), 
         .R(reset_c));   // serial.v(111[9] 114[12])
    DFFR Data1_i4 (.Q(Data1_c_3), .D(Rx_Data[3]), .CLK(Rx_Valid_N_3), 
         .R(reset_c));   // serial.v(111[9] 114[12])
    DFFR Data1_i3 (.Q(Data1_c_2), .D(Rx_Data[2]), .CLK(Rx_Valid_N_3), 
         .R(reset_c));   // serial.v(111[9] 114[12])
    DFFR Data1_i2 (.Q(Data1_c_1), .D(Rx_Data[1]), .CLK(Rx_Valid_N_3), 
         .R(reset_c));   // serial.v(111[9] 114[12])
    DFFR m_i7 (.Q(m[7]), .D(m_7__N_44[7]), .CLK(Clock16), .R(reset_c));   // serial.v(79[9] 103[12])
    DFFR m_i6 (.Q(m[6]), .D(m_7__N_44[6]), .CLK(Clock16), .R(reset_c));   // serial.v(79[9] 103[12])
    DFFR m_i5 (.Q(m[5]), .D(m_7__N_44[5]), .CLK(Clock16), .R(reset_c));   // serial.v(79[9] 103[12])
    DFFR m_i4 (.Q(m[4]), .D(m_7__N_44[4]), .CLK(Clock16), .R(reset_c));   // serial.v(79[9] 103[12])
    DFFR m_i3 (.Q(m[3]), .D(m_7__N_44[3]), .CLK(Clock16), .R(reset_c));   // serial.v(79[9] 103[12])
    DFFR m_i2 (.Q(m[2]), .D(m_7__N_44[2]), .CLK(Clock16), .R(reset_c));   // serial.v(79[9] 103[12])
    DFFR m_i1 (.Q(m[1]), .D(m_7__N_44[1]), .CLK(Clock16), .R(reset_c));   // serial.v(79[9] 103[12])
    AND2 i1021 (.O(n1831), .I0(n1824), .I1(ClockCount[7]));
    XOR2 i983 (.O(n53), .I0(n1789), .I1(ClockCount[2]));
    OR5 i2_adj_25 (.O(n1106), .I0(n4), .I1(m[2]), .I2(n1916), .I3(n5_adj_1), 
        .I4(n1917));
    AND2 i1_adj_26 (.O(n1425), .I0(m[5]), .I1(n1423));
    AND3 i2_adj_27 (.O(n1952), .I0(n11), .I1(n16), .I2(n866));
    AND2 i1028 (.O(n1838), .I0(n1831), .I1(ClockCount[8]));
    AND3 i1171 (.O(n1982), .I0(ClockCount_Rx[2]), .I1(ClockCount_Rx[5]), 
         .I2(ClockCount_Rx[1]));
    AND2 i1_adj_28 (.O(n41), .I0(n33), .I1(n2015));
    OR3 i1173 (.O(n1984), .I0(m[2]), .I1(m[0]), .I2(m[1]));
    AND2 i993 (.O(n1803), .I0(n1796), .I1(ClockCount[3]));
    AND2 i1_adj_29 (.O(n1972), .I0(n1971), .I1(n866));
    XOR2 i319 (.O(m_7__N_89[4]), .I0(n1139), .I1(m[4]));
    DFFC Rx_Data_i0_i6 (.Q(Rx_Data[6]), .D(Rx_c), .CLK(Clock16), .CE(n1973));   // serial.v(79[9] 103[12])
    DFFC Rx_Data_i0_i4 (.Q(Rx_Data[4]), .D(Rx_c), .CLK(Clock16), .CE(n1972));   // serial.v(79[9] 103[12])
    DFFC Rx_Data_i0_i2 (.Q(Rx_Data[2]), .D(Rx_c), .CLK(Clock16), .CE(n1425));   // serial.v(79[9] 103[12])
    AND2 i815 (.O(m_7__N_44[6]), .I0(n1367), .I1(m_7__N_89[6]));
    DFFC ClockCount_281__i1 (.Q(ClockCount[1]), .D(n66), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(26[49:61])
    IBUF dout_pad (.O(dout_c), .I0(dout));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    XOR2 i312 (.O(m_7__N_89[3]), .I0(n1132), .I1(m[3]));
    AND2 i819 (.O(m_7__N_44[2]), .I0(n1367), .I1(m_7__N_89[2]));
    AND2 i1210 (.O(Clock16_N_110), .I0(n2020), .I1(n2019));
    AND2 i1_adj_30 (.O(n65), .I0(n53), .I1(n2003));
    AND2 i1_adj_31 (.O(n39), .I0(n31), .I1(n2018));
    AND2 i826 (.O(m_7__N_44[7]), .I0(n1367), .I1(m_7__N_89[7]));
    XOR2 i397 (.O(n8), .I0(n7), .I1(Send_count[0]));
    AND2 i1_adj_32 (.O(n38), .I0(n30), .I1(n2017));
    AND2 i1064 (.O(n1874), .I0(n1867), .I1(ClockCount_Rx[3]));
    AND2 i1236 (.O(n2047), .I0(n2046), .I1(Send_count[1]));
    DFFC ClockCount_281__i2 (.Q(ClockCount[2]), .D(n65), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(26[49:61])
    DFFC ClockCount_281__i3 (.Q(ClockCount[3]), .D(n64), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(26[49:61])
    DFFC ClockCount_281__i4 (.Q(ClockCount[4]), .D(n63), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(26[49:61])
    DFFC ClockCount_281__i5 (.Q(ClockCount[5]), .D(n62), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(26[49:61])
    DFFC ClockCount_281__i6 (.Q(ClockCount[6]), .D(n61), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(26[49:61])
    DFFC ClockCount_281__i7 (.Q(ClockCount[7]), .D(n60), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(26[49:61])
    DFFC ClockCount_281__i8 (.Q(ClockCount[8]), .D(n59), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(26[49:61])
    DFFC ClockCount_281__i9 (.Q(ClockCount[9]), .D(n58), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(26[49:61])
    DFFC ClockCount_Rx_280__i1 (.Q(ClockCount_Rx[1]), .D(n42), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(29[51:66])
    XOR2 i1025 (.O(n47), .I0(n1831), .I1(ClockCount[8]));
    OR3 i2_adj_33 (.O(n1460), .I0(m[4]), .I1(n1106), .I2(n16));
    XOR2 i1061 (.O(n32), .I0(n1867), .I1(ClockCount_Rx[3]));
    XOR2 i990 (.O(n52), .I0(n1796), .I1(ClockCount[3]));
    OR6 i5_adj_34 (.O(n1950), .I0(ClockCount[1]), .I1(ClockCount[3]), 
        .I2(ClockCount[8]), .I3(n1956), .I4(ClockCount[2]), .I5(ClockCount[7]));
    AND2 i1213 (.O(n1465), .I0(n2023), .I1(n2022));
    DFFC ClockCount_Rx_280__i2 (.Q(ClockCount_Rx[2]), .D(n41), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(29[51:66])
    DFFC ClockCount_Rx_280__i3 (.Q(ClockCount_Rx[3]), .D(n40), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(29[51:66])
    DFFC ClockCount_Rx_280__i4 (.Q(ClockCount_Rx[4]), .D(n39), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(29[51:66])
    DFFC ClockCount_Rx_280__i5 (.Q(ClockCount_Rx[5]), .D(n38), .CLK(clk_c), 
         .CE(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // serial.v(29[51:66])
    AND2 i1_adj_35 (.O(n1448), .I0(n1221), .I1(m[4]));
    OR2 i1190 (.O(Send_data_9__N_42), .I0(n2000), .I1(n1999));
    AND2 i979 (.O(n1789), .I0(ClockCount[0]), .I1(ClockCount[1]));
    OR2 i1182 (.O(n1993), .I0(n1452), .I1(m[2]));
    XOR2 i668 (.O(Send_count_3__N_76[3]), .I0(Send_count[3]), .I1(n1893));
    AND4 i1186 (.O(n1997), .I0(ClockCount[9]), .I1(ClockCount[6]), .I2(ClockCount[5]), 
         .I3(ClockCount[4]));
    DFFC Rx_Data_i0_i1 (.Q(Rx_Data[1]), .D(Rx_c), .CLK(Clock16), .CE(n1468));   // serial.v(79[9] 103[12])
    AND2 i1000 (.O(n1810), .I0(n1803), .I1(ClockCount[4]));
    OR2 i2_adj_36 (.O(n7), .I0(n4_adj_7), .I1(n1958));
    AND2 i1237 (.O(n2048), .I0(Send_count[2]), .I1(Send_count[0]));
    OR2 i1168 (.O(n1979), .I0(n1978), .I1(m[5]));
    XOR2 i563 (.O(Send_count_3__N_76[2]), .I0(n4_adj_8), .I1(Send_count[2]));
    DFFC Rx_Data_i0_i3 (.Q(Rx_Data[3]), .D(Rx_c), .CLK(Clock16), .CE(n1461));   // serial.v(79[9] 103[12])
    AND2 i328 (.O(n1153), .I0(n1146), .I1(m[5]));
    OR2 i1_adj_37 (.O(n4_adj_7), .I0(Send_count[2]), .I1(Send_count[1]));
    AND2 i335 (.O(n1160), .I0(n1153), .I1(m[6]));
    XOR2 i333 (.O(m_7__N_89[6]), .I0(n1153), .I1(m[6]));
    XOR2 i298 (.O(m_7__N_89[1]), .I0(m[0]), .I1(m[1]));
    AND3 i1240 (.O(n2051), .I0(m[5]), .I1(m[3]), .I2(m[7]));
    OR2 i1238 (.O(n2049), .I0(n2048), .I1(n2047));
    OR2 i1_adj_38 (.O(n4_adj_3), .I0(n12), .I1(m[6]));
    INV i656 (.O(n1469), .I0(n1970));
    INV i1191 (.O(n2002), .I0(Clock9600_N_108));
    DFFC Rx_Data_i0_i5 (.Q(Rx_Data[5]), .D(Rx_c), .CLK(Clock16), .CE(n1462));   // serial.v(79[9] 103[12])
    INV i1183 (.O(n4_adj_5), .I0(n1993));
    INV i1187 (.O(n1956), .I0(n1997));
    INV i1188 (.O(n1999), .I0(Send_over));
    INV i1211 (.O(n2022), .I0(n1106));
    INV i974 (.O(n55), .I0(ClockCount[0]));
    XOR2 i340 (.O(m_7__N_89[7]), .I0(n1160), .I1(m[7]));
    AND2 i1_adj_39 (.O(n42), .I0(n34), .I1(n2016));
    VCC i2 (.X(n743));
    AND2 i1166 (.O(n1976), .I0(Send_count[3]), .I1(Send_count[0]));
    INV i1192 (.O(n2003), .I0(Clock9600_N_108));
    INV i1189 (.O(n2000), .I0(reset_c));
    INV i1107 (.O(n1917), .I0(n1942));
    INV i1193 (.O(n2004), .I0(Clock9600_N_108));
    INV i1179 (.O(n4_adj_6), .I0(n5_adj_1));
    INV i1212 (.O(n2023), .I0(n1463));
    INV i1194 (.O(n2005), .I0(Clock9600_N_108));
    OR2 i802 (.O(n1614), .I0(m[3]), .I1(m[4]));
    INV i1195 (.O(n2006), .I0(Clock9600_N_108));
    AND2 i1_adj_40 (.O(n58), .I0(n46), .I1(n2009));
    AND2 i1_adj_41 (.O(n40), .I0(n32), .I1(n2014));
    INV i1196 (.O(n2007), .I0(Clock9600_N_108));
    OR2 i1_adj_42 (.O(n5_adj_1), .I0(m[1]), .I1(m[0]));
    OR2 i1241 (.O(n2052), .I0(n2051), .I1(n2050));
    INV i1197 (.O(n2008), .I0(Clock9600_N_108));
    INV i1214 (.O(n2025), .I0(n1460));
    INV i1198 (.O(n2009), .I0(Clock9600_N_108));
    INV i1199 (.O(n2010), .I0(Clock9600_N_108));
    INV i1174 (.O(n1968), .I0(n1984));
    INV i1200 (.O(n2011), .I0(ClockCount[0]));
    INV i1201 (.O(n2012), .I0(n1950));
    INV i21 (.O(n6_adj_2), .I0(m[4]));
    AND2 i1_adj_43 (.O(n1973), .I0(n1971), .I1(m[5]));
    DFFC Rx_Data_i0_i7 (.Q(Rx_Data[7]), .D(Rx_c), .CLK(Clock16), .CE(n1465));   // serial.v(79[9] 103[12])
    XOR2 i305 (.O(m_7__N_89[2]), .I0(n1125), .I1(m[2]));
    INV i1235 (.O(n2046), .I0(Send_count[2]));
    INV i1216 (.O(n2027), .I0(m[5]));
    INV i1217 (.O(n2028), .I0(n1460));
    INV i1219 (.O(n2030), .I0(n1106));
    XOR2 i383 (.O(Send_count_3__N_76[1]), .I0(Send_count[1]), .I1(Send_count[0]));
    INV i1106 (.O(n1916), .I0(reset_c));
    INV i1220 (.O(n2031), .I0(n1466));
    INV i1222 (.O(n2033), .I0(m[0]));
    INV i409 (.O(n1221), .I0(n1106));
    INV i1223 (.O(n2034), .I0(n1967));
    INV i1045 (.O(n35), .I0(ClockCount_Rx[0]));
    INV i1172 (.O(n1960), .I0(n1982));
    INV i1203 (.O(n2014), .I0(Clock16_N_110));
    INV i15_adj_44 (.O(n1367), .I0(n1967));
    INV i1204 (.O(n2015), .I0(Clock16_N_110));
    INV i1170 (.O(n1964), .I0(n4_adj_7));
    AND2 i321 (.O(n1146), .I0(n1139), .I1(m[4]));
    INV i16 (.O(n16), .I0(m[6]));
    INV i1205 (.O(n2016), .I0(Clock16_N_110));
    AND2 i307 (.O(n1132), .I0(n1125), .I1(m[2]));
    INV i1231 (.O(n2042), .I0(Send_count[3]));
    INV i1206 (.O(n2017), .I0(Clock16_N_110));
    INV equal_133_i8 (.O(Send_count_3__N_80), .I0(n7));
    DFFSH Send_en_100 (.Q(Send_en), .D(n699), .CLK(dout_c), .S(Send_data_9__N_42));   // serial.v(55[13] 59[16])
    INV i1167 (.O(n1958), .I0(n1976));
    AND2 i1225 (.O(n2036), .I0(n4), .I1(Rx_c));
    INV i12 (.O(n12), .I0(n11));
    INV i803 (.O(n6), .I0(n1614));
    INV Rx_Valid_I_0 (.O(Rx_Valid_N_3), .I0(Rx_Valid));
    INV i1207 (.O(n2018), .I0(Clock16_N_110));
    INV i1208 (.O(n2019), .I0(ClockCount_Rx[0]));
    INV i357 (.O(n4), .I0(m[3]));
    
endmodule
//
// Verilog Description of module OR2
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
// Verilog Description of module AND2
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
// Verilog Description of module GND
// module not written out since it is a black-box. 
//

//
// Verilog Description of module INV
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND5
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR5
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR6
// module not written out since it is a black-box. 
//

//
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

