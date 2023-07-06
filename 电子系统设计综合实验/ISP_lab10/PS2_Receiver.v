//KeyData为PS/2 的数据线，而 KeyClock 为PS/2 的时钟线
//KeyData即KBDATA 对应CPLD 的4脚，与实验板上拨码开关3 复用，拨到数字一侧即不影响 PS/2键盘
//KeyClock 即KBCLK 对应CPLD的3 脚，与实验板上拨码开关4 复用，拨到数字一侧即不影响 PS/2键盘

module PS2_Receiver(clk,reset,KeyClock,KeyData,PS_Data);
input clk,reset,KeyClock,KeyData;
output [3:0] PS_Data;

wire neg_KeyClock;

reg KeyClock_r0,KeyClock_r1,KeyClock_r2,RxEn,LedEn;
reg [3:0] save,counter,PS_Data;
reg [7:0] LastRxData;
reg [10:0] RxData;


always @(posedge clk or negedge reset) //clk 为系统高频时钟(如6MHz)信号，reset 为系统复位信号
begin
    if(!reset)
        begin
            KeyClock_r0 <= 1'b0;
            KeyClock_r1 <= 1'b0;
            KeyClock_r2 <= 1'b0;
        end
    else
        begin //锁存状态，进行滤波消抖
            KeyClock_r0 <= KeyClock;//KeyClock r0 是最新的
            KeyClock_r1 <= KeyClock_r0;
            KeyClock_r2 <= KeyClock_r1;//KeyClock r2 是最旧的
        end
end
assign neg_KeyClock =~KeyClock_r1 & KeyClock_r2;
//neg KeyClock标志着 KeyClock 下降沿，前1后0，或者说r2为1而r1为0

//接收扫描码
always @(posedge clk or negedge reset)
begin
    if(reset==0)
        begin
            counter=0;//counter 为接收计数器
            RxEn<=1;//RxEn 为接收完成标志信号，下降沿有效;这里初始化为接收尚未完成
        end
    else if(neg_KeyClock)
        begin
            RxData[counter]<=KeyData;
            //RxData用于临时存储接收到的 PS/2 数据
            //显然是先收低位，后收高位(因为发过来时是先发低位，后发高位的)
            if(counter>=10) 
                RxEn<=0;
            else RxEn<=1;
            //接收完毕，共接收了11 次
            //从0到10，包括1个起始位，8个数据位，1个奇偶校验位，1个停止位
            if(counter>=10)
                counter=0;
            else counter=counter+1;
        end
end

//避免一个按键产生两个数
always @(negedge RxEn or negedge reset)
begin
    if(reset==0)
        begin
            LastRxData<=8'b01000101;//LastRxData用于记录上一次接收到的PS/2数据;初始化为45h，即0的通码
            LedEn<=0;//LedEn为0则允许数码管显示，为1则不允许显示
        end
    else if(RxEn==0)//接收完毕
        begin
            if(LastRxData==8'b11110000) LedEn<=1;//FOh 是断码标志，这个码就不再显示了 (用LedEn=1 来决定)，以免按一次键产生两个相同的数
            else LedEn<=0;//允许数码管显示
            LastRxData<=RxData[8:1];
            //存储在RxData中新收到的8位数据送给LastRxData，[0]是起始位就不送了
        end
end
//翻译扫描码
always @(LastRxData or reset or LedEn)
begin
    if(reset==0)
        PS_Data<=0;
    else if(LedEn==0)//当允许显示时
        begin
            case(LastRxData)
                //使用一个数码管来显示通码所对应的数字:这里先把通码LastRxData 翻译成数字PS Data
                //save 用于记住刚才的按键值，以便在按其它非数字键时保持原值
                //注:直接用save<=PS Data 的话会有问题，因为是非阻塞式赋值
                8'b01000101: begin PS_Data<=4'b0000;save<=4'b0000;end //45h为0的通码
                8'b00010110: begin PS_Data<=4'b0001;save<=4'b0001;end //16h为1的通码
                8'b00011110: begin PS_Data<=4'b0010;save<=4'b0010;end //1Eh为2的通码
                8'b00100110: begin PS_Data<=4'b0011;save<=4'b0011;end //26h为3的通码
                8'b00100101: begin PS_Data<=4'b0100;save<=4'b0100;end //25h 为4的通码
                8'b00101110: begin PS_Data<=4'b0101;save<=4'b0101;end //2Eh为5的通码
                8'b00110110: begin PS_Data<=4'b0110;save<=4'b0110;end //36h 为6的通码
                8'b00111101: begin PS_Data<=4'b0111;save<=4'b0111;end //3Dh为7的通码
                8'b00111110: begin PS_Data<=4'b1000;save<=4'b1000;end //3Eh为8的通码
                8'b01000110: begin PS_Data<=4'b1001;save<=4'b1001;end //46h为9的通码
                //如果需要识别更多键盘按键可以在这里继续添加
                default: PS_Data<=save;//其它键包括断码标志FO 均无效，保持原值
            endcase
        end
end

endmodule
//(请思考:上面这两个always 块可否归并成一个always 块?LedEn 信号可否去?)