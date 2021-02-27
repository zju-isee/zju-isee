`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer:qmj
////////////////////////////////////////////////////////////////////////////////

module dds_tb;
   parameter delay=10;
	// Inputs
	reg clk;
	reg reset;
	reg [21:0] k;
	reg sampling_pulse;

	// Outputs
	wire new_sample_ready;
	wire [15:0] sample;

	// Instantiate the Unit Under Test (UUT)
	
	dds  dds_inst (
		.clk(clk), 
		.reset(reset), 
		.k(k), 
		.sampling_pulse(sampling_pulse), 
		.new_sample_ready(new_sample_ready), 
		.sample(sample)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		k ={12'd58, 10'd360};
		sampling_pulse= 0;
		//  
		#(delay*1.5+1) reset=0; 
		repeat (100)
		begin 
        #(delay*5)  sampling_pulse= 1;
		  #(delay)  sampling_pulse= 0;
		end 
		// 
		 #(delay) k ={12'd98, 10'd68} ;
		
		repeat (108)
      begin 
        #(delay*5)  sampling_pulse= 1;
        #(delay)  sampling_pulse= 0;
      end   
		   
		  #(delay) k ={12'd30, 10'd68} ;
          
     repeat (250)
         begin 
           #(delay*5)  sampling_pulse= 1;
           #(delay)  sampling_pulse= 0;
        end       
		   
		   #(delay*5) $stop;
		
	end
	
	//clock
always 		#(delay/2) clk=~clk;
      
endmodule

