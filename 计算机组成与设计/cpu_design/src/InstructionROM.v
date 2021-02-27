/*---------------------------------------------------------------------
        lui X30,0x3000
        jalr X31 later(X0)
earlier:sw  X28, 0C(X0) 
		lw  X29, 04(X6) 
		slli  X5, X29, 2  		//数据冒险
		lw   X28, 04(X6) 
		sltu X28,X6,X7	
done:   jal X31,done 
later:	bne X0, X0, end  		// 分支条件不成立
        addi X5, X30, 42         
		add  X6, X0, X31
		sub X7, X5, X6		     //操作A一阶数据相关，操作B二阶数据相关
		or	 X28, X7, X5  		//操作A一阶数据相关，操作B三阶数据相关
        beq X0, X0, earlier		// 分支条件成立
end:    nop

--------------------------------------------------------------------------*/
module InstructionROM(addr,dout);
	input [5 : 0] addr;
	output [31 : 0] dout;
	reg [31 : 0] dout;
	always @(*)
		case (addr)
			6'd0:   dout=32'h0000_3f37 ;//           lui X30,0x3000
			6'd1:   dout=32'h0200_0fE7 ;//           jalr X31 later(X0)
			6'd2:   dout=32'h01c0_2623 ;// earlier: sw  X28, 0C(X0) 
			6'd3:   dout=32'h0043_2e83 ;//           lw  X29, 4(X6) 
			6'd4:   dout=32'h002e_9293 ;//           sll  X5, X29, 2 
			6'd5:   dout=32'h0043_2e03 ;//           lw   X28, 4(X6)
			6'd6:   dout=32'h0073_3e33 ;//		     sltu X28,X6,X7 
			6'd7:   dout=32'h0000_0f6f ;//	done:   jal X31,done
			6'd8:   dout=32'h0000_1c63 ;//	later:	bne X0, X0, end  		// 分支条件不成立
			6'd9:   dout=32'h042f_0293;//	        addi X5, X30, 42
			6'd10:  dout=32'h01f0_0333 ;//          add  X6, X0, X31 
			6'd11:  dout=32'h4062_83b3 ;//           sub X7, X5, X6
			6'd12:  dout=32'h0053_ee33 ;//       	or	 X28, X7, X5 
			6'd13:  dout=32'hfc00_0ae3 ;//          beq X0, X0, earlier
			6'd14: dout=32'h00000000 ;// end:  	nop
			default:dout=32'h00000000 ;//nop
		endcase	
endmodule
