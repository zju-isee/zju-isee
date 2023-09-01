module LED_DECODER(EN,A0,A1,A2,A3,Z0,Z1,Z2,Z3,Z4,Z5,Z6);
    input EN,A0,A1,A2,A3;
    output reg Z0,Z1,Z2,Z3,Z4,Z5,Z6;

    reg [3:0] bcd;
    reg [6:0] seg;
    always @(*)
    begin
        bcd = {A3,A2,A1,A0};
        seg = {Z6,Z5,Z4,Z3,Z2,Z1,Z0};
        if(EN) begin
            case (bcd)
                4'd0: seg = 7'b1000000; //0
                4'd1: seg = 7'b1111001; //1
                4'd2: seg = 7'b0100100; //2
                4'd3: seg = 7'b0110000; //3
                4'd4: seg = 7'b0011001; //4
                4'd5: seg = 7'b0010010; //5
                4'd6: seg = 7'b0000010; //6
                4'd7: seg = 7'b1111000; //7
                4'd8: seg = 7'b0000000; //8
                4'd9: seg = 7'b0010000; //9
                default: seg = 7'b0111111; //blank
            endcase
        end
        else begin
            seg = 7'b0111111;
        end 

    end

endmodule

