module note_player_ctrl(
    clk, 
    reset, 
    play_enable, 
    load_new_note, 
    load, 
    timer_clear,
    timer_done,
    note_done
);
input clk, reset, play_enable, load_new_note, timer_done;
output note_done, timer_clear, load;
reg timer_clear, load, note_done;
reg [1:0] state, nextstate;
parameter RESET = 0, WAIT = 1, DONE = 2, LOAD = 3; //状态编码
always @(posedge clk) begin
    if(reset) state = RESET;
    else state = nextstate;
end
always @(*) begin
    timer_clear = 0; load = 0; note_done = 0; // 初始值
    case (state)
    RESET: begin timer_clear = 1; nextstate = WAIT; end
    WAIT: begin 
        if(play_enable)  begin 
            if(timer_done) nextstate = DONE;
            else begin 
                if(load_new_note) nextstate = LOAD;
                else nextstate = WAIT;
                end
            end
        else nextstate = RESET; 
        end
    DONE: begin timer_clear = 1; note_done = 1; nextstate = WAIT; end
    LOAD: begin timer_clear = 1; load = 1; nextstate = WAIT; end
    endcase
end
endmodule // note_player_ctrl