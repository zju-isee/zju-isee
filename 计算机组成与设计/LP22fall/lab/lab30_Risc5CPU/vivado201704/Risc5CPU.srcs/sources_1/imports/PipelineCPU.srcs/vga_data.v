//***********************************************************************
// File name		:	 vga_data.v
// Author			:	qmj
//***********************************************************************

module vga_data (
	// ================= system signals =================================
	input wire					pixel_clk			, // system clock, 25MHz
	// ================= input signals ==================================
	input wire	[ 7 : 0 ]		PC		, // ps
	input wire	[1 : 0 ]		JumpFlag	, //
	input wire	[31:0]         ALU_A,
    input wire	[31:0] ALU_B,
    input wire	[31:0] ALUResult,
    input wire	[31:0] MemData,
    input wire	[31:0] Instruction,
    input wire  Stall,	
	input wire	[ 9 : 0 ]		x_pos		, // vga input x position
	input wire	[ 8 : 0 ]		y_pos		, // vga input y position

	// ================= output signals =================================

	 output[7:0] red,
	 output[7:0] green,
     output[7:0] blue
);
// ======================================================================
//
// char_selection
//
// ======================================================================
 wire[9:0] next_x_pos;
 assign next_x_pos=x_pos+1;
 reg[3:0] char_selection;
 wire char_en;
 
 always @(*)
    case (y_pos[8:5])
	 4'b0010:
	    if ((next_x_pos[9:4])==6'b000100) char_selection= PC[7:4] ;
		  else if ((next_x_pos[9:4])==6'b000101)  char_selection= PC[3:0] ;
		    else if ((next_x_pos[9:4])==6'b001011)  char_selection=Stall ; 
				 else char_selection=4'bxxxx;
	 4'b0100:
	    if ((next_x_pos[9:4])==6'b000100) char_selection= Instruction[31:28] ;
		  else if ((next_x_pos[9:4])==6'b000101)  char_selection= Instruction[27:24] ;
		   else if ((next_x_pos[9:4])==6'b000110)  char_selection= Instruction[23:20] ;  
          else if ((next_x_pos[9:4])==6'b000111)  char_selection= Instruction[19:16] ;
		     else if ((next_x_pos[9:4])==6'b001000)  char_selection= Instruction[15:12] ;  
    		   else if ((next_x_pos[9:4])==6'b001001)  char_selection= Instruction[11:8] ;
		       else if ((next_x_pos[9:4])==6'b001010)  char_selection= Instruction[7:4] ;  
              else if ((next_x_pos[9:4])==6'b001011)  char_selection= Instruction[3:0] ;
		         else if ((next_x_pos[9:4])==6'b001110)  char_selection= JumpFlag ;  
			 	     else char_selection=4'bxxxx;	
  
	4'b0110:
	    if ((next_x_pos[9:4])==6'b000100) char_selection= ALU_A[31:28] ;
		  else if ((next_x_pos[9:4])==6'b000101)  char_selection= ALU_A[27:24] ;
		   else if ((next_x_pos[9:4])==6'b000110)  char_selection= ALU_A[23:20] ;  
          else if ((next_x_pos[9:4])==6'b000111)  char_selection= ALU_A[19:16] ;
		     else if ((next_x_pos[9:4])==6'b001000)  char_selection= ALU_A[15:12] ;  
    		   else if ((next_x_pos[9:4])==6'b001001)  char_selection= ALU_A[11:8] ;
		       else if ((next_x_pos[9:4])==6'b001010)  char_selection= ALU_A[7:4] ;  
              else if ((next_x_pos[9:4])==6'b001011)  char_selection= ALU_A[3:0] ;
			 	     else char_selection=4'bxxxx;	
    4'b0111:
	    if ((next_x_pos[9:4])==6'b000100) char_selection= ALU_B[31:28] ;
		  else if ((next_x_pos[9:4])==6'b000101)  char_selection= ALU_B[27:24] ;
		   else if ((next_x_pos[9:4])==6'b000110)  char_selection= ALU_B[23:20] ;  
          else if ((next_x_pos[9:4])==6'b000111)  char_selection= ALU_B[19:16] ;
		     else if ((next_x_pos[9:4])==6'b001000)  char_selection= ALU_B[15:12] ;  
    		   else if ((next_x_pos[9:4])==6'b001001)  char_selection= ALU_B[11:8] ;
		       else if ((next_x_pos[9:4])==6'b001010)  char_selection= ALU_B[7:4] ;  
              else if ((next_x_pos[9:4])==6'b001011)  char_selection= ALU_B[3:0] ;
			 	     else char_selection=4'bxxxx;						  

    4'b1000:
	    if ((next_x_pos[9:4])==6'b000100) char_selection= ALUResult[31:28] ;
		  else if ((next_x_pos[9:4])==6'b000101)  char_selection= ALUResult[27:24] ;
		   else if ((next_x_pos[9:4])==6'b000110)  char_selection= ALUResult[23:20] ;  
          else if ((next_x_pos[9:4])==6'b000111)  char_selection= ALUResult[19:16] ;
		     else if ((next_x_pos[9:4])==6'b001000)  char_selection= ALUResult[15:12] ;  
    		   else if ((next_x_pos[9:4])==6'b001001)  char_selection= ALUResult[11:8] ;
		       else if ((next_x_pos[9:4])==6'b001010)  char_selection= ALUResult[7:4] ;  
              else if ((next_x_pos[9:4])==6'b001011)  char_selection= ALUResult[3:0] ;
		//		   else if ((next_x_pos[9:4])==6'b001110)  char_selection={3'b0,Stall ; 
			 	     else char_selection=4'bxxxx;				

    4'b1010:
	    if ((next_x_pos[9:4])==6'b000100) char_selection= MemData[31:28] ;
		  else if ((next_x_pos[9:4])==6'b000101)  char_selection= MemData[27:24] ;
		   else if ((next_x_pos[9:4])==6'b000110)  char_selection= MemData[23:20] ;  
          else if ((next_x_pos[9:4])==6'b000111)  char_selection= MemData[19:16] ;
		     else if ((next_x_pos[9:4])==6'b001000)  char_selection= MemData[15:12] ;  
    		   else if ((next_x_pos[9:4])==6'b001001)  char_selection= MemData[11:8] ;
		       else if ((next_x_pos[9:4])==6'b001010)  char_selection= MemData[7:4] ;  
              else if ((next_x_pos[9:4])==6'b001011)  char_selection= MemData[3:0] ;
			 	     else char_selection=4'bxxxx;		
	default:	char_selection=4'bxxxx;	
   endcase	
 	 assign char_en=(y_pos[8:5]==4'b0010) &&  ( x_pos[9:4]==6'b000100 ||	x_pos[9:4]==6'b000101 ||  x_pos[9:4]==4'b1011)
	             || (y_pos[8:5]==4'b0100 || y_pos[8:5]>=4'b0110 && y_pos[8:5]<=4'b1000 || y_pos[8:5]==4'b1010 ) 
				     &&  ( x_pos[9:4]>=6'b000100  &&	x_pos[9:4]<=6'b001011) 
                 ||  y_pos[8:5]==4'b0100 && (x_pos[9:4]==6'b001110);	 					  

// ------------------- signals for sram ---------------------------------



wire	[  7 : 0 ]				rom_addr		; // rom address 
wire	[  7 : 0 ]				rom_dout		; // rom data
assign rom_addr={char_selection[3:0],y_pos[4:1]};

// single-port rom for character table, 2048x8 bit for 128 16x8 characters
DisplayROM char_tab (
      .a(rom_addr),        // input wire [7 : 0] a
      .clk(pixel_clk),    // input wire clk
      .qspo(rom_dout)  // output wire [7 : 0] qspo
    );

	 reg		   char_pixel;		  
	 wire          vga_pixel;		  // vga output pixel
	 assign        vga_pixel= char_en && char_pixel;
always @ ( * )
	case ( x_pos[ 3 : 1 ] )
		3'd0: char_pixel = rom_dout[7];
		3'd1: char_pixel = rom_dout[6];	
		3'd2: char_pixel = rom_dout[5];
		3'd3: char_pixel = rom_dout[4];	
		3'd4: char_pixel = rom_dout[3];
		3'd5: char_pixel = rom_dout[2];	
		3'd6: char_pixel = rom_dout[1];
		3'd7: char_pixel = rom_dout[0];
	endcase
	
	assign red={8{vga_pixel}};
	assign green={8{vga_pixel}};
	assign blue=255;

endmodule
