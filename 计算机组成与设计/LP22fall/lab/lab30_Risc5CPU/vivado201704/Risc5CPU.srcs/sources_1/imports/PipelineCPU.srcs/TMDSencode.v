
module TMDSencode(  
    //时钟
	input  tmds_clk,  //  
    input  pixel_clk, 
	//复位信号，高电平有效
	input reset,
    //视频信号
    input[7:0] red,
	input[7:0] green,
	input[7:0] blue,
	input hSync,
	input vSync,
	input ActiveArea,
	//TMDS通道输出数据
    output  TMDSch0,
	output  TMDSch1,
	output  TMDSch2
); 

endmodule   
