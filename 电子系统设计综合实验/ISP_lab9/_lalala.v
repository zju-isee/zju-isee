always @(posedge clk or negedge reset) 
begin
    if(reset==0)
    else
    begin
        if(ClockCount==624) begin Clock9600<=1;ClockCount<=0; end
        else begin Clock9600<=0;ClockCount<=ClockCount+1; end
        //Clock9600为9600波特率时钟，其频率为6MHz/625=9600Hz
        //ClockCount为产生Clock9600的计数器

        if(ClockCount_Rx==38) begin Clock16<=1;ClockCount_Rx<=0;end
        else begin Clock16<=0;ClockCount_Rx<=ClockCount_Rx+1; end
        //Clock16为9600波特率时钟的16倍频采样时钟，在接受时使用，因625/16~39
        //ClockCount_Rx为产生Clock16的计数器
    end    
end






