module I2C(CLK,RST,SDA,SCL,CMD_RD,CMD_WR,DATA_IN,DataLED);
    //SDA 为12C 数据总线，对应CPLD 的5 脚，与实验板上拨码开关2 复用，拨到数字一侧即不影响 12C
    //SCL为12C 时钟线，对应CPLD 的6脚，与实验板上拨码开关1复用，拨到数字一侧即不影响12C
    //CMD RD和CMD WR 为按键命令
    //CMD WR为写，对应独立按键A;CMD RD 为读，对应独立按键 B

    //phase0,phasel,phase2,phase3 为四个阶段的状态变量
    //phase0 对应 SCL的上升沿时刻，phase2 对应 SCL 的下降沿时刻
    //phase1 对应从SCL高电平的中间时刻，phase3 对应从 SCL低电平的中间时刻
    //phase1 为数据的有效时段，此时数据线不允许变化
    //phase3 为数据的无效时段，允许更改数据

    input CLK,RST,CMD_RD,CMD_WR;
    inout SDA;
    input [3:0] DATA_IN;
    output SCL;
    output [3:0] DataLED;

    //参数设置，相当于C语言中的宏定义
    parameter i2c_addr=7'b1010000,eeprom_addr=8'b00000110;
    //i2c addr 为 EEPROM 器件从机地址
    //eeprom addr 为 EEPROM存储空间地址，在这里固定存储地址为 00000110
    assign SCL=scl_buf; //scl buf为I2C 时钟线缓冲
    assign SDA=(Flag_RW)?sda_buf:1'bz;//sda buf为I2C 数据线缓冲
    //Flag RW为1则将SDA 设置为写状态，为0则将SDA 设置为读状态

    reg [3:0] clk_div,DataLED;
    reg phase0,phase1,phase2,phase3,Flag_RW,start_delay;
    reg sda_buf,scl_buf,sda_tem;
    reg [5:0] bit_state;
    reg [9:0] key_delay;
    reg [7:0] WrData,RdData;
    reg [1:0] eeprom_state;

    //产生采样的4个阶段
    always @(posedge CLK or negedge RST)//CLK 为6MHz 时钟源信号
    begin
        if(RST==0)
        begin
            phase0 <= 0;
            phase1 <= 0;
            phase2 <= 0;
            phase3 <= 0;
            clk_div <= 0;
        end
        else begin
            if(clk_div!=4'b1111) clk_div <= clk_div + 4'b0001;
            else clk_div <= 0;
            //phase0:上升沿
            if(phase0==1) phase0 <= 0;
            else if(clk_div==4'b1111) phase0 <= 1;
            //phasel:“1’的中间时刻
            if(phase1==1)phase1 <= 0;
            else if(clk_div==4'b0011) phase1 <= 1;
            //phase2:下降沿
            if(phase2==1)phase2 <= 0;
            else if(clk_div==4'b0111) phase2 <= 1;
            //phase3:“0’的中间时刻
            if(phase3==1)phase3 <= 0;
            else if(clk_div==4'b1011) phase3 <= 1;
            //总体效果是:4拍为一个phase，所以16 拍经历四个 phase
            //0 时是 phase0=1，4 时是 phasel=1，8 时是 phase2=1，12 时是 phase3=1
        end 

    end 

    //用于按键消抖的延时进程
    always @(posedge CLK or negedge RST)
    begin
        if(RST==0)key_delay<=0; //key_delay 为按键消抖计数器
        else if(start_delay==1) key_delay<=key_delay+1; // start delay 为按键消抖计数器计数开始信号，1有效
        else key_delay<=0;
    end

    //I2C 进程
    always @(posedge CLK or negedge RST)
    begin
        if(RST==0)
        begin
            start_delay<=0;
            eeprom_state<=0;//eeprom state 为操作状态，0 无操作，1写操作状态，2读操作状态
	    //DataLED<=DATA_IN;
	    DataLED<=0;
        end
        else begin
            case(eeprom_state)
            0: begin //无操作命令状态
                WrData<={4'b0000,DATA_IN};//合并成一个8位数
                //DATAIN为输入的4位数据;WrData 为待写入EEPROM的8位数据
                RdData<=0;//RdData 用于存放从 EEPROM读出的8位数据
                bit_state<=0;//bit state 为发送数据或接收数据时的位状态
                Flag_RW<=0;//读
		//DataLED<=DATA_IN;

                //按键防抖动
                if((key_delay==0)&&((CMD_WR==0)||(CMD_RD==0)))start_delay<=1;
                else if(key_delay==10'b1000000000)
                begin
                    if(CMD_WR==0)eeprom_state<=1;//写操作状态
                    else if(CMD_RD==0)eeprom_state<=2;//读操作状态
                    else eeprom_state<=0;//无操作命令状态
                    start_delay<=0;//停止按键消抖计数器工作
                end
            end
            1: begin  //写EEPROM操作(其时序参见图9-17中的(b)图
                if(phase0==1)scl_buf<=1;
                else if(phase2==1)scl_buf<=0;
                //1 到0跳变，产生开始START 信号
                case(bit_state)
                    0://顿开始，从机地址的第0位
                    //i2c addr 从机地址是从高位开始的，这与存储地址和数据发送形式相反
                    //具体可参考24LC02数据手册
                    begin
                        if(phase1==1)begin sda_buf<=0;Flag_RW<=1;end
                        if((phase3&Flag_RW)==1)
                        begin sda_buf<=i2c_addr[6];Flag_RW<=1;bit_state<=1;end
                    end
                    1: begin //从机地址的第1位
                        if(phase3==1)begin sda_buf<=i2c_addr[5];Flag_RW<=1;bit_state<=2;end
                    end
                    2: begin //从机地址的第2位
                        if(phase3==1)begin sda_buf<=i2c_addr[4];Flag_RW<=1;bit_state<=3;end
                    end
                    3: begin //从机地址的第3位
                        if(phase3==1)begin sda_buf<=i2c_addr[3];Flag_RW<=1;bit_state<=4;end
                    end
                    4: begin //从机地址的第4位
                        if(phase3==1)begin sda_buf<=i2c_addr[2];Flag_RW<=1;bit_state<=5;end
                    end
                    5: begin //从机地址的第5位
                        if(phase3==1)begin sda_buf<=i2c_addr[1];Flag_RW<=1;bit_state<=6;end
                    end
                    6: begin //从机地址的第6位
                        if(phase3==1)begin sda_buf<=i2c_addr[0];Flag_RW<=1;bit_state<=7;end
                    end
                    7: begin //表示写从机(控制字节 CONTROLBYTE 中的RW为0)
                        if(phase3==1)begin sda_buf<=0;Flag_RW<=1;bit_state<=8;end
                    end
                    8: begin //准备读应答 ACK
                        if(phase3==1)begin Flag_RW<=0;bit_state<=9;end
                    end
                    9: begin
                        if(phase0==1) sda_tem<=SDA;//sda tem为12C数据线缓冲，临时存储读SDA 数据
                        if((phase1 == 1)&&(sda_tem==1)) eeprom_state<=0;//判断 ACK 信号是否有效，为1表示无效，返回初始状态
                        if(phase3==1)begin sda_buf<=eeprom_addr[7];Flag_RW<=1;bit_state<=10;end
                        //发送数据存储地址 WORDADDRESS，写地址 bit0 
                    end
                    10: begin //写bit1
                        if(phase3==1)begin sda_buf<=eeprom_addr[6];Flag_RW<=1;bit_state<=11;end
                    end
                    11: begin //写bit2
                        if(phase3==1)begin sda_buf<=eeprom_addr[5];Flag_RW<=1;bit_state<=12;end
                    end
                    12: begin //写bit3
                        if(phase3==1)begin sda_buf<=eeprom_addr[4];Flag_RW<=1;bit_state<=13;end
                    end
                    13: begin //写bit4
                        if(phase3==1)begin sda_buf<=eeprom_addr[3];Flag_RW<=1;bit_state<=14;end
                    end
                    14: begin //写bit5
                        if(phase3==1)begin sda_buf<=eeprom_addr[2];Flag_RW<=1;bit_state<=15;end
                    end
                    15: begin //写bit6
                        if(phase3==1)begin sda_buf<=eeprom_addr[1];Flag_RW<=1;bit_state<=16;end
                    end
                    16: begin //写bit7
                        if(phase3==1)begin sda_buf<=eeprom_addr[0];Flag_RW<=1;bit_state<=17;end
                    end
                    17: begin ////准备读 ACK
                        if(phase3==1)begin Flag_RW<=0;bit_state<=18;end
                    end
                    18: begin //读ACK，开始写入数据
                        if(phase0==1)begin sda_tem<=SDA;end
                        if((phase1==1)&&(sda_tem==1))eeprom_state<=0;
                        //开始写数据[7]
                        if(phase3==1)begin sda_buf<=WrData[7];Flag_RW<=1;bit_state<=19;end
                    end
                    19: begin ////准备读 ACK
                        if(phase3==1)begin sda_buf<=WrData[6];Flag_RW<=1;bit_state<=20;end
                    end
                    20: begin //写bit2
                        if(phase3==1)begin sda_buf<=WrData[5];Flag_RW<=1;bit_state<=21;end
                    end
                    21: begin //写bit3
                        if(phase3==1)begin sda_buf<=WrData[4];Flag_RW<=1;bit_state<=22;end
                    end
                    22: begin //写bit4
                        if(phase3==1)begin sda_buf<=WrData[3];Flag_RW<=1;bit_state<=23;end
                    end
                    23: begin //写bit5
                        if(phase3==1)begin sda_buf<=WrData[2];Flag_RW<=1;bit_state<=24;end
                    end
                    24: begin //写bit6
                        if(phase3==1)begin sda_buf<=WrData[1];Flag_RW<=1;bit_state<=25;end
                    end
                    25: begin //写bit7
                        if(phase3==1)begin sda_buf<=WrData[0];Flag_RW<=1;bit_state<=26;end
                    end
                    26: begin //写bit7
                        if(phase3==1)begin Flag_RW<=0;bit_state<=27;end
                    end
                    27: begin //写bit7
                        if(phase0==1) sda_tem<=SDA;
                        if((phase1==1)&&(sda_tem==1)) eeprom_state<=0;
                        if(phase3==1)begin sda_buf<=0;Flag_RW<=1;bit_state<=28;end
                    end
                    28: begin //写bit7
                        if(phase1==1)sda_buf<=1;//SDA 从0到1的跳变，发送停止位 STOP
                        if(phase3 == 1) begin
                            bit_state<=0;
                            eeprom_state<=0;
                            //DataLED<=DATA_IN;
                        end
                    end
                    default: begin bit_state<=0;eeprom_state<=0;end
            endcase
            end 
            2: begin
                if(phase0==1)scl_buf<=1;
                else if(phase2==1)scl_buf<=0;
                //1 到0跳变，产生开始START 信号
                case(bit_state)
                    0://顿开始，从机地址的第0位
                    //i2c addr 从机地址是从高位开始的，这与存储地址和数据发送形式相反
                    //具体可参考24LC02数据手册
                    begin
                        if(phase1==1)begin sda_buf<=0;Flag_RW<=1;end
                        if((phase3&Flag_RW)==1)
                        begin sda_buf<=i2c_addr[6];Flag_RW<=1;bit_state<=1;end
                    end
                    1: begin //从机地址的第1位
                        if(phase3==1)begin sda_buf<=i2c_addr[5];Flag_RW<=1;bit_state<=2;end
                    end
                    2: begin //从机地址的第2位
                        if(phase3==1)begin sda_buf<=i2c_addr[4];Flag_RW<=1;bit_state<=3;end
                    end
                    3: begin //从机地址的第3位
                        if(phase3==1)begin sda_buf<=i2c_addr[3];Flag_RW<=1;bit_state<=4;end
                    end
                    4: begin //从机地址的第4位
                        if(phase3==1)begin sda_buf<=i2c_addr[2];Flag_RW<=1;bit_state<=5;end
                    end
                    5: begin //从机地址的第5位
                        if(phase3==1)begin sda_buf<=i2c_addr[1];Flag_RW<=1;bit_state<=6;end
                    end
                    6: begin //从机地址的第6位
                        if(phase3==1)begin sda_buf<=i2c_addr[0];Flag_RW<=1;bit_state<=7;end
                    end
                    7: begin //表示写从机(控制字节 CONTROLBYTE 中的RW为0)
                        if(phase3==1)begin sda_buf<=0;Flag_RW<=1;bit_state<=8;end
                    end
                    8: begin //准备读应答 ACK
                        if(phase3==1)begin Flag_RW<=0;bit_state<=9;end
                    end
                    9: begin
                        if(phase0==1) sda_tem<=SDA;//sda tem为12C数据线缓冲，临时存储读SDA 数据
                        if((phase1 == 1)&&(sda_tem==1)) eeprom_state<=0;//判断 ACK 信号是否有效，为1表示无效，返回初始状态
                        if(phase3==1)begin sda_buf<=eeprom_addr[7];Flag_RW<=1;bit_state<=10;end
                        //发送数据存储地址 WORDADDRESS，写地址 bit0 
                    end
                    10: begin //写bit1
                        if(phase3==1)begin sda_buf<=eeprom_addr[6];Flag_RW<=1;bit_state<=11;end
                    end
                    11: begin //写bit2
                        if(phase3==1)begin sda_buf<=eeprom_addr[5];Flag_RW<=1;bit_state<=12;end
                    end
                    12: begin //写bit3
                        if(phase3==1)begin sda_buf<=eeprom_addr[4];Flag_RW<=1;bit_state<=13;end
                    end
                    13: begin //写bit4
                        if(phase3==1)begin sda_buf<=eeprom_addr[3];Flag_RW<=1;bit_state<=14;end
                    end
                    14: begin //写bit5
                        if(phase3==1)begin sda_buf<=eeprom_addr[2];Flag_RW<=1;bit_state<=15;end
                    end
                    15: begin //写bit6
                        if(phase3==1)begin sda_buf<=eeprom_addr[1];Flag_RW<=1;bit_state<=16;end
                    end
                    16: begin //写bit7
                        if(phase3==1)begin sda_buf<=eeprom_addr[0];Flag_RW<=1;bit_state<=17;end
                    end
                    17: begin ////准备读 ACK
                        if(phase3==1)begin Flag_RW<=0;bit_state<=18;end
                    end
                    18: begin //读ACK，开始写入数据
                        if(phase0==1)begin sda_tem<=SDA;end
                        if((phase1==1)&&(sda_tem==1))eeprom_state<=0;
                        //开始写数据[7]
                        if(phase3==1)begin sda_buf<=1; Flag_RW<=1; bit_state<=19; end
                    end
                    //再次发送从机地址，即图 9-18(b)图中的第二个 CONTROLBYTE
                    19:
                    begin
                        if(phase1==1)begin sda_buf<=0;Flag_RW<=1;end
                        if((phase3&Flag_RW)==1)
                        begin sda_buf<=i2c_addr[6];Flag_RW<=1;bit_state<=20;end
                    end
                    20: begin //从机地址的第1位
                        if(phase3==1)begin sda_buf<=i2c_addr[5];Flag_RW<=1;bit_state<=21;end
                    end
                    21: begin //从机地址的第2位
                        if(phase3==1)begin sda_buf<=i2c_addr[4];Flag_RW<=1;bit_state<=22;end
                    end
                    22: begin //从机地址的第3位
                        if(phase3==1)begin sda_buf<=i2c_addr[3];Flag_RW<=1;bit_state<=23;end
                    end
                    23: begin //从机地址的第4位
                        if(phase3==1)begin sda_buf<=i2c_addr[2];Flag_RW<=1;bit_state<=24;end
                    end
                    24: begin //从机地址的第5位
                        if(phase3==1)begin sda_buf<=i2c_addr[1];Flag_RW<=1;bit_state<=25;end
                    end
                    25: begin //从机地址的第6位
                        if(phase3==1)begin sda_buf<=i2c_addr[0];Flag_RW<=1;bit_state<=26;end
                    end
                    26: begin //表示写从机(控制字节 CONTROLBYTE 中的RW为0)
                        if(phase3==1)begin sda_buf<=1;Flag_RW<=1;bit_state<=27;end
                    end
                    27: begin ////准备读 ACK
                        if(phase3==1)begin Flag_RW<=0;bit_state<=28;end
                    end
                    28: begin //读ACK，开始写入数据
                        if(phase0==1)begin sda_tem<=SDA; end
                        if((phase1==1)&&(sda_tem==1)) eeprom_state<=0;
                        //开始写数据[7]
                        if(phase3==1)begin Flag_RW<=0; bit_state<=29; end
                    end
                    29:
                    begin
                        if(phase1 == 1) RdData[7]<=SDA;
                        if(phase3 == 1) bit_state<=30;
                    end
                    30: begin
                        if(phase1==1) RdData[6]<=SDA;
                        if(phase3==1) bit_state<=31;
                    end 
                    31: begin
                        if(phase1==1) RdData[5]<=SDA;
                        if(phase3==1) bit_state<=32;
                    end
                    32: begin
                        if(phase1==1) RdData[4]<=SDA;
                        if(phase3==1) bit_state<=33;
                    end
                    33: begin
                        if(phase1==1) RdData[3]<=SDA;
                        if(phase3==1) bit_state<=34;
                    end
                    34: begin
                        if(phase1==1) RdData[2]<=SDA;
                        if(phase3==1) bit_state<=35;
                    end
                    35: begin
                        if(phase1==1) RdData[1]<=SDA;
                        if(phase3==1) bit_state<=36;
                    end
                    36: begin
                        if(phase1==1) RdData[0]<=SDA;
                        if(phase3==1) bit_state<=37;
                    end
                    37: begin
                        if(phase3==1) begin sda_buf<=0; Flag_RW<=1; bit_state<=38; end
                    end
                    38: begin
                        if(phase1==1) sda_buf<=1;
                        if(phase3==1) begin
                            bit_state<=0;
                            eeprom_state<=0;
                            DataLED<=RdData[3:0];
                        end
                    end
                    default: begin bit_state<=0; eeprom_state<=0; end
                endcase
            end
            default: eeprom_state<=0;
        endcase
        end 
    end 

endmodule
