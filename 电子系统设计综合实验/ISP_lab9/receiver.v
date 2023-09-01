module receiver(Clock16,reset,Rx,Data1,Data2);
//串口接收部分，即从PC上的串口调试助手发送到ISP实验板上，用数码管显示
//串口接收检测起始位，即发送过来的第[0]位为0，一旦检测到即开始接收数据
//Rx为串口接收数据，锁定在板上的98脚，已通过硬件连线与串口模块的接收端连接
//Rx_Hold为串口接收到起始位的标志信号，1有效，表示接收到了
//Rx_Valid标志接收到一字节有效数据，1有效，表示接收到了8位数据
//Rx_Data为接收寄存器

input Clock16,reset,Rx;
output Data1,Data2;
reg Rx_Hold,Rx_Valid;
reg [7:0] m;//8bit寄存器m
reg [7:0] Rx_Data;//接收数据寄存器Rx_Data
reg [3:0] Data1,Data2;

always @(Rx or reset)
begin
    if(reset==0) Rx_Hold<=0;//初始化时不接收保持
    else if(Rx==0) Rx_Hold<=1;//通过Rx_Hold信号启动接收进程
    else Rx_Hold<=0;
end
//接收进程
always@(posedge Clock16 or negedge reset)
begin
    if(reset==0) begin Rx_Valid<=0;m<=0;end//初始化时接收8位数据尚为无效，用m计Clock个数为0
    else
        begin 
            case(m)
            0://检测启动信号
                begin
                    if(Rx_Hold==1)//接收启动信号已有效，即已经收到起始位了
                        begin m<=m+1; end
                    else
                        begin m<=0;Rx_Valid<=0; end
                end

            //经过24个Clock16周期，采样第一位即最低位[0]
            24:begin Rx_Data[0]<=Rx;m<=m+1; end
            40:begin Rx_Data[1]<=Rx;m<=m+1; end
            56:begin Rx_Data[2]<=Rx;m<=m+1; end
            72:begin Rx_Data[3]<=Rx;m<=m+1; end
            88:begin Rx_Data[4]<=Rx;m<=m+1; end
            104:begin Rx_Data[5]<=Rx;m<=m+1; end
            120:begin Rx_Data[6]<=Rx;m<=m+1; end
            136:begin Rx_Data[7]<=Rx;m<=m+1; end

            //Rx_Valid赋值1，标志串口数据接收完成，此时应该紧接着收到停止位
            152:begin Rx_Valid<=1;m<=m+1; end

            //恢复为初始态，接收个数为0，接收完成无效
            168:begin m<=0;Rx_Valid<=0; end
            default: m<=m+1;//
            endcase
         end
end


//输出接收到的串口数据送显
always@(negedge Rx_Valid or negedge reset)//Rx_Valid下降沿说明一次接收已经完成
begin
    if(reset==0) begin Data1<=0;Data2<=0;end
    else
        begin
            Data1<={Rx_Data[3],Rx_Data[2],Rx_Data[1],Rx_Data[0]};//接受到的低四位
            Data2<={Rx_Data[7],Rx_Data[6],Rx_Data[5],Rx_Data[4]};//接受到的高四位
        end
end
endmodule