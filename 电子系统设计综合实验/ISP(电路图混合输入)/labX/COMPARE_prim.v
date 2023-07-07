// Verilog netlist produced by program LSE :  version Diamond Version 0.0.0
// Netlist written on Fri Jun 09 10:10:55 2023
//
// Verilog Description of module COMPARE
//

module COMPARE (clk, reset, int_Data, flag_Over, result) /* synthesis syn_module_defined=1 */ ;   // compare.v(1[8:15])
    input clk;   // compare.v(2[11:14])
    input reset;   // compare.v(2[15:20])
    input [7:0]int_Data;   // compare.v(3[17:25])
    input flag_Over;   // compare.v(4[11:20])
    output [7:0]result;   // compare.v(6[18:24])
    
    wire clk_c /* synthesis is_clock=1, SET_AS_NETWORK=clk_c */ ;   // compare.v(2[11:14])
    
    wire pwr, reset_c, int_Data_c_7, int_Data_c_6, int_Data_c_5, int_Data_c_4, 
        int_Data_c_3, int_Data_c_2, int_Data_c_1, int_Data_c_0, flag_Over_c, 
        result_c;
    wire [7:0]result_7__N_11;
    
    wire n12, n10, n2, n1, gnd;
    
    IBUF clk_pad (.O(clk_c), .I0(clk));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    GND i61 (.X(gnd));
    OBUF result_pad_0 (.O(result[0]), .I0(result_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF result_pad_6 (.O(result[6]), .I0(result_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF result_pad_1 (.O(result[1]), .I0(result_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF result_pad_2 (.O(result[2]), .I0(result_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF result_pad_3 (.O(result[3]), .I0(result_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF result_pad_4 (.O(result[4]), .I0(result_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    OBUF result_pad_5 (.O(result[5]), .I0(result_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    IBUF reset_pad (.O(reset_c), .I0(reset));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OR2 i4 (.O(n12), .I0(int_Data_c_7), .I1(n2));
    INV i25 (.O(n2), .I0(int_Data_c_1));
    OR2 i2 (.O(n10), .I0(int_Data_c_4), .I1(int_Data_c_2));
    VCC i62 (.X(pwr));
    INV i26 (.O(n1), .I0(int_Data_c_0));
    DFFCS result__i1 (.Q(result_c), .D(result_7__N_11[7]), .CLK(clk_c), 
          .CE(flag_Over_c), .S(reset_c));   // compare.v(29[14] 43[12])
    IBUF int_Data_pad_7 (.O(int_Data_c_7), .I0(int_Data[7]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF int_Data_pad_6 (.O(int_Data_c_6), .I0(int_Data[6]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF int_Data_pad_5 (.O(int_Data_c_5), .I0(int_Data[5]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF int_Data_pad_4 (.O(int_Data_c_4), .I0(int_Data[4]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF int_Data_pad_3 (.O(int_Data_c_3), .I0(int_Data[3]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF int_Data_pad_2 (.O(int_Data_c_2), .I0(int_Data[2]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF int_Data_pad_1 (.O(int_Data_c_1), .I0(int_Data[1]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF int_Data_pad_0 (.O(int_Data_c_0), .I0(int_Data[0]));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    IBUF flag_Over_pad (.O(flag_Over_c), .I0(flag_Over));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(186[8:12])
    OR6 i7 (.O(result_7__N_11[7]), .I0(int_Data_c_5), .I1(n12), .I2(int_Data_c_6), 
        .I3(n10), .I4(int_Data_c_3), .I5(n1));
    OBUF result_pad_7 (.O(result[7]), .I0(result_c));   // E:/Bin/lse/userware/NT/SYNTHESIS_HEADERS/mach.v(270[8:12])
    
endmodule
//
// Verilog Description of module GND
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
// Verilog Description of module VCC
// module not written out since it is a black-box. 
//

//
// Verilog Description of module OR6
// module not written out since it is a black-box. 
//

