module button(clk,reset,ButtonIn,ButtonOut,pulse1kHz);
    input reset,ButtonIn,clk,pulse1kHz;
    output ButtonOut;
    wire debouncer_out;
    
    //synchro SynchroInst(.async_in(ButtonIn),.clk(clk),.sync_out(sync_out));//同步化电路

    debouncer Debouncer(.in(ButtonIn),.clk(clk),.reset(reset),.out(debouncer_out),.pulse1kHz(pulse1kHz));

    width_trans Width_TransInst(.in(debouncer_out),.clk(clk),.out(ButtonOut));

endmodule

