module COMPARE(clk,reset,int_Data,flag_Over,result,switch);
    input clk,reset;
    input [7:0] int_Data;
    input flag_Over;
    input switch;
    output [7:0] result;

    reg [7:0] result;
    reg question_num;


    always@(posedge switch or negedge reset) begin
        if(!reset) begin
            question_num<=0;
        end
        else if(question_num==1) begin
            question_num<=0;
        end
        else begin
            question_num<=question_num+1;
        end
    end

    always@(posedge clk or negedge reset)
    begin
        if(!reset) begin
            result <=8'b11111111;
        end
        else if(flag_Over) begin
            case(question_num)
                0: begin
                    if(int_Data==8'b01000000) begin
                        result<=8'b00001111;
                    end
                    else begin result<=8'b11111111; end
                end
                1: begin
                    if(int_Data==8'b00001001) begin result<=8'b11110000; end
                    else begin result<=8'b11111111; end
                end
                default: result<=8'b11111111;
        endcase
        end
    end



endmodule
