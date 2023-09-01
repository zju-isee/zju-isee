// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Fri Jun 09 10:00:08 2023
//
// Verilog Description of module CALCULATE
//

module CALCULATE (clk, reset, key_in, led_int_Data0, led_int_Data1, 
            led_int_Data2, key_out, int_Data, flag_Over) /* synthesis syn_module_defined=1 */ ;   // calculate.v(1[8:17])
    input clk;   // calculate.v(3[11:14])
    input reset;   // calculate.v(3[15:20])
    input [3:0]key_in;   // calculate.v(4[17:23])
    output [3:0]led_int_Data0;   // calculate.v(6[18:31])
    output [3:0]led_int_Data1;   // calculate.v(7[18:31])
    output [3:0]led_int_Data2;   // calculate.v(8[18:31])
    output [3:0]key_out;   // calculate.v(9[18:25])
    output [7:0]int_Data;   // calculate.v(10[18:26])
    output flag_Over;   // calculate.v(11[12:21])
    
    wire clk_c /* synthesis SET_AS_NETWORK=clk_c, is_clock=1 */ ;   // calculate.v(3[11:14])
    wire time10ms /* synthesis SET_AS_NETWORK=time10ms, is_clock=1 */ ;   // calculate.v(17[9:17])
    
    wire n3214, led_int_Data2_c, reset_c, key_in_c_3, key_in_c_2, 
        key_in_c_1, key_in_c_0;
    wire [18:0]timecnt;   // calculate.v(16[16:23])
    wire [3:0]scanvalue;   // calculate.v(18[15:24])
    wire [3:0]flag_Data;   // calculate.v(19[15:24])
    
    wire flag_Over_c;
    wire [7:0]int_Data0;   // calculate.v(22[15:24])
    
    wire int_Data_c_7, int_Data_c_6, int_Data_c_5, int_Data_c_4, int_Data_c_3, 
        int_Data_c_2, int_Data_c_1, int_Data_c_0, key_out_c_3, key_out_c_2, 
        key_out_c_1, key_out_c_0, led_int_Data0_c_3, led_int_Data0_c_2, 
        led_int_Data0_c_1, led_int_Data0_c_0, led_int_Data1_c_3, led_int_Data1_c_2, 
        led_int_Data1_c_1, led_int_Data1_c_0, n6107, n31, n6942, n6327, 
        n21, n19, n17, n6320, n6789, n37, n22, n6939, n45, 
        n6326, time10ms_N_284, n5, n104, n97, n117, n51, n49, 
        n48, n6321, n5205;
    wire [3:0]scanvalue_3__N_22;
    
    wire n6301, n3598, n6090, n3455, n6193, n114;
    wire [3:0]flag_Data_3__N_264;
    
    wire n44, n2, n9, n23, n6, n17_adj_1, n6957, n4928, n5085, 
        n4879, n6786, n15, n10, n6114, n6307, n37_adj_2, n11, 
        n116, n5201, n6906, n1936, n6953, n1934, n1933, n1932, 
        n3265, n5079, n6408, n7000, n4822, n5077, n2169, n99, 
        n3627, n6886, n5_adj_3, n1931, n4, n2160, n3575, n6925, 
        n6968, n6965, n6962, n2144, n2155, n2154, n6898, n1, 
        n4_adj_4, n5_adj_5, n3623, n3647, n2143, n2142, n2141, 
        n2139, n6955, n22_adj_6, n23_adj_7, n3644, n6980, n6792, 
        n6979, n6978, n6976, n6285, n1901, n3638, n6950, n2119, 
        n6810, n6934, n6889, n6954, n21_adj_8, n20, n19_adj_9, 
        n18, n6975, n6973, n6972, n6952, n23_adj_10, n5185, n5183, 
        led_int_Data1_3__N_272, n6360, n1099, n3651, n1112, n1893, 
        n1892, n1125, n1889, n1888, n1138, n6364, n2116, n2115, 
        n1151, n2114, n2113, n6970, n6969, n1164, n3689, n2107, 
        n1177, n2105, n6956, n51_adj_11, n3328, n6319, n9_adj_12, 
        n9_adj_13, n6951, n6949, n6990, n2759, n6959, n6948, n6947, 
        n1225, n118, n119, n6967, n6966, n1235, n6964, n6963, 
        n1245, n3572, n1253, n1255, n4837, n1265, n110, n6961, 
        n5071;
    wire [3:0]led_int_Data1_3__N_268;
    
    wire n6340;
    wire [3:0]led_int_Data1_3__N_55;
    wire [3:0]led_int_Data0_3__N_51;
    
    wire n4795, n6799, n6158, n106, n42, n5174, n103, n6960, 
        n4797, n4816, n6958, n4866, n6945, n6919, n4862, n16, 
        n6987, n15_adj_14, n3479, n3, n6981, n6365, n6832, n4_adj_15, 
        n7, n22_adj_16, n6882, n21_adj_17, n120, n3688, n50, n48_adj_18, 
        n4920, n6936, n6877, n5068, n6378, n23_adj_19, n22_adj_20, 
        n6318, n3330, n17_adj_21, n3326, n6103, n3542, n14, n4833, 
        n6876, n5167, n3511, n6874, n4831, n83, n6918, n6944, 
        n4_adj_22, n11_adj_23, n2962, n100, n3442, n6933, n20_adj_24, 
        n19_adj_25, n6281, n22_adj_26, n17_adj_27, n6872, n5067, 
        n6422, n5062, n105, n3503, n56, n4979, n3_adj_28, n22_adj_29, 
        n19_adj_30, n6971, n3529, n6869, n7_adj_31, n5_adj_32, n15_adj_33, 
        n15_adj_34, n3_adj_35, n1_adj_36, n9_adj_37, n11_adj_38, n3481, 
        n5060, n5059, n5147, n6866, n12, n6826, n6330, n6179, 
        n6865, n6165, n6172, n17_adj_39, n6280, n22_adj_40, n23_adj_41, 
        n6922, n15_adj_42, n3454, n6863, n15_adj_43, n6943, n3_adj_44, 
        n21_adj_45, n115, n4851, n8, n10_adj_46, n6355, n20_adj_47, 
        n6861, n6941, n4_adj_48, n6_adj_49, n6896, n9_adj_50, n6828, 
        n4_adj_51, n6870, n3704, n5_adj_52, n6_adj_53, n6_adj_54, 
        n6892, n6855, n4_adj_55, n6880, n3216, n3707, n6843, n4_adj_56, 
        n6841, n5137, n17_adj_57, n6946, n121, n2_adj_58, n1_adj_59, 
        n12_adj_60, n108, n113, n3708, n107, n6884, n4899, n3500, 
        n23_adj_61, n3706, n14_adj_62, n22_adj_63, n6_adj_64, n8_adj_65, 
        n3595, n5_adj_66, n3633, n111, n12_adj_67, n4_adj_68, n98, 
        n6099, n6783, n3514, n6901, n3482, n4_adj_69, n23_adj_70, 
        n4_adj_71, n86, n8_adj_72, n10_adj_73, n3478, n6417, n15_adj_74, 
        n23_adj_75, n12_adj_76, n6940, n6796, n9_adj_77, n6_adj_78, 
        n87, n8_adj_79, n112, n10_adj_80, n6411, n12_adj_81, n3458, 
        n15_adj_82, n6793, n109, n3483, n14_adj_83, n11_adj_84, 
        n6102, n12_adj_85, n8_adj_86, n4947, n6277, n5127, n5008, 
        n6403, n12_adj_87, n6401, n15_adj_88, n6844, n6361, n15_adj_89, 
        n6399, n6144, n3506, n6398, n15_adj_90, n6_adj_91, n5116, 
        n6887, n5_adj_92, n14_adj_93, n3324, n6268, n3705, n15_adj_94, 
        n11_adj_95, n5112, n23_adj_96, n6785, n5111, n3484, n6333, 
        n3485, n40, n84, n6997, n5_adj_97, n6770, n4_adj_98, n90, 
        n17_adj_99, n23_adj_100, n6362, n94, n21_adj_101, n6256, 
        n6938, n6392, n6423, n6389, n6868, n4_adj_102, n6929, 
        n95, n82, n6249, n6094, n23_adj_103, n6242, n6093, n96, 
        n17_adj_104, n88, n92, n23_adj_105, n6764, n6937, n3468, 
        n85, n6235, n89, n6228, n6787, n6931, n6916, n11_adj_106, 
        n3591, n6993, n91, n6367, n6221, n6899, n93, n10_adj_107, 
        n6214, n6849, n4880, n4937, n6930, n6913, n6928, n6782, 
        n4_adj_108, n6207, n4_adj_109, n6927, n6200, n6371, n6370, 
        n6151, n6885, n4996, n6363, n6186, n6121, n6081, n6336, 
        n6848, n6847, n6910, n6842, n18_adj_110, n16_adj_111, n14_adj_112, 
        n6926, n6907, n6924, n6923, n13, n6825, n6893, n12_adj_113, 
        n6822, n6821, n6784, n6781, n6820, n6902, n6800, n6890, 
        n6909, n1_adj_114, n2_adj_115, n6797, n4_adj_116, n6_adj_117, 
        n8_adj_118, n9_adj_119, n4_adj_120, n6818, n6817, n6912, 
        n1_adj_121, n2_adj_122, n6798, n6755, n6_adj_123, n8_adj_124, 
        n6777, n6795, n4_adj_125, n6774, n6815, n4_adj_126, n6920, 
        n6915, n1_adj_127, n2_adj_128, n6834, n6_adj_129, n8_adj_130, 
        n9_adj_131, n7002, n7001, n6999, n6836, n6998, n6995, 
        n6935, n24, n1_adj_132, n2_adj_133, n6780, n6760, n11_adj_134, 
        n23_adj_135, n16_adj_136, n6994, n6992, n6991, n6989, n6988, 
        n6986, n6985, n6984, n6982, n6895, n6804, n6904, n1_adj_137, 
        n5_adj_138, n7_adj_139;
    
    AND3 i4743 (.O(n6968), .I0(n5_adj_52), .I1(n4_adj_22), .I2(int_Data_c_4));
    AND3 i4773 (.O(n6998), .I0(n3326), .I1(key_in_c_2), .I2(n9));
    AND2 i4740 (.O(n6965), .I0(n4862), .I1(n2119));
    OR2 i4613 (.O(n6828), .I0(n5079), .I1(n3572));
    DFFR led_int_Data0_i3 (.Q(led_int_Data0_c_2), .D(led_int_Data0_3__N_51[2]), 
         .CLK(clk_c), .R(reset_c));   // calculate.v(228[13] 270[16])
    AND2 i4737 (.O(n6962), .I0(n4862), .I1(n6367));
    OR2 i4774 (.O(n6999), .I0(n6998), .I1(n6997));
    AND3 i4776 (.O(n7001), .I0(n3328), .I1(key_in_c_2), .I2(n22_adj_20));
    DFFCR int_Data_i0_i1 (.Q(int_Data_c_0), .D(n6924), .CLK(time10ms), 
          .CE(n3688), .R(reset_c));   // calculate.v(60[13] 217[16])
    OR2 i4777 (.O(n7002), .I0(n7001), .I1(n7000));
    INV i4691 (.O(n6916), .I0(n24));
    AND2 i1_adj_1 (.O(n2_adj_133), .I0(n3265), .I1(n1_adj_132));
    OR2 equal_397_i22 (.O(n22_adj_63), .I0(n21_adj_8), .I1(n19_adj_9));
    OR2 i1_adj_2 (.O(n1931), .I0(n6403), .I1(n6781));
    OR2 i1_adj_3 (.O(n8_adj_130), .I0(n4_adj_116), .I1(n6800));
    OBUF led_int_Data0_pad_0 (.O(led_int_Data0[0]), .I0(led_int_Data0_c_0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    DFFC key_out_i0_i1 (.Q(key_out_c_0), .D(scanvalue[0]), .CLK(time10ms), 
         .CE(reset_c));   // calculate.v(60[13] 217[16])
    DFFCR int_Data0_i0_i0 (.Q(int_Data0[0]), .D(n6_adj_129), .CLK(time10ms), 
          .CE(n3689), .R(reset_c));   // calculate.v(60[13] 217[16])
    DFFR led_int_Data1_i1 (.Q(led_int_Data1_c_0), .D(led_int_Data1_3__N_55[0]), 
         .CLK(clk_c), .R(reset_c));   // calculate.v(228[13] 270[16])
    DFFR led_int_Data0_i2 (.Q(led_int_Data0_c_1), .D(led_int_Data0_3__N_51[1]), 
         .CLK(clk_c), .R(reset_c));   // calculate.v(228[13] 270[16])
    AND2 i4698 (.O(n6923), .I0(n2139), .I1(n6949));
    OR2 i4699 (.O(n6924), .I0(n6923), .I1(n6922));
    OR2 i4733 (.O(n6958), .I0(n6957), .I1(n6956));
    OR4 i1_adj_4 (.O(n1), .I0(n6931), .I1(n6930), .I2(n6401), .I3(int_Data_c_7));
    AND3 i2_adj_5 (.O(n6320), .I0(n21), .I1(key_out_c_3), .I2(n42));
    AND2 i1_adj_6 (.O(n2_adj_128), .I0(n3265), .I1(n1_adj_127));
    OR2 equal_397_i23 (.O(n23_adj_61), .I0(n22_adj_63), .I1(n17_adj_39));
    AND3 i2_adj_7 (.O(n1099), .I0(n6411), .I1(n10_adj_46), .I2(n6371));
    AND2 i2670 (.O(n4866), .I0(flag_Data[0]), .I1(flag_Data[1]));
    DFFR led_int_Data0_i1 (.Q(led_int_Data0_c_0), .D(int_Data_c_0), .CLK(clk_c), 
         .R(reset_c));   // calculate.v(228[13] 270[16])
    AND2 i4672 (.O(led_int_Data1_3__N_55[3]), .I0(n6896), .I1(n6895));
    DFFS scanvalue_i0 (.Q(scanvalue[0]), .D(scanvalue_3__N_22[0]), .CLK(time10ms), 
         .S(reset_c));   // calculate.v(60[13] 217[16])
    AND2 i4734 (.O(n6959), .I0(n4862), .I1(n6363));
    DFFR scanvalue_i2 (.Q(scanvalue[2]), .D(scanvalue_3__N_22[2]), .CLK(time10ms), 
         .R(reset_c));   // calculate.v(60[13] 217[16])
    AND2 i2_adj_8 (.O(n1177), .I0(n4_adj_126), .I1(n19_adj_30));
    AND2 i2669 (.O(n2143), .I0(n4862), .I1(n2115));
    AND2 i2668 (.O(n2142), .I0(n4862), .I1(n2114));
    AND3 i1_adj_9 (.O(n6764), .I0(n5_adj_92), .I1(n6378), .I2(n8_adj_65));
    OR2 equal_398_i15 (.O(n15_adj_14), .I0(n17_adj_21), .I1(key_out_c_0));
    AND2 i1_adj_10 (.O(n1138), .I0(n6764), .I1(n5_adj_5));
    OR2 equal_398_i17 (.O(n17_adj_1), .I0(n15_adj_14), .I1(n14_adj_83));
    OR2 equal_398_i22 (.O(n22_adj_29), .I0(n21_adj_45), .I1(n19));
    OR2 i1_adj_11 (.O(n8_adj_124), .I0(n4_adj_116), .I1(n6797));
    AND2 i4701 (.O(n6926), .I0(n6925), .I1(n3572));
    OR2 equal_398_i23 (.O(n23), .I0(n22_adj_29), .I1(n17_adj_1));
    AND2 i4731 (.O(n6956), .I0(n9_adj_50), .I1(int_Data_c_3));
    DFFR scanvalue_i1 (.Q(scanvalue[1]), .D(scanvalue_3__N_22[1]), .CLK(time10ms), 
         .R(reset_c));   // calculate.v(60[13] 217[16])
    AND2 i4702 (.O(n6927), .I0(n5079), .I1(n3216));
    OBUF led_int_Data0_pad_2 (.O(led_int_Data0[2]), .I0(led_int_Data0_c_2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    XOR2 i2_adj_12 (.O(n6363), .I0(n4_adj_125), .I1(n2107));
    OR4 i2_adj_13 (.O(n3572), .I0(n6920), .I1(n17_adj_39), .I2(n6919), 
        .I3(n19_adj_9));
    INV i3927 (.O(n100), .I0(timecnt[0]));
    AND2 i1_adj_14 (.O(n2_adj_122), .I0(n3265), .I1(n1_adj_121));
    AND2 i1_adj_15 (.O(n6782), .I0(n6780), .I1(n6336));
    OR2 equal_399_i21 (.O(n21_adj_45), .I0(n20_adj_47), .I1(key_in_c_1));
    OR2 equal_399_i22 (.O(n22_adj_6), .I0(n21_adj_45), .I1(n19_adj_9));
    AND4 i2_adj_16 (.O(n6799), .I0(n15), .I1(n5062), .I2(n15_adj_43), 
         .I3(n6798));
    OR3 i2_adj_17 (.O(n6336), .I0(n1164), .I1(n6820), .I2(n1151));
    AND3 i2_adj_18 (.O(n6326), .I0(n6938), .I1(key_out_c_0), .I2(key_out_c_2));
    AND2 i1_adj_19 (.O(n6783), .I0(n4899), .I1(int_Data_c_2));
    OR2 i1_adj_20 (.O(n8_adj_118), .I0(n4_adj_116), .I1(n6796));
    OR2 equal_399_i23 (.O(n23_adj_7), .I0(n22_adj_6), .I1(n17_adj_39));
    OR2 i4703 (.O(n6928), .I0(n6927), .I1(n6926));
    IBUF key_in_pad_0 (.O(key_in_c_0), .I0(key_in[0]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    DFFR scanvalue_i3 (.Q(scanvalue[3]), .D(scanvalue_3__N_22[3]), .CLK(time10ms), 
         .R(reset_c));   // calculate.v(60[13] 217[16])
    AND2 i4705 (.O(n6930), .I0(n6929), .I1(n17_adj_27));
    AND3 i1_adj_21 (.O(n9_adj_119), .I0(n4979), .I1(n8_adj_118), .I2(n5112));
    OR2 i2_adj_22 (.O(n11_adj_23), .I0(n4_adj_120), .I1(key_out_c_2));
    AND4 i2_adj_23 (.O(n6777), .I0(n15_adj_90), .I1(n8_adj_124), .I2(n15_adj_33), 
         .I3(n6360));
    OR2 i2_adj_24 (.O(n3647), .I0(n6869), .I1(n1151));
    AND2 i1_adj_25 (.O(n2_adj_115), .I0(n3265), .I1(n1_adj_114));
    AND2 i4683 (.O(n6_adj_117), .I0(n6907), .I1(n6906));
    AND2 i2867 (.O(n5071), .I0(n6), .I1(int_Data_c_3));
    XOR2 i97 (.O(n42), .I0(key_out_c_2), .I1(key_out_c_0));
    XOR2 i96 (.O(n56), .I0(key_in_c_1), .I1(key_in_c_0));
    AND2 i1_adj_26 (.O(n6784), .I0(n6783), .I1(int_Data_c_5));
    AND2 i4728 (.O(n6953), .I0(n5068), .I1(n3468));
    AND2 i1_adj_27 (.O(n6785), .I0(n6783), .I1(int_Data_c_1));
    AND4 i3 (.O(n6307), .I0(n3627), .I1(n3324), .I2(n3_adj_44), .I3(key_in_c_0));
    AND3 i1_adj_28 (.O(n1151), .I0(n6818), .I1(n3638), .I2(n19_adj_30));
    OR3 i2_adj_29 (.O(n6360), .I0(n10), .I1(n14), .I2(n5185));
    AND3 i2_adj_30 (.O(n5079), .I0(n4837), .I1(n23_adj_19), .I2(n23_adj_7));
    OR3 i2_adj_31 (.O(n6340), .I0(n17), .I1(n6423), .I2(n22));
    AND4 i1_adj_32 (.O(n1164), .I0(int_Data_c_6), .I1(n6389), .I2(n3651), 
         .I3(n19_adj_30));
    AND2 i1_adj_33 (.O(n6786), .I0(n23), .I1(n23_adj_7));
    OR2 equal_400_i23 (.O(n23_adj_19), .I0(n22), .I1(n17_adj_1));
    AND3 i2_adj_34 (.O(n6330), .I0(int_Data_c_4), .I1(n5008), .I2(int_Data_c_5));
    AND2 i2730 (.O(n5085), .I0(n11_adj_95), .I1(n11_adj_23));
    AND2 i1_adj_35 (.O(n6787), .I0(n6786), .I1(n6755));
    AND2 i1_adj_36 (.O(n6789), .I0(key_out_c_1), .I1(key_in_c_1));
    AND2 i1_adj_37 (.O(n21), .I0(n6789), .I1(n9));
    OR2 i4675 (.O(scanvalue_3__N_22[0]), .I0(n5_adj_138), .I1(n6899));
    OR2 i1_adj_38 (.O(n6822), .I0(n6821), .I1(n17_adj_104));
    AND6 i10 (.O(n6333), .I0(n12_adj_113), .I1(n18_adj_110), .I2(timecnt[3]), 
         .I3(n16_adj_111), .I4(timecnt[16]), .I5(timecnt[8]));
    OR2 i2658 (.O(n1253), .I0(n3647), .I1(n1164));
    DFFR led_int_Data1_i4 (.Q(led_int_Data1_c_3), .D(led_int_Data1_3__N_55[3]), 
         .CLK(clk_c), .R(reset_c));   // calculate.v(228[13] 270[16])
    AND4 i3_adj_39 (.O(n6797), .I0(n6795), .I1(n15_adj_82), .I2(n15_adj_94), 
         .I3(n4996));
    AND2 i3909 (.O(n6121), .I0(n6114), .I1(n3704));
    OR2 equal_401_i17 (.O(n17_adj_39), .I0(n15_adj_42), .I1(n14_adj_83));
    AND4 i3_adj_40 (.O(n6401), .I0(n6399), .I1(int_Data_c_4), .I2(n6_adj_91), 
         .I3(n6398));
    DFFR led_int_Data1_i3 (.Q(led_int_Data1_c_2), .D(led_int_Data1_3__N_55[2]), 
         .CLK(clk_c), .R(reset_c));   // calculate.v(228[13] 270[16])
    DFFR led_int_Data1_i2 (.Q(led_int_Data1_c_1), .D(led_int_Data1_3__N_55[1]), 
         .CLK(clk_c), .R(reset_c));   // calculate.v(228[13] 270[16])
    DFFCR int_Data0_i0_i3 (.Q(int_Data0[3]), .D(n11_adj_134), .CLK(time10ms), 
          .CE(n3689), .R(reset_c));   // calculate.v(60[13] 217[16])
    XOR2 i1_adj_41 (.O(n4_adj_108), .I0(int_Data_c_3), .I1(n3482));
    DFFCR int_Data0_i0_i2 (.Q(int_Data0[2]), .D(n6_adj_117), .CLK(time10ms), 
          .CE(n3689), .R(reset_c));   // calculate.v(60[13] 217[16])
    DFFCR int_Data0_i0_i1 (.Q(int_Data0[1]), .D(n6_adj_123), .CLK(time10ms), 
          .CE(n3689), .R(reset_c));   // calculate.v(60[13] 217[16])
    DFFC key_out_i0_i4 (.Q(key_out_c_3), .D(scanvalue[3]), .CLK(time10ms), 
         .CE(reset_c));   // calculate.v(60[13] 217[16])
    DFFC key_out_i0_i3 (.Q(key_out_c_2), .D(scanvalue[2]), .CLK(time10ms), 
         .CE(reset_c));   // calculate.v(60[13] 217[16])
    DFFC key_out_i0_i2 (.Q(key_out_c_1), .D(scanvalue[1]), .CLK(time10ms), 
         .CE(reset_c));   // calculate.v(60[13] 217[16])
    DFFCR int_Data_i0_i8 (.Q(int_Data_c_7), .D(n2141), .CLK(time10ms), 
          .CE(n3688), .R(reset_c));   // calculate.v(60[13] 217[16])
    DFFCR int_Data_i0_i7 (.Q(int_Data_c_6), .D(n2142), .CLK(time10ms), 
          .CE(n3688), .R(reset_c));   // calculate.v(60[13] 217[16])
    DFFCR int_Data_i0_i6 (.Q(int_Data_c_5), .D(n2143), .CLK(time10ms), 
          .CE(n3688), .R(reset_c));   // calculate.v(60[13] 217[16])
    DFFCR int_Data_i0_i5 (.Q(int_Data_c_4), .D(n2144), .CLK(time10ms), 
          .CE(n3688), .R(reset_c));   // calculate.v(60[13] 217[16])
    DFFCR int_Data_i0_i4 (.Q(int_Data_c_3), .D(n6961), .CLK(time10ms), 
          .CE(n3688), .R(reset_c));   // calculate.v(60[13] 217[16])
    DFFCR int_Data_i0_i3 (.Q(int_Data_c_2), .D(n6964), .CLK(time10ms), 
          .CE(n3688), .R(reset_c));   // calculate.v(60[13] 217[16])
    DFFCR int_Data_i0_i2 (.Q(int_Data_c_1), .D(n6967), .CLK(time10ms), 
          .CE(n3688), .R(reset_c));   // calculate.v(60[13] 217[16])
    DFFCR flag_Data_i0_i0 (.Q(flag_Data[0]), .D(flag_Data_3__N_264[0]), 
          .CLK(time10ms), .CE(n9_adj_37), .R(reset_c));   // calculate.v(60[13] 217[16])
    AND2 i3895 (.O(n6107), .I0(n6_adj_49), .I1(n3706));
    XOR2 i3985 (.O(n91), .I0(n6193), .I1(timecnt[9]));
    AND2 i4686 (.O(n6_adj_123), .I0(n6910), .I1(n6909));
    OR2 equal_401_i23 (.O(n23_adj_41), .I0(n22_adj_40), .I1(n17_adj_39));
    AND2 i1303 (.O(n3479), .I0(n21_adj_101), .I1(n3478));
    DFFR timecnt_638__i0 (.Q(timecnt[0]), .D(n121), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    OBUF led_int_Data0_pad_1 (.O(led_int_Data0[1]), .I0(led_int_Data0_c_1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    IBUF key_in_pad_1 (.O(key_in_c_1), .I0(key_in[1]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF key_in_pad_2 (.O(key_in_c_2), .I0(key_in[2]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF key_in_pad_3 (.O(key_in_c_3), .I0(key_in[3]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF reset_pad (.O(reset_c), .I0(reset));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OBUF flag_Over_pad (.O(flag_Over), .I0(flag_Over_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF int_Data_pad_0 (.O(int_Data[0]), .I0(int_Data_c_0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF int_Data_pad_1 (.O(int_Data[1]), .I0(int_Data_c_1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF int_Data_pad_2 (.O(int_Data[2]), .I0(int_Data_c_2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF int_Data_pad_3 (.O(int_Data[3]), .I0(int_Data_c_3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    INV i2626 (.O(n4822), .I0(n3591));
    OBUF int_Data_pad_4 (.O(int_Data[4]), .I0(int_Data_c_4));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i4646 (.O(n6869), .I0(n6868), .I1(n5_adj_5));
    OBUF int_Data_pad_5 (.O(int_Data[5]), .I0(int_Data_c_5));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i1_adj_42 (.O(n6849), .I0(n22_adj_29), .I1(n22_adj_16));
    AND2 i4694 (.O(n6919), .I0(n6918), .I1(n21_adj_8));
    OBUF int_Data_pad_6 (.O(int_Data[6]), .I0(int_Data_c_6));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF int_Data_pad_7 (.O(int_Data[7]), .I0(int_Data_c_7));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF key_out_pad_0 (.O(key_out[0]), .I0(key_out_c_0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF key_out_pad_1 (.O(key_out[1]), .I0(key_out_c_1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF key_out_pad_2 (.O(key_out[2]), .I0(key_out_c_2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    XOR2 i3992 (.O(n90), .I0(n6200), .I1(timecnt[10]));
    OBUF led_int_Data0_pad_3 (.O(led_int_Data0[3]), .I0(led_int_Data0_c_3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i3871 (.O(n6081), .I0(n2105), .I1(int_Data0[0]));
    AND2 i1_adj_43 (.O(n6847), .I0(n5067), .I1(n22_adj_63));
    OBUF key_out_pad_3 (.O(key_out[3]), .I0(key_out_c_3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i3902 (.O(n6114), .I0(n6107), .I1(n3705));
    AND2 i2_adj_44 (.O(n6796), .I0(n6841), .I1(n6795));
    INV i1051 (.O(n3216), .I0(n5174));
    AND2 i4725 (.O(n6950), .I0(n5068), .I1(n3503));
    AND2 i4611 (.O(n6826), .I0(n5060), .I1(n5068));
    XOR2 i3900 (.O(n2115), .I0(n6107), .I1(n3705));
    OR2 i4627 (.O(n6848), .I0(n6847), .I1(n17_adj_57));
    XOR2 i3999 (.O(n89), .I0(n6207), .I1(timecnt[11]));
    AND3 i4735 (.O(n6960), .I0(n6760), .I1(n2139), .I2(n22_adj_26));
    OR2 i1304 (.O(n2155), .I0(n1931), .I1(n3479));
    OR2 i4628 (.O(n6792), .I0(n6849), .I1(n17_adj_99));
    XOR2 i3907 (.O(n2114), .I0(n6114), .I1(n3704));
    OR2 i1306 (.O(n3482), .I0(n1931), .I1(n3481));
    AND2 i1308 (.O(n3484), .I0(n1936), .I1(n3483));
    XOR2 i4659 (.O(n6884), .I0(n1), .I1(int_Data_c_3));
    OR2 i1309 (.O(n3485), .I0(n1933), .I1(n3484));
    AND2 i2641 (.O(n4837), .I0(n23_adj_61), .I1(n23));
    AND2 i1_adj_45 (.O(n37), .I0(n6941), .I1(key_out_c_1));
    OBUF led_int_Data2_pad_0 (.O(led_int_Data2[0]), .I0(n3214));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND3 i4719 (.O(n6944), .I0(n23_adj_103), .I1(n5060), .I2(n6866));
    OR2 i1_adj_46 (.O(n45), .I0(n37), .I1(n6319));
    XOR2 i4006 (.O(n88), .I0(n6214), .I1(timecnt[12]));
    AND2 i1_adj_47 (.O(n6793), .I0(n6792), .I1(n6774));
    OR2 i1_adj_48 (.O(n48), .I0(n6320), .I1(n6326));
    AND3 i1_adj_49 (.O(n6770), .I0(int_Data_c_6), .I1(n6817), .I2(n12_adj_81));
    XOR2 i4013 (.O(n87), .I0(n6221), .I1(timecnt[13]));
    AND2 i4689 (.O(n6_adj_129), .I0(n6913), .I1(n6912));
    XOR2 i4020 (.O(n86), .I0(n6228), .I1(timecnt[14]));
    OBUF led_int_Data2_pad_1 (.O(led_int_Data2[1]), .I0(led_int_Data2_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i3880 (.O(n6090), .I0(n6081), .I1(n5137));
    AND4 i4714 (.O(n6939), .I0(key_out_c_0), .I1(n22_adj_20), .I2(n3_adj_44), 
         .I3(key_in_c_2));
    XOR2 i3914 (.O(n2113), .I0(n6121), .I1(n3708));
    INV i794 (.O(n4_adj_22), .I0(int_Data_c_3));
    XOR2 i4027 (.O(n85), .I0(n6235), .I1(timecnt[15]));
    OBUF led_int_Data2_pad_2 (.O(led_int_Data2[2]), .I0(n3214));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF led_int_Data2_pad_3 (.O(led_int_Data2[3]), .I0(led_int_Data2_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND2 i3960 (.O(n6172), .I0(n6165), .I1(timecnt[5]));
    AND2 i1_adj_50 (.O(n49), .I0(n48), .I1(key_in_c_2));
    AND2 i6 (.O(n6821), .I0(n5059), .I1(n22_adj_16));
    AND2 i1227 (.O(n3500), .I0(n22), .I1(n22_adj_16));
    OBUF led_int_Data1_pad_0 (.O(led_int_Data1[0]), .I0(led_int_Data1_c_0));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND3 i1_adj_51 (.O(led_int_Data1_3__N_272), .I0(n6370), .I1(n6422), 
         .I2(n6371));
    OR2 equal_403_i22 (.O(n22), .I0(n21_adj_8), .I1(n19));
    AND2 i1_adj_52 (.O(n4_adj_109), .I0(n6417), .I1(n12_adj_60));
    AND2 i2_adj_53 (.O(n1125), .I0(n4_adj_109), .I1(n5_adj_5));
    XOR2 i4034 (.O(n84), .I0(n6242), .I1(timecnt[16]));
    OR3 i2_adj_54 (.O(n14_adj_93), .I0(n9), .I1(key_in_c_1), .I2(n20_adj_47));
    XOR2 i4041 (.O(n83), .I0(n6249), .I1(timecnt[17]));
    OR2 i4736 (.O(n6961), .I0(n6960), .I1(n6959));
    AND2 i3995 (.O(n6207), .I0(n6200), .I1(timecnt[10]));
    AND2 i4002 (.O(n6214), .I0(n6207), .I1(timecnt[11]));
    OR3 i2_adj_55 (.O(n14_adj_62), .I0(key_in_c_0), .I1(n22_adj_20), .I2(n20_adj_47));
    XOR2 i4048 (.O(n82), .I0(n6256), .I1(timecnt[18]));
    AND2 i4692 (.O(n11_adj_134), .I0(n6916), .I1(n6915));
    OR2 i1_adj_56 (.O(n6422), .I0(n5071), .I1(int_Data_c_4));
    AND3 i4738 (.O(n6963), .I0(n4880), .I1(n2139), .I2(n6955));
    AND2 i2956 (.O(n5167), .I0(int_Data_c_6), .I1(n12_adj_76));
    INV i4186 (.O(n6399), .I0(n5071));
    OR2 i4631 (.O(n6876), .I0(n4_adj_126), .I1(n6770));
    OR2 i2958 (.O(n5059), .I0(n5201), .I1(n19));
    AND2 i2873 (.O(n5077), .I0(n4831), .I1(key_out_c_2));
    OR2 i1097 (.O(n3265), .I0(flag_Data[1]), .I1(flag_Data[0]));
    OR2 i2808 (.O(n5008), .I0(n8), .I1(int_Data_c_1));
    XOR2 i3950 (.O(n96), .I0(n6158), .I1(timecnt[4]));
    OBUF led_int_Data1_pad_1 (.O(led_int_Data1[1]), .I0(led_int_Data1_c_1));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    AND3 i2_adj_57 (.O(n6403), .I0(n5_adj_5), .I1(n6970), .I2(n6398));
    AND2 i2962 (.O(n5174), .I0(n23_adj_41), .I1(n6340));
    AND2 i3988 (.O(n6200), .I0(n6193), .I1(timecnt[9]));
    XOR2 i3957 (.O(n95), .I0(n6165), .I1(timecnt[5]));
    OR2 i1_adj_58 (.O(n51), .I0(n49), .I1(n6321));
    AND2 i4009 (.O(n6221), .I0(n6214), .I1(timecnt[12]));
    OR2 i2906 (.O(n5112), .I0(n5111), .I1(n14_adj_62));
    AND5 i5 (.O(n4862), .I0(n23_adj_100), .I1(n23_adj_10), .I2(n6822), 
         .I3(n6848), .I4(n6792));
    OBUF led_int_Data1_pad_2 (.O(led_int_Data1[2]), .I0(led_int_Data1_c_2));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    INV i4179 (.O(n6392), .I0(n12_adj_60));
    AND2 i4016 (.O(n6228), .I0(n6221), .I1(timecnt[13]));
    OR2 i1_adj_59 (.O(n6825), .I0(n6821), .I1(n17));
    OR2 i2909 (.O(n5116), .I0(n6821), .I1(n17_adj_99));
    XOR2 i2_adj_60 (.O(n6364), .I0(n4_adj_98), .I1(n4_adj_48));
    AND2 i4023 (.O(n6235), .I0(n6228), .I1(timecnt[14]));
    OR4 i2_adj_61 (.O(n2154), .I0(n6995), .I1(n1932), .I2(n6994), .I3(n1931));
    OBUF led_int_Data1_pad_3 (.O(led_int_Data1[3]), .I0(led_int_Data1_c_3));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OR2 i2919 (.O(n5127), .I0(n12_adj_76), .I1(n5071));
    OR2 i1_adj_62 (.O(n44), .I0(n6301), .I1(n6307));
    AND2 i1_adj_63 (.O(n6844), .I0(n11_adj_84), .I1(n11_adj_95));
    AND2 i4065 (.O(n6277), .I0(n6268), .I1(int_Data0[3]));
    AND2 i1_adj_64 (.O(n48_adj_18), .I0(n6935), .I1(key_out_c_2));
    AND2 i2_adj_65 (.O(n6842), .I0(n22_adj_63), .I1(n22_adj_40));
    AND2 i4711 (.O(n6936), .I0(n4_adj_68), .I1(n21));
    OR2 i4663 (.O(scanvalue_3__N_22[1]), .I0(n6887), .I1(n6886));
    OR2 i1_adj_66 (.O(n50), .I0(n48_adj_18), .I1(n6327));
    AND2 i4706 (.O(n6931), .I0(int_Data_c_6), .I1(n20_adj_24));
    AND2 i2852 (.O(n103), .I0(n37_adj_2), .I1(n82));
    XOR2 i1321 (.O(n3330), .I0(key_out_c_0), .I1(key_out_c_3));
    XOR2 i1320 (.O(n3328), .I0(key_out_c_1), .I1(key_out_c_0));
    AND2 i2851 (.O(n104), .I0(n37_adj_2), .I1(n83));
    XOR2 i1319 (.O(n3326), .I0(key_out_c_2), .I1(key_out_c_1));
    DFFC time10ms_220 (.Q(time10ms), .D(time10ms_N_284), .CLK(clk_c), 
         .CE(reset_c));   // calculate.v(35[14] 40[33])
    AND2 i2850 (.O(n105), .I0(n37_adj_2), .I1(n84));
    OR2 i4727 (.O(n6952), .I0(n6951), .I1(n6950));
    AND2 i2849 (.O(n106), .I0(n37_adj_2), .I1(n85));
    INV i2608 (.O(n4_adj_71), .I0(n12_adj_76));
    DFFCR flag_Data_i0_i1 (.Q(flag_Data[1]), .D(led_int_Data2_c), .CLK(time10ms), 
          .CE(n3506), .R(reset_c));   // calculate.v(60[13] 217[16])
    AND2 i2848 (.O(n107), .I0(n37_adj_2), .I1(n86));
    GND i1 (.X(n3214));
    AND2 i2847 (.O(n108), .I0(n37_adj_2), .I1(n87));
    DFFCR flag_Over_224 (.Q(flag_Over_c), .D(led_int_Data2_c), .CLK(time10ms), 
          .CE(n6355), .R(reset_c));   // calculate.v(60[13] 217[16])
    DFFR led_int_Data0_i4 (.Q(led_int_Data0_c_3), .D(led_int_Data0_3__N_51[3]), 
         .CLK(clk_c), .R(reset_c));   // calculate.v(228[13] 270[16])
    OR2 i4720 (.O(n6945), .I0(n6944), .I1(n6943));
    DFFR timecnt_638__i1 (.Q(timecnt[1]), .D(n120), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i2 (.Q(timecnt[2]), .D(n119), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i3 (.Q(timecnt[3]), .D(n118), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i4 (.Q(timecnt[4]), .D(n117), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i5 (.Q(timecnt[5]), .D(n116), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i6 (.Q(timecnt[6]), .D(n115), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i7 (.Q(timecnt[7]), .D(n114), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i8 (.Q(timecnt[8]), .D(n113), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i9 (.Q(timecnt[9]), .D(n112), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i10 (.Q(timecnt[10]), .D(n111), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i11 (.Q(timecnt[11]), .D(n110), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i12 (.Q(timecnt[12]), .D(n109), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i13 (.Q(timecnt[13]), .D(n108), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i14 (.Q(timecnt[14]), .D(n107), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i15 (.Q(timecnt[15]), .D(n106), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i16 (.Q(timecnt[16]), .D(n105), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i17 (.Q(timecnt[17]), .D(n104), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    DFFR timecnt_638__i18 (.Q(timecnt[18]), .D(n103), .CLK(clk_c), .R(reset_c)) /* synthesis syn_use_carry_chain=1 */ ;   // calculate.v(40[23:32])
    INV i4185 (.O(n6398), .I0(int_Data_c_5));
    XOR2 i3869 (.O(n2119), .I0(n2105), .I1(int_Data0[0]));
    AND2 i2846 (.O(n109), .I0(n37_adj_2), .I1(n88));
    AND2 i2845 (.O(n110), .I0(n37_adj_2), .I1(n89));
    AND2 i2844 (.O(n111), .I0(n37_adj_2), .I1(n90));
    XOR2 i1318 (.O(n3324), .I0(key_in_c_2), .I1(key_in_c_1));
    AND2 i2843 (.O(n112), .I0(n37_adj_2), .I1(n91));
    AND2 i3953 (.O(n6165), .I0(n6158), .I1(timecnt[4]));
    AND2 i2842 (.O(n113), .I0(n37_adj_2), .I1(n92));
    AND2 i1_adj_67 (.O(n51_adj_11), .I0(n50), .I1(key_in_c_3));
    AND2 i2841 (.O(n114), .I0(n37_adj_2), .I1(n93));
    AND2 i2840 (.O(n115), .I0(n37_adj_2), .I1(n94));
    INV i4204 (.O(n6417), .I0(n6330));
    AND2 i2839 (.O(n116), .I0(n37_adj_2), .I1(n95));
    AND2 i2838 (.O(n117), .I0(n37_adj_2), .I1(n96));
    AND2 i2837 (.O(n118), .I0(n37_adj_2), .I1(n97));
    AND2 i2836 (.O(n119), .I0(n37_adj_2), .I1(n98));
    AND4 i1_adj_68 (.O(n6798), .I0(n15_adj_34), .I1(n15_adj_82), .I2(n15_adj_88), 
         .I3(n15_adj_33));
    OR2 i1324 (.O(n3503), .I0(n1901), .I1(n6793));
    XOR2 i2_adj_69 (.O(n3706), .I0(n4_adj_69), .I1(int_Data0[3]));
    AND3 i4775 (.O(n7000), .I0(n6789), .I1(n7), .I2(n5));
    AND2 i2835 (.O(n120), .I0(n37_adj_2), .I1(n99));
    OR2 i1_adj_70 (.O(n3598), .I0(n3595), .I1(n3511));
    AND2 i1327 (.O(n3506), .I0(flag_Data[0]), .I1(n9_adj_37));
    XOR2 i3964 (.O(n94), .I0(n6172), .I1(timecnt[6]));
    INV i2602 (.O(n21_adj_17), .I0(n4797));
    OR2 equal_406_i17 (.O(n17_adj_57), .I0(n15_adj_42), .I1(n3265));
    AND4 i4772 (.O(n6997), .I0(key_out_c_2), .I1(n17_adj_21), .I2(n7), 
         .I3(key_in_c_0));
    OR2 equal_405_i23 (.O(n23_adj_10), .I0(n22_adj_26), .I1(n17_adj_57));
    AND2 i1305 (.O(n3481), .I0(n3485), .I1(n3478));
    OR2 i4739 (.O(n6964), .I0(n6963), .I1(n6962));
    AND3 i4741 (.O(n6966), .I0(n4880), .I1(n2139), .I2(n6952));
    OR2 i2834 (.O(n21_adj_101), .I0(n12_adj_67), .I1(n3_adj_28));
    OR3 i2_adj_71 (.O(n6361), .I0(n12_adj_76), .I1(n6_adj_53), .I2(int_Data_c_3));
    AND2 i1_adj_72 (.O(n3627), .I0(flag_Data[0]), .I1(key_out_c_1));
    OR2 i4742 (.O(n6967), .I0(n6966), .I1(n6965));
    XOR2 i3971 (.O(n93), .I0(n6179), .I1(timecnt[7]));
    OR2 i1_adj_73 (.O(n3633), .I0(n3_adj_44), .I1(key_out_c_3));
    INV i4693 (.O(n6918), .I0(n4837));
    INV i1_adj_74 (.O(n1_adj_137), .I0(scanvalue[2]));
    INV i4670 (.O(n6895), .I0(n3647));
    OR2 i1_adj_75 (.O(n11_adj_84), .I0(n3633), .I1(n15_adj_42));
    OR2 i1_adj_76 (.O(n3595), .I0(n3442), .I1(int_Data_c_5));
    OR2 i1_adj_77 (.O(n3638), .I0(n3442), .I1(n3));
    INV i4640 (.O(n6815), .I0(n6861));
    AND3 i2_adj_78 (.O(n1934), .I0(n5_adj_92), .I1(n5_adj_5), .I2(n6986));
    OR2 i1_adj_79 (.O(n3651), .I0(n12_adj_76), .I1(n8_adj_72));
    INV i4658 (.O(n6760), .I0(n6882));
    INV i1_adj_80 (.O(n1_adj_132), .I0(int_Data0[3]));
    OR6 i1_adj_81 (.O(n37_adj_2), .I0(n12), .I1(timecnt[12]), .I2(n10_adj_107), 
        .I3(n11_adj_106), .I4(n3623), .I5(timecnt[11]));
    AND2 i2971 (.O(n5183), .I0(n4899), .I1(n6));
    OR2 equal_412_i23 (.O(n23_adj_105), .I0(n22), .I1(n17_adj_104));
    AND3 i4744 (.O(n6969), .I0(n6), .I1(int_Data_c_3), .I2(n9_adj_50));
    XOR2 i4054 (.O(n3707), .I0(int_Data0[2]), .I1(int_Data0[0]));
    INV i4671 (.O(n6896), .I0(n4_adj_102));
    INV i1_adj_82 (.O(n1_adj_127), .I0(int_Data0[0]));
    OR2 equal_412_i17 (.O(n17_adj_104), .I0(n15_adj_14), .I1(n3265));
    INV i4636 (.O(n6780), .I0(n6869));
    INV i4634 (.O(n6818), .I0(n6855));
    INV i4673 (.O(n6898), .I0(time10ms));
    OR2 i4067 (.O(n4_adj_56), .I0(n6277), .I1(n6281));
    AND2 i2627 (.O(led_int_Data1_3__N_55[2]), .I0(n4822), .I1(n1253));
    INV i1_adj_83 (.O(n1_adj_121), .I0(int_Data0[1]));
    INV i4632 (.O(n6820), .I0(n6877));
    INV i4 (.O(n4_adj_116), .I0(n3265));
    INV i1_adj_84 (.O(n1_adj_114), .I0(int_Data0[2]));
    AND2 i4068 (.O(n6281), .I0(n6280), .I1(int_Data0[1]));
    AND2 i2_adj_85 (.O(n13), .I0(timecnt[17]), .I1(timecnt[13]));
    OR2 i4745 (.O(n6970), .I0(n6969), .I1(n6968));
    OR2 i1_adj_86 (.O(n22_adj_16), .I0(n3644), .I1(n3_adj_44));
    INV i4674 (.O(n6899), .I0(n3542));
    OR2 i4678 (.O(scanvalue_3__N_22[3]), .I0(n6902), .I1(n6901));
    XOR2 i3978 (.O(n92), .I0(n6186), .I1(timecnt[8]));
    AND2 i4747 (.O(n6972), .I0(n6971), .I1(n3575));
    INV i4676 (.O(n6901), .I0(n5_adj_66));
    INV i4677 (.O(n6902), .I0(n6_adj_64));
    AND2 i4748 (.O(n6973), .I0(n2169), .I1(n6885));
    AND2 i3_adj_87 (.O(n14_adj_112), .I0(timecnt[0]), .I1(timecnt[2]));
    OR2 i2881 (.O(n4928), .I0(n5085), .I1(n14));
    AND2 i5_adj_88 (.O(n16_adj_111), .I0(timecnt[4]), .I1(timecnt[1]));
    XOR2 i4070 (.O(n3705), .I0(n4_adj_56), .I1(int_Data0[2]));
    OR2 equal_411_i23 (.O(n23_adj_103), .I0(n22_adj_16), .I1(n17_adj_99));
    AND3 i2799 (.O(n2759), .I0(n6770), .I1(n7_adj_31), .I2(n19_adj_30));
    AND2 i4722 (.O(n6947), .I0(n6946), .I1(n23_adj_10));
    AND2 i2609 (.O(n2105), .I0(n4833), .I1(n6928));
    AND2 i2929 (.O(n5137), .I0(n4833), .I1(n5079));
    AND2 i7 (.O(n18_adj_110), .I0(n14_adj_112), .I1(n13));
    XOR2 i1_adj_89 (.O(n4_adj_98), .I0(int_Data_c_2), .I1(n2155));
    AND2 i3888 (.O(n6099), .I0(n4_adj_51), .I1(n2107));
    OR2 i3_adj_90 (.O(n11_adj_106), .I0(timecnt[5]), .I1(timecnt[7]));
    AND2 i2695 (.O(n121), .I0(n37_adj_2), .I1(n100));
    INV i4660 (.O(n6885), .I0(n6884));
    AND2 i2655 (.O(n4851), .I0(key_out_c_1), .I1(key_out_c_0));
    AND2 i2701 (.O(n4899), .I0(int_Data_c_4), .I1(int_Data_c_3));
    OR2 i4749 (.O(led_int_Data0_3__N_51[3]), .I0(n6973), .I1(n6972));
    AND2 i2599 (.O(n4795), .I0(key_in_c_3), .I1(key_in_c_2));
    OR2 i2_adj_91 (.O(n6_adj_78), .I0(key_in_c_3), .I1(n12_adj_87));
    AND2 i2794 (.O(n5201), .I0(n21_adj_45), .I1(n21_adj_8));
    OR2 equal_409_i23 (.O(n23_adj_100), .I0(n22), .I1(n17_adj_99));
    AND6 i7_adj_92 (.O(n3689), .I0(n23_adj_70), .I1(n12_adj_85), .I2(n23_adj_75), 
         .I3(n6843), .I4(n31), .I5(n23_adj_19));
    OR2 equal_404_i14 (.O(n14_adj_83), .I0(n2), .I1(flag_Data[0]));
    OR2 equal_409_i17 (.O(n17_adj_99), .I0(n9_adj_12), .I1(n3265));
    AND3 i2_adj_93 (.O(n6301), .I0(flag_Data[0]), .I1(key_in_c_1), .I2(n6999));
    AND2 i4030 (.O(n6242), .I0(n6235), .I1(timecnt[15]));
    AND3 i2_adj_94 (.O(n1932), .I0(n4_adj_71), .I1(n6_adj_91), .I2(n8_adj_72));
    XOR2 i766 (.O(n2160), .I0(n2154), .I1(int_Data_c_1));
    AND2 i1_adj_95 (.O(n4_adj_126), .I0(n6815), .I1(n5167));
    AND2 i2635 (.O(n4831), .I0(key_in_c_0), .I1(key_out_c_3));
    AND2 i4037 (.O(n6249), .I0(n6242), .I1(timecnt[16]));
    AND3 i2_adj_96 (.O(n3511), .I0(n6_adj_53), .I1(int_Data_c_3), .I2(int_Data_c_4));
    OR2 equal_404_i17 (.O(n17), .I0(n9_adj_12), .I1(n14_adj_83));
    OR2 i4619 (.O(n6834), .I0(n1151), .I1(n1099));
    OR2 equal_407_i23 (.O(n23_adj_96), .I0(n22_adj_6), .I1(n17_adj_57));
    AND2 i4044 (.O(n6256), .I0(n6249), .I1(timecnt[17]));
    AND2 i4751 (.O(n6976), .I0(n2169), .I1(int_Data_c_2));
    INV i4662 (.O(n6887), .I0(n4));
    INV i4210 (.O(n6423), .I0(n22_adj_16));
    OR2 i4_adj_97 (.O(n12), .I0(timecnt[14]), .I1(timecnt[9]));
    AND2 i1_adj_98 (.O(n12_adj_113), .I0(timecnt[18]), .I1(timecnt[15]));
    INV i4661 (.O(n6886), .I0(n4947));
    AND2 i1_adj_99 (.O(n6800), .I0(n6798), .I1(n15_adj_89));
    OR2 i2682 (.O(n4880), .I0(n4879), .I1(n17_adj_57));
    AND2 i4072 (.O(n6285), .I0(n4_adj_56), .I1(int_Data0[2]));
    INV i1056 (.O(n3_adj_28), .I0(n1936));
    OR2 i2615 (.O(led_int_Data1_3__N_55[0]), .I0(led_int_Data1_3__N_272), 
        .I1(led_int_Data1_3__N_268[0]));
    AND2 i2614 (.O(led_int_Data1_3__N_268[0]), .I0(n1_adj_36), .I1(n1265));
    OR2 i2613 (.O(n1265), .I0(n1112), .I1(n1255));
    AND2 i4621 (.O(n6836), .I0(n4851), .I1(key_out_c_3));
    INV i4704 (.O(n6929), .I0(int_Data_c_6));
    XOR2 i1_adj_100 (.O(n4_adj_69), .I0(n6268), .I1(int_Data0[1]));
    AND2 i2612 (.O(n1255), .I0(n3_adj_35), .I1(n1245));
    AND2 i1_adj_101 (.O(n4), .I0(n1_adj_59), .I1(scanvalue[1]));
    OR2 i2780 (.O(n4979), .I0(n5147), .I1(n11));
    AND2 i4680 (.O(n3688), .I0(n6904), .I1(n31));
    OR2 i4066 (.O(n6280), .I0(n6268), .I1(int_Data0[3]));
    AND2 i2_adj_102 (.O(n1936), .I0(n5_adj_5), .I1(n6989));
    AND2 i3974 (.O(n6186), .I0(n6179), .I1(timecnt[7]));
    AND2 i4079 (.O(n3708), .I0(n6285), .I1(int_Data0[3]));
    AND2 i1_adj_103 (.O(n4_adj_4), .I0(scanvalue[0]), .I1(n2_adj_58));
    AND2 i4056 (.O(n6268), .I0(int_Data0[2]), .I1(int_Data0[0]));
    AND2 i3_adj_104 (.O(n9_adj_37), .I0(n11_adj_38), .I1(n31));
    AND2 i2775 (.O(n5147), .I0(n14_adj_93), .I1(n14));
    OR2 i1_adj_105 (.O(n6804), .I0(n1099), .I1(n1112));
    OR2 i1_adj_106 (.O(led_int_Data1_3__N_268[1]), .I0(n6804), .I1(n6782));
    AND2 i2637 (.O(n4833), .I0(n23_adj_75), .I1(n23_adj_70));
    XOR2 i4077 (.O(n3704), .I0(n6285), .I1(int_Data0[3]));
    AND3 i5_adj_107 (.O(n6781), .I0(n8_adj_79), .I1(n2759), .I2(n9_adj_77));
    OR2 key_in_3__I_0_240_i15 (.O(n15_adj_74), .I0(n14_adj_62), .I1(n11_adj_95));
    OR2 key_in_3__I_0_241_i15 (.O(n15_adj_33), .I0(n14_adj_93), .I1(n11_adj_95));
    AND2 i2621 (.O(led_int_Data1_3__N_55[1]), .I0(n4816), .I1(led_int_Data1_3__N_268[1]));
    OR2 i2611 (.O(n1245), .I0(n1138), .I1(n1235));
    OR2 i1_adj_108 (.O(n3591), .I0(n6804), .I1(led_int_Data1_3__N_272));
    XOR2 i2_adj_109 (.O(n6365), .I0(n4_adj_108), .I1(n6_adj_54));
    AND2 i1_adj_110 (.O(n31), .I0(n51), .I1(key_in_c_3));
    AND5 i4_adj_111 (.O(n9_adj_131), .I0(n15_adj_74), .I1(n4928), .I2(n15_adj_90), 
         .I3(n8_adj_130), .I4(n15_adj_43));
    OR2 i2859 (.O(n5060), .I0(n5059), .I1(n17_adj_99));
    AND4 i4709 (.O(n6934), .I0(flag_Data[0]), .I1(key_out_c_3), .I2(key_in_c_0), 
         .I3(n7002));
    OR2 i4710 (.O(n6935), .I0(n6934), .I1(n6933));
    INV i1054 (.O(n10_adj_73), .I0(n1933));
    INV i1307 (.O(n3483), .I0(n1934));
    OR2 i2860 (.O(n5062), .I0(n5085), .I1(n14_adj_62));
    OR2 i3882 (.O(n4_adj_51), .I0(n6090), .I1(n6094));
    AND2 i2_adj_112 (.O(n6_adj_64), .I0(n1_adj_137), .I1(scanvalue[0]));
    AND3 i2_adj_113 (.O(n3), .I0(int_Data_c_2), .I1(n5_adj_92), .I2(int_Data_c_3));
    AND3 i4712 (.O(n6937), .I0(n56), .I1(key_out_c_3), .I2(n17_adj_21));
    OR2 key_in_3__I_0_242_i11 (.O(n11_adj_95), .I0(n10), .I1(n15_adj_14));
    OR2 i707 (.O(n12_adj_81), .I0(int_Data_c_5), .I1(n10_adj_80));
    AND2 i706 (.O(n10_adj_80), .I0(int_Data_c_4), .I1(n5071));
    OR2 i4625 (.O(n6843), .I0(n6842), .I1(n17_adj_39));
    OR2 key_in_3__I_0_242_i15 (.O(n15), .I0(n14), .I1(n11_adj_95));
    OR2 i4626 (.O(n6795), .I0(n6844), .I1(n14_adj_62));
    AND2 i3981 (.O(n6193), .I0(n6186), .I1(timecnt[8]));
    INV i4664 (.O(n6889), .I0(n5_adj_97));
    INV i4700 (.O(n6925), .I0(n5079));
    INV i4668 (.O(n6893), .I0(n4_adj_4));
    INV i4622 (.O(n4_adj_120), .I0(n6836));
    INV i4157 (.O(n6370), .I0(n10_adj_46));
    INV i1400 (.O(n3575), .I0(n6365));
    INV i4768 (.O(n6993), .I0(n12_adj_67));
    AND2 i4_adj_114 (.O(n12_adj_85), .I0(n6786), .I1(n6825));
    OR2 i3889 (.O(n6102), .I0(n4_adj_51), .I1(n2107));
    AND2 i4723 (.O(n6948), .I0(n4880), .I1(n6992));
    OR2 i1_adj_115 (.O(n22_adj_40), .I0(n3644), .I1(key_out_c_2));
    OR2 i4752 (.O(led_int_Data0_3__N_51[2]), .I0(n6976), .I1(n6975));
    AND2 i4633 (.O(n6855), .I0(int_Data_c_6), .I1(n6361));
    OR2 i4635 (.O(n6868), .I0(n6764), .I1(n4_adj_109));
    AND2 i4666 (.O(n6355), .I0(n6890), .I1(n6889));
    OR2 i754 (.O(n12_adj_76), .I0(int_Data_c_5), .I1(int_Data_c_4));
    OR2 i778 (.O(n3454), .I0(n4_adj_48), .I1(n2155));
    OR2 i4724 (.O(n6949), .I0(n6948), .I1(n6947));
    INV i2807 (.O(n3529), .I0(n6361));
    AND2 i4754 (.O(n6979), .I0(int_Data_c_6), .I1(n3529));
    OR2 key_in_3__I_0_243_i15 (.O(n15_adj_82), .I0(n14_adj_62), .I1(n11));
    AND2 i4639 (.O(n6861), .I0(int_Data_c_6), .I1(n5205));
    AND2 i2749 (.O(n4947), .I0(scanvalue[3]), .I1(scanvalue[2]));
    AND3 i2_adj_116 (.O(n6321), .I0(n45), .I1(key_out_c_3), .I2(key_in_c_0));
    AND2 i2610 (.O(n1235), .I0(n5_adj_32), .I1(n1225));
    OR3 i2_adj_117 (.O(n6362), .I0(n6787), .I1(n1888), .I2(n1889));
    AND3 i2_adj_118 (.O(n1112), .I0(n6392), .I1(n3598), .I2(n5_adj_5));
    INV i4158 (.O(n6371), .I0(n3595));
    INV i4679 (.O(n6904), .I0(n51_adj_11));
    AND2 i1_adj_119 (.O(n20_adj_24), .I0(n19_adj_25), .I1(int_Data_c_5));
    OR2 i3881 (.O(n6093), .I0(n6081), .I1(n5137));
    XOR2 i1_adj_120 (.O(n4_adj_125), .I0(n4_adj_51), .I1(n3707));
    INV i2620 (.O(n4816), .I0(led_int_Data1_3__N_272));
    INV equal_409_i24 (.O(n1901), .I0(n23_adj_100));
    AND2 i4726 (.O(n6951), .I0(n40), .I1(n23_adj_96));
    INV i4620 (.O(n8_adj_79), .I0(n6834));
    XOR2 i3936 (.O(n98), .I0(n6144), .I1(timecnt[2]));
    OR2 key_in_3__I_0_244_i15 (.O(n15_adj_43), .I0(n14_adj_93), .I1(n11));
    INV i3005 (.O(n2139), .I0(n4862));
    OR2 i4755 (.O(n6980), .I0(n6979), .I1(n6978));
    AND2 i4729 (.O(n6954), .I0(n40), .I1(n23_adj_96));
    AND5 i4708 (.O(n6933), .I0(n3627), .I1(n3330), .I2(key_in_c_1), 
         .I3(n9), .I4(key_in_c_2));
    AND2 i777 (.O(n2962), .I0(n4_adj_48), .I1(n2155));
    OR2 i779 (.O(n6_adj_54), .I0(n2962), .I1(n3455));
    OR2 i4641 (.O(n6863), .I0(n6826), .I1(n22_adj_6));
    AND2 i3946 (.O(n6158), .I0(n6151), .I1(timecnt[3]));
    AND2 i4617 (.O(n6832), .I0(scanvalue[1]), .I1(scanvalue[0]));
    OR2 equal_406_i19 (.O(n19_adj_9), .I0(n18), .I1(key_out_c_2));
    OR2 key_in_3__I_0_245_i9 (.O(n9_adj_12), .I0(key_out_c_1), .I1(n5));
    AND2 i2739 (.O(n4937), .I0(key_out_c_3), .I1(key_out_c_2));
    OR2 equal_406_i20 (.O(n20), .I0(n8_adj_86), .I1(key_in_c_2));
    OR2 key_in_3__I_0_245_i11 (.O(n11), .I0(n10), .I1(n9_adj_12));
    OR2 i3890 (.O(n6_adj_49), .I0(n6099), .I1(n6103));
    INV i4618 (.O(n5_adj_3), .I0(n6832));
    INV i4652 (.O(n9_adj_77), .I0(n6874));
    OR2 equal_406_i21 (.O(n21_adj_8), .I0(n20), .I1(n22_adj_20));
    OR2 i1_adj_121 (.O(n5_adj_97), .I0(n7), .I1(n11_adj_84));
    AND4 i3_adj_122 (.O(n6319), .I0(n3326), .I1(key_in_c_1), .I2(key_out_c_0), 
         .I3(n7));
    INV i4195 (.O(n6408), .I0(scanvalue[3]));
    INV i4198 (.O(n6411), .I0(n6785));
    INV i4650 (.O(n6774), .I0(n6872));
    INV i4648 (.O(n6817), .I0(n6870));
    XOR2 i1_adj_123 (.O(n4_adj_15), .I0(n6081), .I1(int_Data0[1]));
    INV i708 (.O(n5_adj_52), .I0(int_Data_c_2));
    INV i705 (.O(n9_adj_50), .I0(int_Data_c_4));
    AND2 i3891 (.O(n6103), .I0(n6102), .I1(n3707));
    INV i2757 (.O(n3514), .I0(n8_adj_65));
    OR2 key_in_3__I_0_245_i15 (.O(n15_adj_34), .I0(n14), .I1(n11));
    AND2 i2791 (.O(n5067), .I0(n22_adj_40), .I1(n22_adj_6));
    INV i4665 (.O(n6890), .I0(n6_adj_78));
    AND3 i4697 (.O(n6922), .I0(n23_adj_75), .I1(n4862), .I2(n6362));
    OR2 i2_adj_124 (.O(n10_adj_107), .I0(timecnt[10]), .I1(timecnt[6]));
    OR2 i747 (.O(n8_adj_72), .I0(int_Data_c_3), .I1(n6_adj_53));
    INV i2740 (.O(n10), .I0(n4937));
    OR2 key_in_3__I_0_246_i15 (.O(n15_adj_90), .I0(n14_adj_62), .I1(n11_adj_23));
    INV i2920 (.O(n17_adj_27), .I0(n5127));
    OR2 i1_adj_125 (.O(n6810), .I0(n21_adj_17), .I1(key_in_c_0));
    OR2 i1_adj_126 (.O(n4_adj_102), .I0(n3591), .I1(n1164));
    INV i4643 (.O(n6865), .I0(n23_adj_105));
    OR2 key_in_3__I_0_247_i15 (.O(n15_adj_89), .I0(n14_adj_93), .I1(n11_adj_23));
    OR3 i4644 (.O(n6866), .I0(n22_adj_29), .I1(n17_adj_104), .I2(n6865));
    INV i4176 (.O(n6389), .I0(n5167));
    INV i899 (.O(n9), .I0(key_in_c_0));
    INV i897 (.O(n8_adj_86), .I0(key_in_c_3));
    INV i896 (.O(n17_adj_21), .I0(key_out_c_1));
    INV i893 (.O(n22_adj_20), .I0(key_in_c_1));
    INV i2723 (.O(n12_adj_87), .I0(n4920));
    XOR2 i3893 (.O(n2116), .I0(n6_adj_49), .I1(n3706));
    INV i890 (.O(n3_adj_44), .I0(key_out_c_2));
    INV i888 (.O(n7), .I0(key_in_c_2));
    INV i4667 (.O(n6892), .I0(n4947));
    INV i4165 (.O(n6378), .I0(n6784));
    INV i874 (.O(n2_adj_58), .I0(scanvalue[1]));
    INV i871 (.O(n2), .I0(flag_Data[1]));
    AND2 i2728 (.O(n5185), .I0(n15_adj_14), .I1(n9_adj_12));
    OR2 i2796 (.O(n4996), .I0(n5111), .I1(n14_adj_93));
    OR2 i2725 (.O(n3458), .I0(int_Data_c_4), .I1(int_Data_c_3));
    INV i11 (.O(n19_adj_30), .I0(int_Data_c_7));
    INV i2864 (.O(n3468), .I0(n5116));
    INV i2687 (.O(n9_adj_13), .I0(n3458));
    INV i867 (.O(n4_adj_68), .I0(key_out_c_3));
    INV equal_396_i24 (.O(n1888), .I0(n23_adj_70));
    INV i3001 (.O(n3623), .I0(n6333));
    OR2 i2990 (.O(n5205), .I0(int_Data_c_5), .I1(n5183));
    OR2 i4730 (.O(n6955), .I0(n6954), .I1(n6953));
    XOR2 i2_adj_127 (.O(n6367), .I0(n4_adj_15), .I1(n5137));
    AND2 i3883 (.O(n6094), .I0(n6093), .I1(int_Data0[1]));
    OR2 i738 (.O(n8_adj_65), .I0(int_Data_c_3), .I1(n6));
    INV i4681 (.O(n6906), .I0(n2_adj_115));
    OR2 key_in_3__I_0_248_i14 (.O(n14), .I0(n20), .I1(n12_adj_87));
    OR2 key_in_3__I_0_248_i15 (.O(n15_adj_94), .I0(n14), .I1(n11_adj_23));
    INV i4682 (.O(n6907), .I0(n9_adj_119));
    AND2 i735 (.O(n12_adj_60), .I0(int_Data_c_5), .I1(n3458));
    OR2 i4713 (.O(n6938), .I0(n6937), .I1(n6936));
    INV i4746 (.O(n6971), .I0(n2169));
    AND2 i3967 (.O(n6179), .I0(n6172), .I1(timecnt[6]));
    AND3 i2_adj_128 (.O(n6318), .I0(n5_adj_5), .I1(n6958), .I2(int_Data_c_5));
    OR2 key_in_3__I_0_249_i15 (.O(n15_adj_88), .I0(n14_adj_62), .I1(n11_adj_84));
    AND2 i2770 (.O(n5111), .I0(n11_adj_23), .I1(n11));
    AND2 i4647 (.O(n6870), .I0(n20_adj_24), .I1(int_Data_c_6));
    INV i2676 (.O(n5_adj_5), .I0(n3442));
    INV i7_adj_129 (.O(n7_adj_31), .I0(n1177));
    AND2 i2722 (.O(n4920), .I0(key_in_c_1), .I1(key_in_c_0));
    AND3 i4715 (.O(n6940), .I0(n3324), .I1(key_out_c_2), .I2(n5));
    INV i5_adj_130 (.O(n5_adj_32), .I0(n1151));
    AND2 i2667 (.O(n2141), .I0(n4862), .I1(n2113));
    INV i2600 (.O(n20_adj_47), .I0(n4795));
    INV i3_adj_131 (.O(n3_adj_35), .I0(n1125));
    INV i1_adj_132 (.O(n1_adj_36), .I0(n1099));
    INV i7_adj_133 (.O(flag_Data_3__N_264[0]), .I0(flag_Data[0]));
    INV i991 (.O(n1_adj_59), .I0(scanvalue[0]));
    INV i2671 (.O(n11_adj_38), .I0(n4866));
    INV equal_397_i24 (.O(n1889), .I0(n23_adj_61));
    INV i4614 (.O(n4_adj_55), .I0(n6828));
    INV i4684 (.O(n6909), .I0(n2_adj_122));
    OR2 i4649 (.O(n6872), .I0(n5059), .I1(n17_adj_104));
    AND2 i1279 (.O(n3455), .I0(n3454), .I1(int_Data_c_2));
    AND2 i726 (.O(n6_adj_53), .I0(int_Data_c_2), .I1(int_Data_c_1));
    AND2 i3932 (.O(n6144), .I0(timecnt[0]), .I1(timecnt[1]));
    AND2 i722 (.O(n10_adj_46), .I0(int_Data_c_4), .I1(n8));
    OR2 i1_adj_134 (.O(n3644), .I0(n6810), .I1(n4_adj_68));
    OR2 i721 (.O(n8), .I0(int_Data_c_3), .I1(int_Data_c_2));
    OR3 i4651 (.O(n6874), .I0(n1112), .I1(n6869), .I2(n1164));
    AND2 i2601 (.O(n4797), .I0(n4795), .I1(key_in_c_1));
    OR2 i2865 (.O(n5068), .I0(n5067), .I1(n17_adj_57));
    XOR2 i3943 (.O(n97), .I0(n6151), .I1(timecnt[3]));
    AND3 i2_adj_135 (.O(n6327), .I0(n44), .I1(key_out_c_0), .I2(key_out_c_3));
    INV i17 (.O(n5), .I0(key_out_c_0));
    AND2 i2_adj_136 (.O(n2107), .I0(n4_adj_55), .I1(n4833));
    OR2 equal_395_i23 (.O(n23_adj_75), .I0(n22_adj_26), .I1(n17_adj_39));
    INV equal_400_i24 (.O(n1892), .I0(n23_adj_19));
    INV i4685 (.O(n6910), .I0(n6777));
    INV i2656 (.O(n15_adj_42), .I0(n4851));
    AND2 i4653 (.O(n6877), .I0(n6876), .I1(n19_adj_30));
    AND2 i4655 (.O(n6880), .I0(n6863), .I1(n22_adj_63));
    OR2 i4657 (.O(n6882), .I0(n6880), .I1(n17_adj_57));
    INV equal_401_i24 (.O(n1893), .I0(n23_adj_41));
    INV i1302 (.O(n3478), .I0(n1932));
    OR2 i713 (.O(n6), .I0(int_Data_c_2), .I1(int_Data_c_1));
    INV i4687 (.O(n6912), .I0(n2_adj_128));
    INV i4688 (.O(n6913), .I0(n9_adj_131));
    INV i4721 (.O(n6946), .I0(n4880));
    AND2 i4732 (.O(n6957), .I0(int_Data_c_4), .I1(n3514));
    OR2 reduce_or_511_i2 (.O(n2169), .I0(n1), .I1(n6318));
    OR2 i4716 (.O(n6941), .I0(n6940), .I1(n6939));
    OR2 i2_adj_137 (.O(n19_adj_25), .I0(n3458), .I1(int_Data_c_2));
    OR2 i1_adj_138 (.O(n22_adj_26), .I0(n6810), .I1(n3633));
    AND2 i3939 (.O(n6151), .I0(n6144), .I1(timecnt[2]));
    AND2 i4765 (.O(n6990), .I0(n5068), .I1(n6945));
    AND2 i768 (.O(n4_adj_48), .I0(n2154), .I1(int_Data_c_1));
    OR2 i2675 (.O(n3442), .I0(int_Data_c_6), .I1(int_Data_c_7));
    AND2 i4718 (.O(n6943), .I0(n6942), .I1(n23_adj_100));
    XOR2 i1_adj_139 (.O(time10ms_N_284), .I0(n37_adj_2), .I1(n6898));
    AND2 i4762 (.O(n6987), .I0(n6398), .I1(n3511));
    AND2 i4759 (.O(n6984), .I0(n5_adj_52), .I1(n16));
    VCC i2 (.X(led_int_Data2_c));
    AND2 i2677 (.O(n2144), .I0(n4862), .I1(n2116));
    AND2 i4756 (.O(n6981), .I0(n6971), .I1(n2160));
    OR2 i1_adj_140 (.O(n16), .I0(int_Data_c_1), .I1(int_Data_c_3));
    AND2 i4753 (.O(n6978), .I0(n6929), .I1(n3));
    AND2 i1_adj_141 (.O(n5_adj_92), .I0(int_Data_c_4), .I1(int_Data_c_5));
    OR2 equal_396_i23 (.O(n23_adj_70), .I0(n22_adj_16), .I1(n17_adj_1));
    AND2 i1_adj_142 (.O(n1933), .I0(n6980), .I1(n19_adj_30));
    AND2 i4750 (.O(n6975), .I0(n6971), .I1(n6364));
    AND2 i2647 (.O(n4879), .I0(n22_adj_26), .I1(n22_adj_63));
    OR2 led_int_Data0_3__I_0_505_i5 (.O(n12_adj_67), .I0(n1933), .I1(n1934));
    OR2 i2603 (.O(n1225), .I0(n1164), .I1(n2759));
    AND2 i1_adj_143 (.O(n6_adj_91), .I0(int_Data_c_6), .I1(n19_adj_30));
    XOR2 i21 (.O(n7_adj_139), .I0(scanvalue[1]), .I1(scanvalue[0]));
    OR2 i4624 (.O(n6841), .I0(n5147), .I1(n5085));
    INV i2636 (.O(n18), .I0(n4831));
    INV i4717 (.O(n6942), .I0(n5060));
    AND2 i1_adj_144 (.O(n5_adj_138), .I0(n7_adj_139), .I1(n4947));
    OR2 i4669 (.O(scanvalue_3__N_22[2]), .I0(n6893), .I1(n6892));
    AND2 i1_adj_145 (.O(n5_adj_66), .I0(scanvalue[1]), .I1(scanvalue[3]));
    AND2 i4757 (.O(n6982), .I0(n2169), .I1(int_Data_c_1));
    XOR2 i3929 (.O(n99), .I0(timecnt[0]), .I1(timecnt[1]));
    OR2 i4758 (.O(led_int_Data0_3__N_51[1]), .I0(n6982), .I1(n6981));
    AND2 i4760 (.O(n6985), .I0(int_Data_c_2), .I1(n4_adj_22));
    OR2 i4761 (.O(n6986), .I0(n6985), .I1(n6984));
    AND2 i4763 (.O(n6988), .I0(int_Data_c_5), .I1(n9_adj_13));
    OR2 i4764 (.O(n6989), .I0(n6988), .I1(n6987));
    AND2 i4766 (.O(n6991), .I0(n40), .I1(n23_adj_96));
    OR2 i4767 (.O(n6992), .I0(n6991), .I1(n6990));
    AND2 i4769 (.O(n6994), .I0(n6993), .I1(n1936));
    OR4 i1_adj_146 (.O(n6755), .I0(n3500), .I1(n1892), .I2(n1893), .I3(n17));
    OR2 i1_adj_147 (.O(n16_adj_136), .I0(n4_adj_116), .I1(n6799));
    INV i2874 (.O(n19), .I0(n5077));
    AND2 i1_adj_148 (.O(n24), .I0(n23_adj_135), .I1(n16_adj_136));
    AND2 i4695 (.O(n6920), .I0(n4837), .I1(n21_adj_45));
    OR2 i1_adj_149 (.O(n23_adj_135), .I0(n11_adj_23), .I1(n5147));
    INV i6_adj_150 (.O(n40), .I0(n5068));
    INV i4690 (.O(n6915), .I0(n2_adj_133));
    AND2 i4770 (.O(n6995), .I0(n12_adj_67), .I1(n10_adj_73));
    OR3 i3_adj_151 (.O(n3542), .I0(n6408), .I1(scanvalue[2]), .I2(n5_adj_3));
    
endmodule
//
// Verilog Description of module AND3
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND2
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
// Verilog Description of module OR4
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
// Verilog Description of module OR3
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND6
// module not written out since it is a black-box. 
//

//
// Verilog Description of module AND5
// module not written out since it is a black-box. 
//

//
// Verilog Description of module GND
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

