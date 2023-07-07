module DESHAKE(clk,RESET,din,dout);
    parameter s0=2'b01,s1=2'b10;
    input clk,RESET,din;
    output dout;

    reg [1:0] pre_s;
    reg [1:0] next_s;
    reg [18:0] counter;
    reg keyclk;
    reg dout;

    always @(posedge clk or negedge RESET) begin
        if(RESET==0) begin
            counter<=0;
        end
        else if(counter == 499999) begin
            keyclk<=~keyclk;
            counter<=0;
        end
        else counter<=counter+1;
    end

    always @(posedge keyclk)
    begin
        if(RESET==0) pre_s = s0;
        else pre_s = next_s;
    end

    always @(posedge keyclk) begin
         case(pre_s)
            s0:
            begin
                if(din == 0) next_s = s1;
                else begin next_s = s0; dout = 1; end
            end
            s1:
            begin
                if(din == 0) dout = 0;
                else begin next_s = s0;dout = 1; end
            end
            default: next_s = s0;
    endcase
    end

endmodule
