module sender(Clock9600,dout,reset,Tx);
//串口发送部分，即从ISP实验板发送到PC上，用串口调试助手显示
//Tx为串口发送数据，锁定在实验板ISP芯片上的97脚，已通过硬件连线与串口模块的发送端连接
//Send_en为串口发送使能，0有效，0表示发送使能
//Send_over为串口发送完成，0有效，0表示发送完成
//Send_count为串口发送时的位发送计数
//Send_data为发送寄存器
input Clock9600,dout,reset;
output Tx;

reg Tx,Send_en,Send_over;
reg [3:0] Send_count;
reg [9:0] Send_data;

always@(posedge Clock9600 or posedge Send_en)
begin
    if(Send_en==1)
    begin 
        Send_count<=0;
        Tx<=1;
        Send_over<=1; 
    end//
    else if(Send_count==9)
    begin 
        Tx<=Send_data[9];
        Send_over<=0; 
    end//发送完成，共发送10次
    else 
    begin 
        Tx<=Send_data[Send_count];
        Send_count<=Send_count+1;
    end
end

//发送激励
always@(posedge dout or negedge reset or negedge Send_over)
begin//dout是按键消抖后的输出，即按键按一下触发开始发送
    if(reset==0) 
    begin 
        Send_en<=1;
        Send_data<=10'b1000000000;
        end//初始化不使能发送，发送数据全为0
    else if(Send_over==0) 
    begin 
        Send_en<=1;
        Send_data<=10'b1000000000; 
    end//发送完毕，恢复发送不使能
    else
    begin 
        Send_en<=0;
        Send_data<=10'b1010101100;//发送数据为：停止位1，数据位56，起始位0
         //因为从第[0]位开始发，随后发第[9]位，所以正好先发低位，后发高位
    end
end

endmodule