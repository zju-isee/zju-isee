// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Mon Oct 31 21:33:57 2022
// Host        : LAPTOP-OMEN-BAO running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               D:/Desktop/COD_Lab/lab8/vivado/lab8.sim/sim_1/impl/timing/modelsim/adder_32bits_tb_time_impl.v
// Design      : adder_32bits
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a200tfbv484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "682e1441" *) 
(* NotValidForBitStream *)
module adder_32bits
   (a,
    b,
    ci,
    s,
    co);
  input [31:0]a;
  input [31:0]b;
  input ci;
  output [31:0]s;
  output co;

  wire [31:0]a;
  wire [31:0]a_IBUF;
  wire \adder0/c_1__1 ;
  wire \adder1/adder0/c_2__1 ;
  wire \adder1/adder1/c_2__1 ;
  wire \adder1/c0 ;
  wire \adder1/c1 ;
  wire \adder2/adder0/c_2__1 ;
  wire \adder2/adder1/c_2__1 ;
  wire \adder2/c0 ;
  wire \adder2/c1 ;
  wire \adder3/adder0/c_2__1 ;
  wire \adder3/adder1/c_2__1 ;
  wire \adder3/c0 ;
  wire \adder3/c1 ;
  wire \adder4/adder0/c_2__1 ;
  wire \adder4/adder1/c_2__1 ;
  wire \adder4/c0 ;
  wire \adder4/c1 ;
  wire \adder5/adder0/c_2__1 ;
  wire \adder5/adder1/c_2__1 ;
  wire \adder5/c0 ;
  wire \adder5/c1 ;
  wire \adder6/adder0/c_2__1 ;
  wire \adder6/adder1/c_2__1 ;
  wire \adder6/c0 ;
  wire \adder6/c1 ;
  wire \adder7/adder0/c_2__1 ;
  wire \adder7/adder1/c_2__1 ;
  wire [31:0]b;
  wire [31:0]b_IBUF;
  wire c1;
  wire c2;
  wire c3;
  wire c4;
  wire c5;
  wire c6;
  wire c7;
  wire ci;
  wire ci_IBUF;
  wire co;
  wire co_OBUF;
  wire [31:0]s;
  wire [31:0]s_OBUF;
  wire \s_OBUF[10]_inst_i_2_n_0 ;
  wire \s_OBUF[14]_inst_i_2_n_0 ;
  wire \s_OBUF[18]_inst_i_2_n_0 ;
  wire \s_OBUF[22]_inst_i_2_n_0 ;
  wire \s_OBUF[26]_inst_i_2_n_0 ;
  wire \s_OBUF[30]_inst_i_2_n_0 ;
  wire \s_OBUF[6]_inst_i_2_n_0 ;

initial begin
 $sdf_annotate("adder_32bits_tb_time_impl.sdf",,,,"tool_control");
end
  IBUF \a_IBUF[0]_inst 
       (.I(a[0]),
        .O(a_IBUF[0]));
  IBUF \a_IBUF[10]_inst 
       (.I(a[10]),
        .O(a_IBUF[10]));
  IBUF \a_IBUF[11]_inst 
       (.I(a[11]),
        .O(a_IBUF[11]));
  IBUF \a_IBUF[12]_inst 
       (.I(a[12]),
        .O(a_IBUF[12]));
  IBUF \a_IBUF[13]_inst 
       (.I(a[13]),
        .O(a_IBUF[13]));
  IBUF \a_IBUF[14]_inst 
       (.I(a[14]),
        .O(a_IBUF[14]));
  IBUF \a_IBUF[15]_inst 
       (.I(a[15]),
        .O(a_IBUF[15]));
  IBUF \a_IBUF[16]_inst 
       (.I(a[16]),
        .O(a_IBUF[16]));
  IBUF \a_IBUF[17]_inst 
       (.I(a[17]),
        .O(a_IBUF[17]));
  IBUF \a_IBUF[18]_inst 
       (.I(a[18]),
        .O(a_IBUF[18]));
  IBUF \a_IBUF[19]_inst 
       (.I(a[19]),
        .O(a_IBUF[19]));
  IBUF \a_IBUF[1]_inst 
       (.I(a[1]),
        .O(a_IBUF[1]));
  IBUF \a_IBUF[20]_inst 
       (.I(a[20]),
        .O(a_IBUF[20]));
  IBUF \a_IBUF[21]_inst 
       (.I(a[21]),
        .O(a_IBUF[21]));
  IBUF \a_IBUF[22]_inst 
       (.I(a[22]),
        .O(a_IBUF[22]));
  IBUF \a_IBUF[23]_inst 
       (.I(a[23]),
        .O(a_IBUF[23]));
  IBUF \a_IBUF[24]_inst 
       (.I(a[24]),
        .O(a_IBUF[24]));
  IBUF \a_IBUF[25]_inst 
       (.I(a[25]),
        .O(a_IBUF[25]));
  IBUF \a_IBUF[26]_inst 
       (.I(a[26]),
        .O(a_IBUF[26]));
  IBUF \a_IBUF[27]_inst 
       (.I(a[27]),
        .O(a_IBUF[27]));
  IBUF \a_IBUF[28]_inst 
       (.I(a[28]),
        .O(a_IBUF[28]));
  IBUF \a_IBUF[29]_inst 
       (.I(a[29]),
        .O(a_IBUF[29]));
  IBUF \a_IBUF[2]_inst 
       (.I(a[2]),
        .O(a_IBUF[2]));
  IBUF \a_IBUF[30]_inst 
       (.I(a[30]),
        .O(a_IBUF[30]));
  IBUF \a_IBUF[31]_inst 
       (.I(a[31]),
        .O(a_IBUF[31]));
  IBUF \a_IBUF[3]_inst 
       (.I(a[3]),
        .O(a_IBUF[3]));
  IBUF \a_IBUF[4]_inst 
       (.I(a[4]),
        .O(a_IBUF[4]));
  IBUF \a_IBUF[5]_inst 
       (.I(a[5]),
        .O(a_IBUF[5]));
  IBUF \a_IBUF[6]_inst 
       (.I(a[6]),
        .O(a_IBUF[6]));
  IBUF \a_IBUF[7]_inst 
       (.I(a[7]),
        .O(a_IBUF[7]));
  IBUF \a_IBUF[8]_inst 
       (.I(a[8]),
        .O(a_IBUF[8]));
  IBUF \a_IBUF[9]_inst 
       (.I(a[9]),
        .O(a_IBUF[9]));
  IBUF \b_IBUF[0]_inst 
       (.I(b[0]),
        .O(b_IBUF[0]));
  IBUF \b_IBUF[10]_inst 
       (.I(b[10]),
        .O(b_IBUF[10]));
  IBUF \b_IBUF[11]_inst 
       (.I(b[11]),
        .O(b_IBUF[11]));
  IBUF \b_IBUF[12]_inst 
       (.I(b[12]),
        .O(b_IBUF[12]));
  IBUF \b_IBUF[13]_inst 
       (.I(b[13]),
        .O(b_IBUF[13]));
  IBUF \b_IBUF[14]_inst 
       (.I(b[14]),
        .O(b_IBUF[14]));
  IBUF \b_IBUF[15]_inst 
       (.I(b[15]),
        .O(b_IBUF[15]));
  IBUF \b_IBUF[16]_inst 
       (.I(b[16]),
        .O(b_IBUF[16]));
  IBUF \b_IBUF[17]_inst 
       (.I(b[17]),
        .O(b_IBUF[17]));
  IBUF \b_IBUF[18]_inst 
       (.I(b[18]),
        .O(b_IBUF[18]));
  IBUF \b_IBUF[19]_inst 
       (.I(b[19]),
        .O(b_IBUF[19]));
  IBUF \b_IBUF[1]_inst 
       (.I(b[1]),
        .O(b_IBUF[1]));
  IBUF \b_IBUF[20]_inst 
       (.I(b[20]),
        .O(b_IBUF[20]));
  IBUF \b_IBUF[21]_inst 
       (.I(b[21]),
        .O(b_IBUF[21]));
  IBUF \b_IBUF[22]_inst 
       (.I(b[22]),
        .O(b_IBUF[22]));
  IBUF \b_IBUF[23]_inst 
       (.I(b[23]),
        .O(b_IBUF[23]));
  IBUF \b_IBUF[24]_inst 
       (.I(b[24]),
        .O(b_IBUF[24]));
  IBUF \b_IBUF[25]_inst 
       (.I(b[25]),
        .O(b_IBUF[25]));
  IBUF \b_IBUF[26]_inst 
       (.I(b[26]),
        .O(b_IBUF[26]));
  IBUF \b_IBUF[27]_inst 
       (.I(b[27]),
        .O(b_IBUF[27]));
  IBUF \b_IBUF[28]_inst 
       (.I(b[28]),
        .O(b_IBUF[28]));
  IBUF \b_IBUF[29]_inst 
       (.I(b[29]),
        .O(b_IBUF[29]));
  IBUF \b_IBUF[2]_inst 
       (.I(b[2]),
        .O(b_IBUF[2]));
  IBUF \b_IBUF[30]_inst 
       (.I(b[30]),
        .O(b_IBUF[30]));
  IBUF \b_IBUF[31]_inst 
       (.I(b[31]),
        .O(b_IBUF[31]));
  IBUF \b_IBUF[3]_inst 
       (.I(b[3]),
        .O(b_IBUF[3]));
  IBUF \b_IBUF[4]_inst 
       (.I(b[4]),
        .O(b_IBUF[4]));
  IBUF \b_IBUF[5]_inst 
       (.I(b[5]),
        .O(b_IBUF[5]));
  IBUF \b_IBUF[6]_inst 
       (.I(b[6]),
        .O(b_IBUF[6]));
  IBUF \b_IBUF[7]_inst 
       (.I(b[7]),
        .O(b_IBUF[7]));
  IBUF \b_IBUF[8]_inst 
       (.I(b[8]),
        .O(b_IBUF[8]));
  IBUF \b_IBUF[9]_inst 
       (.I(b[9]),
        .O(b_IBUF[9]));
  IBUF ci_IBUF_inst
       (.I(ci),
        .O(ci_IBUF));
  OBUF co_OBUF_inst
       (.I(co_OBUF),
        .O(co));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'hFFB8B800)) 
    co_OBUF_inst_i_1
       (.I0(\adder7/adder1/c_2__1 ),
        .I1(c7),
        .I2(\adder7/adder0/c_2__1 ),
        .I3(a_IBUF[31]),
        .I4(b_IBUF[31]),
        .O(co_OBUF));
  OBUF \s_OBUF[0]_inst 
       (.I(s_OBUF[0]),
        .O(s[0]));
  LUT3 #(
    .INIT(8'h96)) 
    \s_OBUF[0]_inst_i_1 
       (.I0(a_IBUF[0]),
        .I1(b_IBUF[0]),
        .I2(ci_IBUF),
        .O(s_OBUF[0]));
  OBUF \s_OBUF[10]_inst 
       (.I(s_OBUF[10]),
        .O(s[10]));
  LUT6 #(
    .INIT(64'h333C366C366C3CCC)) 
    \s_OBUF[10]_inst_i_1 
       (.I0(c2),
        .I1(\s_OBUF[10]_inst_i_2_n_0 ),
        .I2(b_IBUF[9]),
        .I3(a_IBUF[9]),
        .I4(b_IBUF[8]),
        .I5(a_IBUF[8]),
        .O(s_OBUF[10]));
  LUT2 #(
    .INIT(4'h6)) 
    \s_OBUF[10]_inst_i_2 
       (.I0(b_IBUF[10]),
        .I1(a_IBUF[10]),
        .O(\s_OBUF[10]_inst_i_2_n_0 ));
  OBUF \s_OBUF[11]_inst 
       (.I(s_OBUF[11]),
        .O(s[11]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT5 #(
    .INIT(32'hB44B8778)) 
    \s_OBUF[11]_inst_i_1 
       (.I0(\adder2/adder1/c_2__1 ),
        .I1(c2),
        .I2(a_IBUF[11]),
        .I3(b_IBUF[11]),
        .I4(\adder2/adder0/c_2__1 ),
        .O(s_OBUF[11]));
  LUT6 #(
    .INIT(64'hFFFFFEE0FEE00000)) 
    \s_OBUF[11]_inst_i_2 
       (.I0(b_IBUF[8]),
        .I1(a_IBUF[8]),
        .I2(a_IBUF[9]),
        .I3(b_IBUF[9]),
        .I4(a_IBUF[10]),
        .I5(b_IBUF[10]),
        .O(\adder2/adder1/c_2__1 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'hFFB8B800)) 
    \s_OBUF[11]_inst_i_3 
       (.I0(\adder1/adder1/c_2__1 ),
        .I1(c1),
        .I2(\adder1/adder0/c_2__1 ),
        .I3(a_IBUF[7]),
        .I4(b_IBUF[7]),
        .O(c2));
  LUT6 #(
    .INIT(64'hFFFFF880F8800000)) 
    \s_OBUF[11]_inst_i_4 
       (.I0(a_IBUF[8]),
        .I1(b_IBUF[8]),
        .I2(a_IBUF[9]),
        .I3(b_IBUF[9]),
        .I4(a_IBUF[10]),
        .I5(b_IBUF[10]),
        .O(\adder2/adder0/c_2__1 ));
  OBUF \s_OBUF[12]_inst 
       (.I(s_OBUF[12]),
        .O(s[12]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \s_OBUF[12]_inst_i_1 
       (.I0(c3),
        .I1(a_IBUF[12]),
        .I2(b_IBUF[12]),
        .O(s_OBUF[12]));
  OBUF \s_OBUF[13]_inst 
       (.I(s_OBUF[13]),
        .O(s[13]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'hC396963C)) 
    \s_OBUF[13]_inst_i_1 
       (.I0(c3),
        .I1(a_IBUF[13]),
        .I2(b_IBUF[13]),
        .I3(b_IBUF[12]),
        .I4(a_IBUF[12]),
        .O(s_OBUF[13]));
  OBUF \s_OBUF[14]_inst 
       (.I(s_OBUF[14]),
        .O(s[14]));
  LUT6 #(
    .INIT(64'h333C366C366C3CCC)) 
    \s_OBUF[14]_inst_i_1 
       (.I0(c3),
        .I1(\s_OBUF[14]_inst_i_2_n_0 ),
        .I2(b_IBUF[13]),
        .I3(a_IBUF[13]),
        .I4(b_IBUF[12]),
        .I5(a_IBUF[12]),
        .O(s_OBUF[14]));
  LUT2 #(
    .INIT(4'h6)) 
    \s_OBUF[14]_inst_i_2 
       (.I0(b_IBUF[14]),
        .I1(a_IBUF[14]),
        .O(\s_OBUF[14]_inst_i_2_n_0 ));
  OBUF \s_OBUF[15]_inst 
       (.I(s_OBUF[15]),
        .O(s[15]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'hB44B8778)) 
    \s_OBUF[15]_inst_i_1 
       (.I0(\adder3/adder1/c_2__1 ),
        .I1(c3),
        .I2(a_IBUF[15]),
        .I3(b_IBUF[15]),
        .I4(\adder3/adder0/c_2__1 ),
        .O(s_OBUF[15]));
  LUT6 #(
    .INIT(64'hFFFFFEE0FEE00000)) 
    \s_OBUF[15]_inst_i_2 
       (.I0(b_IBUF[12]),
        .I1(a_IBUF[12]),
        .I2(a_IBUF[13]),
        .I3(b_IBUF[13]),
        .I4(a_IBUF[14]),
        .I5(b_IBUF[14]),
        .O(\adder3/adder1/c_2__1 ));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \s_OBUF[15]_inst_i_3 
       (.I0(\adder2/c1 ),
        .I1(\adder1/c1 ),
        .I2(c1),
        .I3(\adder1/c0 ),
        .I4(\adder2/c0 ),
        .O(c3));
  LUT6 #(
    .INIT(64'hFFFFF880F8800000)) 
    \s_OBUF[15]_inst_i_4 
       (.I0(a_IBUF[12]),
        .I1(b_IBUF[12]),
        .I2(a_IBUF[13]),
        .I3(b_IBUF[13]),
        .I4(a_IBUF[14]),
        .I5(b_IBUF[14]),
        .O(\adder3/adder0/c_2__1 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \s_OBUF[15]_inst_i_5 
       (.I0(\adder2/adder1/c_2__1 ),
        .I1(a_IBUF[11]),
        .I2(b_IBUF[11]),
        .O(\adder2/c1 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \s_OBUF[15]_inst_i_6 
       (.I0(\adder1/adder1/c_2__1 ),
        .I1(a_IBUF[7]),
        .I2(b_IBUF[7]),
        .O(\adder1/c1 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \s_OBUF[15]_inst_i_7 
       (.I0(\adder1/adder0/c_2__1 ),
        .I1(a_IBUF[7]),
        .I2(b_IBUF[7]),
        .O(\adder1/c0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \s_OBUF[15]_inst_i_8 
       (.I0(\adder2/adder0/c_2__1 ),
        .I1(a_IBUF[11]),
        .I2(b_IBUF[11]),
        .O(\adder2/c0 ));
  OBUF \s_OBUF[16]_inst 
       (.I(s_OBUF[16]),
        .O(s[16]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \s_OBUF[16]_inst_i_1 
       (.I0(c4),
        .I1(a_IBUF[16]),
        .I2(b_IBUF[16]),
        .O(s_OBUF[16]));
  OBUF \s_OBUF[17]_inst 
       (.I(s_OBUF[17]),
        .O(s[17]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hC396963C)) 
    \s_OBUF[17]_inst_i_1 
       (.I0(c4),
        .I1(a_IBUF[17]),
        .I2(b_IBUF[17]),
        .I3(b_IBUF[16]),
        .I4(a_IBUF[16]),
        .O(s_OBUF[17]));
  OBUF \s_OBUF[18]_inst 
       (.I(s_OBUF[18]),
        .O(s[18]));
  LUT6 #(
    .INIT(64'h333C366C366C3CCC)) 
    \s_OBUF[18]_inst_i_1 
       (.I0(c4),
        .I1(\s_OBUF[18]_inst_i_2_n_0 ),
        .I2(b_IBUF[17]),
        .I3(a_IBUF[17]),
        .I4(b_IBUF[16]),
        .I5(a_IBUF[16]),
        .O(s_OBUF[18]));
  LUT2 #(
    .INIT(4'h6)) 
    \s_OBUF[18]_inst_i_2 
       (.I0(b_IBUF[18]),
        .I1(a_IBUF[18]),
        .O(\s_OBUF[18]_inst_i_2_n_0 ));
  OBUF \s_OBUF[19]_inst 
       (.I(s_OBUF[19]),
        .O(s[19]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'hB44B8778)) 
    \s_OBUF[19]_inst_i_1 
       (.I0(\adder4/adder1/c_2__1 ),
        .I1(c4),
        .I2(a_IBUF[19]),
        .I3(b_IBUF[19]),
        .I4(\adder4/adder0/c_2__1 ),
        .O(s_OBUF[19]));
  LUT6 #(
    .INIT(64'hFFFFFEE0FEE00000)) 
    \s_OBUF[19]_inst_i_2 
       (.I0(b_IBUF[16]),
        .I1(a_IBUF[16]),
        .I2(a_IBUF[17]),
        .I3(b_IBUF[17]),
        .I4(a_IBUF[18]),
        .I5(b_IBUF[18]),
        .O(\adder4/adder1/c_2__1 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'hFFB8B800)) 
    \s_OBUF[19]_inst_i_3 
       (.I0(\adder3/adder1/c_2__1 ),
        .I1(c3),
        .I2(\adder3/adder0/c_2__1 ),
        .I3(a_IBUF[15]),
        .I4(b_IBUF[15]),
        .O(c4));
  LUT6 #(
    .INIT(64'hFFFFF880F8800000)) 
    \s_OBUF[19]_inst_i_4 
       (.I0(a_IBUF[16]),
        .I1(b_IBUF[16]),
        .I2(a_IBUF[17]),
        .I3(b_IBUF[17]),
        .I4(a_IBUF[18]),
        .I5(b_IBUF[18]),
        .O(\adder4/adder0/c_2__1 ));
  OBUF \s_OBUF[1]_inst 
       (.I(s_OBUF[1]),
        .O(s[1]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'h99969666)) 
    \s_OBUF[1]_inst_i_1 
       (.I0(a_IBUF[1]),
        .I1(b_IBUF[1]),
        .I2(b_IBUF[0]),
        .I3(a_IBUF[0]),
        .I4(ci_IBUF),
        .O(s_OBUF[1]));
  OBUF \s_OBUF[20]_inst 
       (.I(s_OBUF[20]),
        .O(s[20]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \s_OBUF[20]_inst_i_1 
       (.I0(c5),
        .I1(a_IBUF[20]),
        .I2(b_IBUF[20]),
        .O(s_OBUF[20]));
  OBUF \s_OBUF[21]_inst 
       (.I(s_OBUF[21]),
        .O(s[21]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hC396963C)) 
    \s_OBUF[21]_inst_i_1 
       (.I0(c5),
        .I1(a_IBUF[21]),
        .I2(b_IBUF[21]),
        .I3(b_IBUF[20]),
        .I4(a_IBUF[20]),
        .O(s_OBUF[21]));
  OBUF \s_OBUF[22]_inst 
       (.I(s_OBUF[22]),
        .O(s[22]));
  LUT6 #(
    .INIT(64'h333C366C366C3CCC)) 
    \s_OBUF[22]_inst_i_1 
       (.I0(c5),
        .I1(\s_OBUF[22]_inst_i_2_n_0 ),
        .I2(b_IBUF[21]),
        .I3(a_IBUF[21]),
        .I4(b_IBUF[20]),
        .I5(a_IBUF[20]),
        .O(s_OBUF[22]));
  LUT2 #(
    .INIT(4'h6)) 
    \s_OBUF[22]_inst_i_2 
       (.I0(b_IBUF[22]),
        .I1(a_IBUF[22]),
        .O(\s_OBUF[22]_inst_i_2_n_0 ));
  OBUF \s_OBUF[23]_inst 
       (.I(s_OBUF[23]),
        .O(s[23]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hB44B8778)) 
    \s_OBUF[23]_inst_i_1 
       (.I0(\adder5/adder1/c_2__1 ),
        .I1(c5),
        .I2(a_IBUF[23]),
        .I3(b_IBUF[23]),
        .I4(\adder5/adder0/c_2__1 ),
        .O(s_OBUF[23]));
  LUT6 #(
    .INIT(64'hFFFFFEE0FEE00000)) 
    \s_OBUF[23]_inst_i_2 
       (.I0(b_IBUF[20]),
        .I1(a_IBUF[20]),
        .I2(a_IBUF[21]),
        .I3(b_IBUF[21]),
        .I4(a_IBUF[22]),
        .I5(b_IBUF[22]),
        .O(\adder5/adder1/c_2__1 ));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \s_OBUF[23]_inst_i_3 
       (.I0(\adder4/c1 ),
        .I1(\adder3/c1 ),
        .I2(c3),
        .I3(\adder3/c0 ),
        .I4(\adder4/c0 ),
        .O(c5));
  LUT6 #(
    .INIT(64'hFFFFF880F8800000)) 
    \s_OBUF[23]_inst_i_4 
       (.I0(a_IBUF[20]),
        .I1(b_IBUF[20]),
        .I2(a_IBUF[21]),
        .I3(b_IBUF[21]),
        .I4(a_IBUF[22]),
        .I5(b_IBUF[22]),
        .O(\adder5/adder0/c_2__1 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \s_OBUF[23]_inst_i_5 
       (.I0(\adder4/adder1/c_2__1 ),
        .I1(a_IBUF[19]),
        .I2(b_IBUF[19]),
        .O(\adder4/c1 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \s_OBUF[23]_inst_i_6 
       (.I0(\adder3/adder1/c_2__1 ),
        .I1(a_IBUF[15]),
        .I2(b_IBUF[15]),
        .O(\adder3/c1 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \s_OBUF[23]_inst_i_7 
       (.I0(\adder3/adder0/c_2__1 ),
        .I1(a_IBUF[15]),
        .I2(b_IBUF[15]),
        .O(\adder3/c0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \s_OBUF[23]_inst_i_8 
       (.I0(\adder4/adder0/c_2__1 ),
        .I1(a_IBUF[19]),
        .I2(b_IBUF[19]),
        .O(\adder4/c0 ));
  OBUF \s_OBUF[24]_inst 
       (.I(s_OBUF[24]),
        .O(s[24]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \s_OBUF[24]_inst_i_1 
       (.I0(c6),
        .I1(a_IBUF[24]),
        .I2(b_IBUF[24]),
        .O(s_OBUF[24]));
  OBUF \s_OBUF[25]_inst 
       (.I(s_OBUF[25]),
        .O(s[25]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hC396963C)) 
    \s_OBUF[25]_inst_i_1 
       (.I0(c6),
        .I1(a_IBUF[25]),
        .I2(b_IBUF[25]),
        .I3(b_IBUF[24]),
        .I4(a_IBUF[24]),
        .O(s_OBUF[25]));
  OBUF \s_OBUF[26]_inst 
       (.I(s_OBUF[26]),
        .O(s[26]));
  LUT6 #(
    .INIT(64'h333C366C366C3CCC)) 
    \s_OBUF[26]_inst_i_1 
       (.I0(c6),
        .I1(\s_OBUF[26]_inst_i_2_n_0 ),
        .I2(b_IBUF[25]),
        .I3(a_IBUF[25]),
        .I4(b_IBUF[24]),
        .I5(a_IBUF[24]),
        .O(s_OBUF[26]));
  LUT2 #(
    .INIT(4'h6)) 
    \s_OBUF[26]_inst_i_2 
       (.I0(b_IBUF[26]),
        .I1(a_IBUF[26]),
        .O(\s_OBUF[26]_inst_i_2_n_0 ));
  OBUF \s_OBUF[27]_inst 
       (.I(s_OBUF[27]),
        .O(s[27]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'hB44B8778)) 
    \s_OBUF[27]_inst_i_1 
       (.I0(\adder6/adder1/c_2__1 ),
        .I1(c6),
        .I2(a_IBUF[27]),
        .I3(b_IBUF[27]),
        .I4(\adder6/adder0/c_2__1 ),
        .O(s_OBUF[27]));
  LUT6 #(
    .INIT(64'hFFFFFEE0FEE00000)) 
    \s_OBUF[27]_inst_i_2 
       (.I0(b_IBUF[24]),
        .I1(a_IBUF[24]),
        .I2(a_IBUF[25]),
        .I3(b_IBUF[25]),
        .I4(a_IBUF[26]),
        .I5(b_IBUF[26]),
        .O(\adder6/adder1/c_2__1 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hFFB8B800)) 
    \s_OBUF[27]_inst_i_3 
       (.I0(\adder5/adder1/c_2__1 ),
        .I1(c5),
        .I2(\adder5/adder0/c_2__1 ),
        .I3(a_IBUF[23]),
        .I4(b_IBUF[23]),
        .O(c6));
  LUT6 #(
    .INIT(64'hFFFFF880F8800000)) 
    \s_OBUF[27]_inst_i_4 
       (.I0(a_IBUF[24]),
        .I1(b_IBUF[24]),
        .I2(a_IBUF[25]),
        .I3(b_IBUF[25]),
        .I4(a_IBUF[26]),
        .I5(b_IBUF[26]),
        .O(\adder6/adder0/c_2__1 ));
  OBUF \s_OBUF[28]_inst 
       (.I(s_OBUF[28]),
        .O(s[28]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \s_OBUF[28]_inst_i_1 
       (.I0(c7),
        .I1(a_IBUF[28]),
        .I2(b_IBUF[28]),
        .O(s_OBUF[28]));
  OBUF \s_OBUF[29]_inst 
       (.I(s_OBUF[29]),
        .O(s[29]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'hC396963C)) 
    \s_OBUF[29]_inst_i_1 
       (.I0(c7),
        .I1(a_IBUF[29]),
        .I2(b_IBUF[29]),
        .I3(b_IBUF[28]),
        .I4(a_IBUF[28]),
        .O(s_OBUF[29]));
  OBUF \s_OBUF[2]_inst 
       (.I(s_OBUF[2]),
        .O(s[2]));
  LUT3 #(
    .INIT(8'h96)) 
    \s_OBUF[2]_inst_i_1 
       (.I0(a_IBUF[2]),
        .I1(b_IBUF[2]),
        .I2(\adder0/c_1__1 ),
        .O(s_OBUF[2]));
  OBUF \s_OBUF[30]_inst 
       (.I(s_OBUF[30]),
        .O(s[30]));
  LUT6 #(
    .INIT(64'h333C366C366C3CCC)) 
    \s_OBUF[30]_inst_i_1 
       (.I0(c7),
        .I1(\s_OBUF[30]_inst_i_2_n_0 ),
        .I2(b_IBUF[29]),
        .I3(a_IBUF[29]),
        .I4(b_IBUF[28]),
        .I5(a_IBUF[28]),
        .O(s_OBUF[30]));
  LUT2 #(
    .INIT(4'h6)) 
    \s_OBUF[30]_inst_i_2 
       (.I0(b_IBUF[30]),
        .I1(a_IBUF[30]),
        .O(\s_OBUF[30]_inst_i_2_n_0 ));
  OBUF \s_OBUF[31]_inst 
       (.I(s_OBUF[31]),
        .O(s[31]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'hB44B8778)) 
    \s_OBUF[31]_inst_i_1 
       (.I0(\adder7/adder1/c_2__1 ),
        .I1(c7),
        .I2(a_IBUF[31]),
        .I3(b_IBUF[31]),
        .I4(\adder7/adder0/c_2__1 ),
        .O(s_OBUF[31]));
  LUT6 #(
    .INIT(64'hFFFFFEE0FEE00000)) 
    \s_OBUF[31]_inst_i_2 
       (.I0(b_IBUF[28]),
        .I1(a_IBUF[28]),
        .I2(a_IBUF[29]),
        .I3(b_IBUF[29]),
        .I4(a_IBUF[30]),
        .I5(b_IBUF[30]),
        .O(\adder7/adder1/c_2__1 ));
  LUT5 #(
    .INIT(32'hBABF8A80)) 
    \s_OBUF[31]_inst_i_3 
       (.I0(\adder6/c1 ),
        .I1(\adder5/c1 ),
        .I2(c5),
        .I3(\adder5/c0 ),
        .I4(\adder6/c0 ),
        .O(c7));
  LUT6 #(
    .INIT(64'hFFFFF880F8800000)) 
    \s_OBUF[31]_inst_i_4 
       (.I0(a_IBUF[28]),
        .I1(b_IBUF[28]),
        .I2(a_IBUF[29]),
        .I3(b_IBUF[29]),
        .I4(a_IBUF[30]),
        .I5(b_IBUF[30]),
        .O(\adder7/adder0/c_2__1 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \s_OBUF[31]_inst_i_5 
       (.I0(\adder6/adder1/c_2__1 ),
        .I1(a_IBUF[27]),
        .I2(b_IBUF[27]),
        .O(\adder6/c1 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \s_OBUF[31]_inst_i_6 
       (.I0(\adder5/adder1/c_2__1 ),
        .I1(a_IBUF[23]),
        .I2(b_IBUF[23]),
        .O(\adder5/c1 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \s_OBUF[31]_inst_i_7 
       (.I0(\adder5/adder0/c_2__1 ),
        .I1(a_IBUF[23]),
        .I2(b_IBUF[23]),
        .O(\adder5/c0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \s_OBUF[31]_inst_i_8 
       (.I0(\adder6/adder0/c_2__1 ),
        .I1(a_IBUF[27]),
        .I2(b_IBUF[27]),
        .O(\adder6/c0 ));
  OBUF \s_OBUF[3]_inst 
       (.I(s_OBUF[3]),
        .O(s[3]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h99969666)) 
    \s_OBUF[3]_inst_i_1 
       (.I0(a_IBUF[3]),
        .I1(b_IBUF[3]),
        .I2(b_IBUF[2]),
        .I3(a_IBUF[2]),
        .I4(\adder0/c_1__1 ),
        .O(s_OBUF[3]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hFFE8E800)) 
    \s_OBUF[3]_inst_i_2 
       (.I0(ci_IBUF),
        .I1(a_IBUF[0]),
        .I2(b_IBUF[0]),
        .I3(a_IBUF[1]),
        .I4(b_IBUF[1]),
        .O(\adder0/c_1__1 ));
  OBUF \s_OBUF[4]_inst 
       (.I(s_OBUF[4]),
        .O(s[4]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \s_OBUF[4]_inst_i_1 
       (.I0(c1),
        .I1(a_IBUF[4]),
        .I2(b_IBUF[4]),
        .O(s_OBUF[4]));
  OBUF \s_OBUF[5]_inst 
       (.I(s_OBUF[5]),
        .O(s[5]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'hC396963C)) 
    \s_OBUF[5]_inst_i_1 
       (.I0(c1),
        .I1(a_IBUF[5]),
        .I2(b_IBUF[5]),
        .I3(b_IBUF[4]),
        .I4(a_IBUF[4]),
        .O(s_OBUF[5]));
  OBUF \s_OBUF[6]_inst 
       (.I(s_OBUF[6]),
        .O(s[6]));
  LUT6 #(
    .INIT(64'h333C366C366C3CCC)) 
    \s_OBUF[6]_inst_i_1 
       (.I0(c1),
        .I1(\s_OBUF[6]_inst_i_2_n_0 ),
        .I2(b_IBUF[5]),
        .I3(a_IBUF[5]),
        .I4(b_IBUF[4]),
        .I5(a_IBUF[4]),
        .O(s_OBUF[6]));
  LUT2 #(
    .INIT(4'h6)) 
    \s_OBUF[6]_inst_i_2 
       (.I0(b_IBUF[6]),
        .I1(a_IBUF[6]),
        .O(\s_OBUF[6]_inst_i_2_n_0 ));
  OBUF \s_OBUF[7]_inst 
       (.I(s_OBUF[7]),
        .O(s[7]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'hB44B8778)) 
    \s_OBUF[7]_inst_i_1 
       (.I0(\adder1/adder1/c_2__1 ),
        .I1(c1),
        .I2(a_IBUF[7]),
        .I3(b_IBUF[7]),
        .I4(\adder1/adder0/c_2__1 ),
        .O(s_OBUF[7]));
  LUT6 #(
    .INIT(64'hFFFFFEE0FEE00000)) 
    \s_OBUF[7]_inst_i_2 
       (.I0(b_IBUF[4]),
        .I1(a_IBUF[4]),
        .I2(a_IBUF[5]),
        .I3(b_IBUF[5]),
        .I4(a_IBUF[6]),
        .I5(b_IBUF[6]),
        .O(\adder1/adder1/c_2__1 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'hFFE8E800)) 
    \s_OBUF[7]_inst_i_3 
       (.I0(\adder0/c_1__1 ),
        .I1(a_IBUF[2]),
        .I2(b_IBUF[2]),
        .I3(a_IBUF[3]),
        .I4(b_IBUF[3]),
        .O(c1));
  LUT6 #(
    .INIT(64'hFFFFF880F8800000)) 
    \s_OBUF[7]_inst_i_4 
       (.I0(a_IBUF[4]),
        .I1(b_IBUF[4]),
        .I2(a_IBUF[5]),
        .I3(b_IBUF[5]),
        .I4(a_IBUF[6]),
        .I5(b_IBUF[6]),
        .O(\adder1/adder0/c_2__1 ));
  OBUF \s_OBUF[8]_inst 
       (.I(s_OBUF[8]),
        .O(s[8]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \s_OBUF[8]_inst_i_1 
       (.I0(c2),
        .I1(a_IBUF[8]),
        .I2(b_IBUF[8]),
        .O(s_OBUF[8]));
  OBUF \s_OBUF[9]_inst 
       (.I(s_OBUF[9]),
        .O(s[9]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hC396963C)) 
    \s_OBUF[9]_inst_i_1 
       (.I0(c2),
        .I1(a_IBUF[9]),
        .I2(b_IBUF[9]),
        .I3(b_IBUF[8]),
        .I4(a_IBUF[8]),
        .O(s_OBUF[9]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
