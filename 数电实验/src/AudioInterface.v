`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
//: 
//
//////////////////////////////////////////////////////////////////////////////////

module AudioInterface(
    input clk,
    input reset,
    input  ADC_SDATA,
    output DAC_SDATA,
    output BCLK,
    output MCLK,
    output LRCLK,
    inout SCL,
    inout SDA,
	 output error,
	 input[23:0] LeftPlayData,
	 input[23:0] RightPlayData,
	 output [23:0] LeftRecData,
	 output [23:0] RightRecData,
	 output NewFrame
	 );
	 
	 endmodule
