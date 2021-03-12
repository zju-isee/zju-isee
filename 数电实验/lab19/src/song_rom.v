//	How to use:	
//	1. Edit the songs on the Enter Song sheet.	
// 	2. Select this whole worksheet, copy it, and paste it into a new file.	
//	3. Save the file as song_rom.v.	







module song_rom (		
	clk	,
	dout,
	addr	
	);	

	input clk;						
	output [11:0] dout;						
	input [6:0] addr;						

	wire [11:0] memory [127:0];						
	reg [11:0] dout;						

	always @(posedge clk)						
		dout = memory[addr];					



	assign memory[	0	] =	{6'd49, 6'd12}	;	// Note:	5A
	assign memory[	1	] =	{6'd1, 6'd8}	;	// Note:	1A
	assign memory[	2	] =	{6'd51, 6'd12}	;	// Note:	5B
	assign memory[	3	] =	{6'd3, 6'd8}	;	// Note:	1B
	assign memory[	4	] =	{6'd52, 6'd12}	;	// Note:	5C
	assign memory[	5	] =	{6'd4, 6'd8}	;	// Note:	1C
	assign memory[	6	] =	{6'd54, 6'd12}	;	// Note:	5D
	assign memory[	7	] =	{6'd6, 6'd8}	;	// Note:	1D
	assign memory[	8	] =	{6'd56, 6'd12}	;	// Note:	5E
	assign memory[	9	] =	{6'd8, 6'd8}	;	// Note:	1E
	assign memory[	10	] =	{6'd57, 6'd12}	;	// Note:	5F
	assign memory[	11	] =	{6'd9, 6'd8}	;	// Note:	1F
	assign memory[	12	] =	{6'd59, 6'd12}	;	// Note:	5G
	assign memory[	13	] =	{6'd11, 6'd8}	;	// Note:	1G
	assign memory[	14	] =	{6'd13, 6'd12}	;	// Note:	2A
	assign memory[	15	] =	{6'd25, 6'd8}	;	// Note:	3A
	assign memory[	16	] =	{6'd15, 6'd12}	;	// Note:	2B
	assign memory[	17	] =	{6'd27, 6'd8}	;	// Note:	3B
	assign memory[	18	] =	{6'd16, 6'd12}	;	// Note:	2C
	assign memory[	19	] =	{6'd28, 6'd8}	;	// Note:	3C
	assign memory[	20	] =	{6'd18, 6'd12}	;	// Note:	2D
	assign memory[	21	] =	{6'd30, 6'd8}	;	// Note:	3D
	assign memory[	22	] =	{6'd20, 6'd12}	;	// Note:	2E
	assign memory[	23	] =	{6'd32, 6'd8}	;	// Note:	3E
	assign memory[	24	] =	{6'd21, 6'd12}	;	// Note:	2F
	assign memory[	25	] =	{6'd33, 6'd8}	;	// Note:	3F
	assign memory[	26	] =	{6'd23, 6'd12}	;	// Note:	2G
	assign memory[	27	] =	{6'd35, 6'd8}	;	// Note:	3G
	assign memory[	28	] =	{6'd37, 6'd0}	;	// Note:	4A
	assign memory[	29	] =	{6'd37, 6'd0}	;	// Note:	4A
	assign memory[	30	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	31	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	32	] =	{6'd35, 6'd36}	;	// Note:	3G
	assign memory[	33	] =	{6'd42, 6'd36}	;	// Note:	4D
	assign memory[	34	] =	{6'd38, 6'd54}	;	// Note:	4A#Bb
	assign memory[	35	] =	{6'd37, 6'd18}	;	// Note:	4A
	assign memory[	36	] =	{6'd35, 6'd18}	;	// Note:	3G
	assign memory[	37	] =	{6'd38, 6'd18}	;	// Note:	4A#Bb
	assign memory[	38	] =	{6'd37, 6'd18}	;	// Note:	4A
	assign memory[	39	] =	{6'd35, 6'd18}	;	// Note:	3G
	assign memory[	40	] =	{6'd34, 6'd18}	;	// Note:	3F#Gb
	assign memory[	41	] =	{6'd37, 6'd18}	;	// Note:	4A
	assign memory[	42	] =	{6'd30, 6'd36}	;	// Note:	3D
	assign memory[	43	] =	{6'd35, 6'd18}	;	// Note:	3G
	assign memory[	44	] =	{6'd30, 6'd18}	;	// Note:	3D
	assign memory[	45	] =	{6'd37, 6'd18}	;	// Note:	4A
	assign memory[	46	] =	{6'd30, 6'd18}	;	// Note:	3D
	assign memory[	47	] =	{6'd38, 6'd18}	;	// Note:	4A#Bb
	assign memory[	48	] =	{6'd37, 6'd9}	;	// Note:	4A
	assign memory[	49	] =	{6'd35, 6'd9}	;	// Note:	3G
	assign memory[	50	] =	{6'd37, 6'd18}	;	// Note:	4A
	assign memory[	51	] =	{6'd30, 6'd18}	;	// Note:	3D
	assign memory[	52	] =	{6'd35, 6'd18}	;	// Note:	3G
	assign memory[	53	] =	{6'd30, 6'd9}	;	// Note:	3D
	assign memory[	54	] =	{6'd35, 6'd9}	;	// Note:	3G
	assign memory[	55	] =	{6'd37, 6'd18}	;	// Note:	4A
	assign memory[	56	] =	{6'd30, 6'd9}	;	// Note:	3D
	assign memory[	57	] =	{6'd37, 6'd9}	;	// Note:	4A
	assign memory[	58	] =	{6'd38, 6'd18}	;	// Note:	4A#Bb
	assign memory[	59	] =	{6'd37, 6'd9}	;	// Note:	4A
	assign memory[	60	] =	{6'd35, 6'd9}	;	// Note:	3G
	assign memory[	61	] =	{6'd37, 6'd9}	;	// Note:	4A
	assign memory[	62	] =	{6'd30, 6'd9}	;	// Note:	3D
	assign memory[	63	] =	{6'd42, 6'd9}	;	// Note:	4D
	assign memory[	64	] =	{6'd43, 6'd6}	;	// Note:	4D#Eb
	assign memory[	65	] =	{6'd44, 6'd8}	;	// Note:	4E
	assign memory[	66	] =	{6'd0, 6'd34}	;	// Note:	rest
	assign memory[	67	] =	{6'd46, 6'd6}	;	// Note:	4F#Gb
	assign memory[	68	] =	{6'd47, 6'd8}	;	// Note:	4G
	assign memory[	69	] =	{6'd0, 6'd34}	;	// Note:	rest
	assign memory[	70	] =	{6'd43, 6'd6}	;	// Note:	4D#Eb
	assign memory[	71	] =	{6'd44, 6'd8}	;	// Note:	4E
	assign memory[	72	] =	{6'd0, 6'd10}	;	// Note:	rest
	assign memory[	73	] =	{6'd46, 6'd6}	;	// Note:	4F#Gb
	assign memory[	74	] =	{6'd47, 6'd8}	;	// Note:	4G
	assign memory[	75	] =	{6'd0, 6'd10}	;	// Note:	rest
	assign memory[	76	] =	{6'd52, 6'd6}	;	// Note:	5C
	assign memory[	77	] =	{6'd51, 6'd8}	;	// Note:	5B
	assign memory[	78	] =	{6'd0, 6'd10}	;	// Note:	rest
	assign memory[	79	] =	{6'd44, 6'd6}	;	// Note:	4E
	assign memory[	80	] =	{6'd47, 6'd8}	;	// Note:	4G
	assign memory[	81	] =	{6'd0, 6'd10}	;	// Note:	rest
	assign memory[	82	] =	{6'd51, 6'd6}	;	// Note:	5B
	assign memory[	83	] =	{6'd50, 6'd56}	;	// Note:	5A#Bb
	assign memory[	84	] =	{6'd49, 6'd8}	;	// Note:	5A
	assign memory[	85	] =	{6'd47, 6'd8}	;	// Note:	4G
	assign memory[	86	] =	{6'd44, 6'd8}	;	// Note:	4E
	assign memory[	87	] =	{6'd42, 6'd8}	;	// Note:	4D
	assign memory[	88	] =	{6'd44, 6'd40}	;	// Note:	4E
	assign memory[	89	] =	{6'd0, 6'd60}	;	// Note:	rest
	assign memory[	90	] =	{6'd43, 6'd6}	;	// Note:	4D#Eb
	assign memory[	91	] =	{6'd44, 6'd14}	;	// Note:	4E
	assign memory[	92	] =	{6'd0, 6'd28}	;	// Note:	rest
	assign memory[	93	] =	{6'd46, 6'd6}	;	// Note:	4F#Gb
	assign memory[	94	] =	{6'd47, 6'd16}	;	// Note:	4G
	assign memory[	95	] =	{6'd0, 6'd26}	;	// Note:	rest
	assign memory[	96	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	97	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	98	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	99	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	100	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	101	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	102	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	103	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	104	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	105	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	106	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	107	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	108	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	109	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	110	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	111	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	112	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	113	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	114	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	115	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	116	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	117	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	118	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	119	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	120	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	121	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	122	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	123	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	124	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	125	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	126	] =	{6'd0, 6'd0}	;	// Note:	rest
	assign memory[	127	] =	{6'd0, 6'd0}	;	// Note:	rest
endmodule							
