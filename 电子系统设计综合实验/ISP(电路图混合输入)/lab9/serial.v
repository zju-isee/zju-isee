module SERIAL(clk,reset,dout,Rx,Tx,Data1,Data2);
    input clk,reset,Rx,dout;
    output Tx;
    output [3:0] Data1;
    output [3:0] Data2;

    reg Tx;
    reg [3:0] Data1;
    reg [3:0] Data2;
    reg [9:0] ClockCount;
    reg [5:0] ClockCount_Rx;
    reg Clock9600,Clock16,Send_en,Send_over,Rx_Hold,Rx_Valid;
    reg [3:0] Send_count;
    reg [9:0] Send_data;
    reg [7:0] m;
    reg [7:0] Rx_Data;


//时钟产生进程
    always @(posedge clk or negedge reset)
    begin
        if(reset==0);
        else
        begin
            if(ClockCount==624) begin Clock9600<=1;ClockCount<=0; end
            else begin Clock9600<=0;ClockCount<=ClockCount+1; end
            //Clock9600 为9600 波特率时钟，其频率为6MHZ/625=9600Hz//ClockCount 为产生 Clock9600 的计数器
            if(ClockCount_Rx==38) begin Clock16<=1;ClockCount_Rx<=0;end
            else begin Clock16<=0; ClockCount_Rx<=ClockCount_Rx+1;end
            //CIock16为9600 波特率时钟的 1 倍频采样时钟,在接收时使用，因 625/16:39(虽为约数，但经测试可用)
            //ClockCount Rx为产生 Clock16 的计数器
        end
    end
    //串口发送部分，即从ISP 实验板发送到PC上，用串口调试助手显示
    //Tx 为串口发送数据，锁定在实验板 ISP 芯片上的97 脚，已通过硬件连线与口模块的发送端连接
    //Send en 为串口发送使能，0 有效，0表示发送使能
    //Send over 为串口发送完成，0 有效，0表示发送完成
    //Sendcount 为串口发送时的位发送计数
    //Send data 为发送寄存器
    always @(posedge Clock9600 or posedge Send_en)
    begin
        if(Send_en==1) begin Send_count<=0;Tx<=1; Send_over<=1;end //发送未使能，发送未完成
        else if(Send_count==9)begin Tx<=Send_data[9];Send_over<=0;end
        //发送完成，总共发送 10 次 (1位起始位，8位数据位，1位停止位，共 10 位，无奇偶校验位)
        else begin Tx<=Send_data[Send_count]; Send_count<=Send_count+1;end
    end


    //发送激励
    always @(posedge dout or negedge reset or negedge Send_over) //dout 是按键消抖后的输出,即按键按一下触发开始发送
    begin
        if(reset==0)begin Send_en<=1; Send_data<=10'b1000000000; end //初始化不使能发送，发送数据为全0
        else if(Send_over==0)begin Send_en<=1; Send_data<=10'b1000000000;end //发送完毕，则恢复发送不使能
        else
            begin
                Send_en <= 0; //使能发送
                Send_data<=10'b1010101100;//发送数据为:停止位1，数据 56，起始位0
                //因为从第[0]位开始发，最后发第[9]位，所以正好先发低位，后发高位
            end 
    end
    //串口接收部分，即从 PC 上的串口调试助手发送到ISP 实验板上，用数码管显示
    //串口接收检测起始位，即发送过来的第[0]位为 0，一旦检测到即开始接收数据
    //Rx 为串口接收数据，锁定在板上的98 脚，已通过硬件连线与串口模块的接收端连接
    //Rx Hold 为串口接收到起始位的标志信号，1有效，表示接收到了
    //Rx Valid 标志接收到一字节有效数据，1 有效，表示接收到了 8 位数据
    //Rx Data 为接收寄存器
    always @(Rx or reset)
    begin
        if(reset==0)Rx_Hold<=0;//初始化时不接收保持
        else if(Rx==0)Rx_Hold<=1;//通过 Rx Hold 信号启动接收进程
        else Rx_Hold <= 0;
    end

    //接收进程
    always @(posedge Clock16 or negedge reset)
    begin
        if(reset==0) begin Rx_Valid<=0;m<=0;end //初始化时接收8位数据尚为无效，用m计 Clock16 个数为0
        else
        begin
            case(m)
                0: begin
                    if(Rx_Hold == 1) begin m<=m+1; end
                    else begin m<=0; Rx_Valid<=0; end
                end

                //经过 24 个 Clock16 周期后，采第1位数据即最低位[0]
                24:begin Rx_Data[0]<=Rx; m<=m+1;end
                //经过 16个Clock16 周期后，采第2位数据即次低位[1];后面依此类推
                40: begin Rx_Data[1]<=Rx; m<=m+1;end
                56: begin Rx_Data[2]<=Rx; m<=m+1;end
                72: begin Rx_Data[3]<=Rx; m<=m+1;end
                88: begin Rx_Data[4]<=Rx; m<=m+1;end
                104: begin Rx_Data[5]<=Rx; m<=m+1;end
                120: begin Rx_Data[6]<=Rx; m<=m+1;end

                //经过 16个 Clock16 周期后，采第8位数据即最高位[7]
                136: begin Rx_Data[7]<=Rx; m<=m+1;end
                //Rx Valid 赋1，标志串口数据接收完成:这时经过 16个 Clock1 周期应收到了停止位
                152: begin Rx_Valid<=1; m<=m+1;end
                168: begin m<=0; Rx_Valid<=1; end//恢复为初始态，接收个数为0，接收完成无效
                default: m<=m+1;//每隔一个 Clock16 周期来一个上升沿，其它数时m 一直在加1
            endcase
        end
    end 

    //输出接收到的串口数据，送到数码管上去显示
    always @(negedge Rx_Valid or negedge reset) //Rx Valid 的下降沿说明一次接收已经完成才由1变0的
    begin
        if(reset==0) begin Data1<=0;Data2<=0;end
        else
        begin
            Data1<={Rx_Data[3],Rx_Data[2],Rx_Data[1],Rx_Data[0]};//接收到的低4位
            Data2<={Rx_Data[7],Rx_Data[6],Rx_Data[5],Rx_Data[4]};//接收到的高4位
        end 
    end 

endmodule
