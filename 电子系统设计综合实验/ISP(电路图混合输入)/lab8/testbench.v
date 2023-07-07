`timescale 1 ns / 1 ns

// Define Module for Test Fixture
module lab8_tf();

parameter D1 = 167;
parameter D2 = 976563;

// Inputs
    reg clk;
    reg clk1;
    reg key_in0;
    reg key_in1;
    reg key_in2;
    reg key_in3;
    reg reset;


// Outputs
    wire a;
    wire b;
    wire c;
    wire d;
    wire e;
    wire f;
    wire g;
    wire key_out1;
    wire key_out2;
    wire key_out3;
    wire key_out4;
    wire LED0;
    wire LED1;
    wire LED2;
    wire LED3;
    wire LED4;
    wire LEDVCC1;
    wire LEDVCC2;
    wire LEDVCC3;
    wire LEDVCC4;
    wire PointTime;


// Bidirs


// Instantiate the UUT
    lab8 UUT (
        .a(a), 
        .b(b), 
        .c(c), 
        .clk(clk), 
        .clk1(clk1), 
        .d(d), 
        .e(e), 
        .f(f), 
        .g(g), 
        .key_in0(key_in0), 
        .key_in1(key_in1), 
        .key_in2(key_in2), 
        .key_in3(key_in3), 
        .key_out1(key_out1), 
        .key_out2(key_out2), 
        .key_out3(key_out3), 
        .key_out4(key_out4), 
        .LED0(LED0), 
        .LED1(LED1), 
        .LED2(LED2), 
        .LED3(LED3), 
        .LED4(LED4), 
        .LEDVCC1(LEDVCC1), 
        .LEDVCC2(LEDVCC2), 
        .LEDVCC3(LEDVCC3), 
        .LEDVCC4(LEDVCC4), 
        .PointTime(PointTime), 
        .reset(reset)
        );


// Initialize Inputs
// You can add your stimulus here
    initial begin
            clk = 0;
            clk1 = 0;
            key_in0 = 0;
            key_in1 = 0;
            key_in2 = 0;
            key_in3 = 0;
            reset = 0;
			#(D2*2)
			key_in0 = 1;
			#(D2*3)
			key_in1 = 1;
			key_in0 = 0;
			#(D2*4)
			key_in1 = 0;
			key_in2 = 1;
			#(D2*4)
			key_in3 = 1;
			key_in2 = 0;

			
    end

  always 		#(D1) clk=~clk;
  always 		#(D2) clk1=~clk1;

endmodule // lab8_tf
