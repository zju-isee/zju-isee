// 部分参考源代码( Verilog语言):
//SDA为I2C数据总线，对应CPLD的5脚，与实验板上拨码开关2复用，拨到数字一侧即不影响I2C/ISCL为I2C时钟线，对应CPLD的6脚，与实验板上拨码开关1复用，拨到数字一侧即不影响I2C
//CMD_RD和 CMD_WR为按键命令
//CMD_WR为写，对应独立按键A;CMD_RD为读，对应独立按键B
//phase0, phase1, phase2, phase3为四个阶段的状态变量
//phase0 对应SCL的上升沿时刻，phase2对应 SCL的下降沿时刻
//phasel对应从SCL高电平的中间时刻，phase3对应从SCL低电平的中间时刻
//phasel为数据的有效时段，此时数据线不允许变化
//phase3为数据的无效时段，允许更改数据

module I2C(SDA,SCL,RST,CLK,CMD_RD,CMD_WR,DATA_IN,DataLED);

inout SDA,SCL;
input RST,CLK,CMD_RD,CMD_WR;
input [3:0] DATA_IN;
output [3:0] DataLED;
reg phase0,phase1,phase2,phase3,start_delay,Flag_RW,sda_buf,scl_buf,sda_tem;
reg [1:0] eeprom_state;
reg [3:0] clk_div,DataLED;
reg [5:0] bit_state;
reg [7:0] WrData,RdData;
reg [9:0] key_delay;

//参数设置，相当于C语言中的宏定义
parameter i2c_addr=7'b1010000,eeprom_addr=8'b00000110;
//i2c_addr为EEPROM 器件从机地址
//eeprom_addr为EEPROM存储空间地址，在这里固定存储地址为00000110

assign SCL=scl_buf; //scl_buf为 12C时钟线缓冲
assign SDA=(Flag_RW)?sda_buf:1'bz; //sda_buf 为 l2C数据线缓冲
//Flag_RW为1则将SDA设置为写状态，为О则将SDA设置为读状态

//产生采样的4个阶段
always @(posedge CLK or negedge RST)//CLK为6MHz时钟源信号
begin
    if(RST==0)
    begin
        phase0 <= 0;
        phase1 <= 0;
        phase2 <= 0;
        phase3 <= 0;
        clk_div <= 0;
    end
    else
    begin
        if(clk_div!=4'b1111) clk_div <= clk_div +4'b0001;//clk_div是CLK的16分频
        else clk_div <= 0;
        //phase0:上升沿，在clk_div从4'b1111到4'b0000，为第15个CLK处
        if(phase0==1) phase0 <= 0;
        else if(clk_div==4'b1111) phase0 <= 1;
        //phase1 :‘1’的中间时刻，为第3个CLK
        if(phase1==1 ) phase1 <= 0;//在clk_div从4'b0011到4'b0100
        else if(clk_div==4'b0011) phase1 <= 1;
        //phase2:下降沿，为第7个CLK
        if(phase2==1 ) phase2<= 0;//在clk_div从4'b0111到4'b1000;
        else if(clk_div==4'b0111) phase2 <= 1;
        //phase3:‘0’的中间时刻，为第11个clk
        if(phase3==1 ) phase3 <= 0;//在clk_div从4'b1011到4'b1100
        else if(clk_div==4'b1011) phase3 <= 1;
    end
end
//总体效果是:4拍为一个phase，所以16拍经历四个phase
//0时是 phaseO=1，4时是 phase1=1，8时是phase2=1，12时是phase3=1

//用于按键消抖的延时进程
always @(posedge CLK or negedge RST)
begin
    if(RST==0) key_delay<=0; //key_delay为按键消抖计数器
    else if(start_delay==1 ) key_delay <= key_delay+1; // start_delay为按键消抖计数器计数开始信号，1有效else key_delay<=O;
end
//I2C进程
always @(posedge CLK or negedge RST)
begin
    if(RST==0)
    begin
        start_delay<=0;
        eeprom_state<=0; //eeprom_state为操作状态，0无操作，1写操作状态，2读操作状态
    end
    else
        begin
            case(eeprom_state)
                0://无操作命令状态
                    begin
                        WrData<={4'b0000,DATA_IN};//合并成一个8位数
                        //DATA_IN为输入的4位数据;WrData为待写入EEPROM的8位数据
                        RdData<=0; //RdData用于存放从EEPROM 读出的8位数据
                        bit_state<=0; //bit_state为发送数据或接收数据时的位状态
                        Flag_RW <= 0;//读

                        //按键防抖动
                        if((key_delay==0)&&((CMD_WR==0)||(CMD_RD==0)))start_delay<=1;
                        else if(key_delay==10'b1000000000)
                            begin
                                if(CMD_WR==0)eeprom_state<=1; //写操作状态 
                                else if(CMD_RD==0)eeprom_state<=2;//读操作状态
                                else eeprom_state<=0;//无操作命令状态
                                start_delay<=0;//停止按键消抖计数器工作
                            end
                    end
                1 ://写 EEPROM操作(其时序参见图9-17中的(b)图》
                    begin
                        if(phase0==1 )scl_buf<=1;
                        else if(phase2==1)scl_buf<=0;
                        //1到0跳变，产生开始START信号
                        case(bit_state)
                            0://帧开始，从机地址的第О位
                                //i2c_addr 从机地址是从高位开始的，这与存储地址和数据发送形式相反!
                                //具体可参考24LCO2 数据手册
                                begin
                                    if(phase1==1)begin sda_buf<=0;Flag_RW<=1;end
                                    if((phase3&Flag_RW)==1)
                                        begin sda_buf<=i2c_addr[6];Flag_RW<=1;bit_state<=1;end
                                end
                            1://从机地址的第1位
                                if(phase3==1)begin sda_buf<=i2c_addr[5];Flag_RW<=1;bit_state<=2;end
                            2://从机地址的第2位
                                if(phase3==1)begin sda_buf<=i2c_addr[4];Flag_RW<=1;bit_state<=3;end
                            3://从机地址的第3位
                                if(phase3==1)begin sda_buf<=i2c_addr[3];Flag_RW<=1;bit_state<=4;end
                            4://从机地址的第4位
                                if(phase3==1)begin sda_buf<=i2c_addr[2];Flag_RW<=1;bit_state<=5;end
                            5://从机地址的第5位
                                if(phase3==1)begin sda_buf<=i2c_addr[1];Flag_RW<=1;bit_state<=6;end
                            6://从机地址的第6位
                                if(phase3==1)begin sda_buf<=i2c_addr[0];Flag_RW<=1;bit_state<=7;end
                            7://表示写从机(控制字节CONTROL BYTE中的RW'为0)
                                if(phase3==1)begin sda_buf<=0;Flag_RW<=1;bit_state<=8;end
                            8://准备读应答ACK
                                if(phase3==1)begin Flag_RW<=0;bit_state<=9;end
                            9://读应答ACK
                                begin
                                    if(phase0==1)sda_tem<=SDA;//读ACK
                                    //sda_tem为 I2C数据线缓冲，临时存储读SDA数据

                                    if((phase1==1)&&(sda_tem==1))eeprom_state<=0;
                                    
                                    //判断ACK信号是否有效，为1表示无效，返回初始状态
                                    if(phase3==1)begin sda_buf<=eeprom_addr[7];Flag_RW<=1;bit_state<=10;end
                                    //发送数据存储地址WORD ADDRESS，写地址 bitO
                                end
                            10://写地址 bit1
                                if(phase3==1)begin sda_buf<=eeprom_addr[6];Flag_RW<=1;bit_state<=11;end
                            11://写地址 bit2
                                if(phase3==1)begin sda_buf<=eeprom_addr[5];Flag_RW<=1;bit_state<=12;end
                            12://写地址 bit3
                                if(phase3==1)begin sda_buf<=eeprom_addr[4];Flag_RW<=1;bit_state<=13;end
                            13://写地址 bit4
                                if(phase3==1)begin sda_buf<=eeprom_addr[3];Flag_RW<=1;bit_state<=14;end
                            14://写地址 bit5
                                if(phase3==1)begin sda_buf<=eeprom_addr[2];Flag_RW<=1;bit_state<=15;end
                            15://写地址 bit6
                                if(phase3==1)begin sda_buf<=eeprom_addr[1];Flag_RW<=1;bit_state<=16;end
                            16://写地址 bit7
                                if(phase3==1)begin sda_buf<=eeprom_addr[0];Flag_RW<=1;bit_state<=17;end
                            17://准备读ACK
                                if(phase3==1)begin Flag_RW<=0;bit_state<=18;end
                            18://读ACK，然后开始写数据
                                begin
                                    if(phase0==1)begin sda_tem<=SDA;end
                                    if((phase1==1)&&(sda_tem==1))eeprom_state<=0;
                                    //开始写数据[7]
                                    if(phase3==1 )begin sda_buf<=WrData[7];Flag_RW<=1;bit_state<=19;end
                                end
                            19://写入数据[6]
                                if(phase3==1)begin sda_buf<=WrData[6];Flag_RW<=1;bit_state<=20;end
                            20://写入数据[5]
                                if(phase3==1)begin sda_buf<=WrData[5];Flag_RW<=1;bit_state<=21;end
                            21://写入数据[4]
                                if(phase3==1)begin sda_buf<=WrData[4];Flag_RW<=1;bit_state<=22;end  
                            22://写入数据[3]
                                if(phase3==1)begin sda_buf<=WrData[3];Flag_RW<=1;bit_state<=23;end
                            23://写入数据[2]
                                if(phase3==1)begin sda_buf<=WrData[2];Flag_RW<=1;bit_state<=24;end
                            24://写入数据[1]
                                if(phase3==1)begin sda_buf<=WrData[1];Flag_RW<=1;bit_state<=25;end   
                            25://写入数据[0]
                                if(phase3==1)begin sda_buf<=WrData[0];Flag_RW<=1;bit_state<=26;end
                            26://准备读ACK
                                if(phase3==1)begin Flag_RW<=0;bit_state<=27;end
                            27://读ACK
                                begin
                                    if(phase0==1)sda_tem<=SDA;
                                    if((phase1==1)&&(sda_tem==1))eeprom_state<=0;
                                    if(phase3==1)begin sda_buf<=0;Flag_RW<=1;bit_state<=28;end
                                end
                            28:
                                begin
                                    if(phase1==1)sda_buf<=1 ;//SDA 从0到1的跳变，发送停止位STOP
                                    if(phase3==1)
                                        begin bit_state<=0;eeprom_state<=0;DataLED<=DATA_IN;end
                                        //DataLED为送数码管显示的数
                                end
                            default: begin bit_state<=0;eeprom_state<=0;end
                        endcase
                    end

                2://读EEPROM操作(其时序参见图9-18中的(b)图)
                    begin
                        if(phase0==1)scl_buf<=1;
                        else if(phase2==1)scl_buf<=0;
                        //1到0跳变，产生开始START信号
                        case(bit_state)
                            0://写 EEPROM从机地址的第0位，因为i2c_addr 从机地址是从高位开始的
                                begin
                                    if(phase1==1)begin sda_buf<=0;Flag_RW<=1;end
                                    if((phase3&Flag_RW)==1)
                                        begin sda_buf<=i2c_addr[6];Flag_RW<=1;bit_state<=1;end
                                end
                            1://从机地址的第1位
                                if(phase3==1)begin sda_buf<=i2c_addr[5];Flag_RW<=1;bit_state<=2;end
                            2://从机地址的第2位
                                if(phase3==1)begin sda_buf<=i2c_addr[4];Flag_RW<=1;bit_state<=3;end
                            3://从机地址的第3位
                                if(phase3==1)begin sda_buf<=i2c_addr[3];Flag_RW<=1;bit_state<=4;end
                            4://从机地址的第4位
                                if(phase3==1)begin sda_buf<=i2c_addr[2];Flag_RW<=1;bit_state<=5;end
                            5://从机地址的第5位
                                if(phase3==1)begin sda_buf<=i2c_addr[1];Flag_RW<=1;bit_state<=6;end
                            6://从机地址的第6位
                                if(phase3==1)begin sda_buf<=i2c_addr[0];Flag_RW<=1;bit_state<=7;end
                            7://表示写从机(控制字节CONTROL BYTE中的RW'为0)
                                if(phase3==1)begin sda_buf<=0;Flag_RW<=1;bit_state<=8;end
                            8://准备读ACK
                                if(phase3==1)begin Flag_RW<=0;bit_state<=9;end

                            9://读ACK
                                begin
                                if(phase0==1)sda_tem<=SDA;
                                if((phase1==1)&&(sda_tem==1))eeprom_state<=0;
                                if(phase3==1)begin sda_buf<=eeprom_addr[7];Flag_RW<=1;bit_state<=10;end
                                end
                            10://写地址 bit1
                                if(phase3==1)begin sda_buf<=eeprom_addr[6];Flag_RW<=1;bit_state<=11;end
                            11://写地址 bit2
                                if(phase3==1)begin sda_buf<=eeprom_addr[5];Flag_RW<=1;bit_state<=12;end
                            12://写地址 bit3
                                if(phase3==1)begin sda_buf<=eeprom_addr[4];Flag_RW<=1;bit_state<=13;end
                            13://写地址 bit4
                                if(phase3==1)begin sda_buf<=eeprom_addr[3];Flag_RW<=1;bit_state<=14;end
                            14://写地址 bit5
                                if(phase3==1)begin sda_buf<=eeprom_addr[2];Flag_RW<=1;bit_state<=15;end
                            15://写地址 bit6
                                if(phase3==1)begin sda_buf<=eeprom_addr[1];Flag_RW<=1;bit_state<=16;end   
                            16://写地址 bit7
                                if(phase3==1)begin sda_buf<=eeprom_addr[0];Flag_RW<=1;bit_state<=17;end
                            17://准备读ACK
                                if(phase3==1)begin Flag_RW<=0;bit_state<=18;end
                            18://读ACK
                                begin
                                    if(phase0==1)begin sda_tem<=SDA;end
                                    if((phase1==1)&&(sda_tem==1))begin eeprom_state<=0;end
                                    if(phase3==1)begin sda_buf<=1;Flag_RW<=1;bit_state<=19;end
                                    end
                            //再次发送从机地址，即图9-18(b)图中的第二个CONTROL BYTE
                            19://从机地址的第О位
                                begin
                                    if(phase1==1)begin sda_buf<=0;Flag_RW<=1;end
                                    if((phase3&Flag_RW)==1)
                                        begin sda_buf<=i2c_addr[6];Flag_RW<=1;bit_state<=20;end
                                end
                            20://从机地址的第1位
                                if(phase3==1)begin sda_buf<=i2c_addr[5];Flag_RW<=1;bit_state<=21;end
                            21://从机地址的第2位
                                if(phase3==1)begin sda_buf<=i2c_addr[4];Flag_RW<=1;bit_state<=22;end
                            22://从机地址的第3位
                                if(phase3==1)begin sda_buf<=i2c_addr[3];Flag_RW<=1;bit_state<=23;end
                            23://从机地址的第4位
                                if(phase3==1)begin sda_buf<=i2c_addr[2];Flag_RW<=1;bit_state<=24;end
                            24://从机地址的第5位
                                if(phase3==1)begin sda_buf<=i2c_addr[1];Flag_RW<=1;bit_state<=25;end   
                            25://从机地址的第6位
                                if(phase3==1)begin sda_buf<=i2c_addr[0];Flag_RW<=1;bit_state<=26;end
                            26://表示读从机(控制字节CONTROL BYTE中的RW'为1)
                                if(phase3==1 )begin sda_buf<=1;Flag_RW<=1;bit_state<=27;end
                            27://准备读ACK
                                if(phase3==1)begin Flag_RW<=0;bit_state<=28;end
                            28://读ACK
                                begin
                                    if(phase0==1)sda_tem<=SDA;
                                    if((phase1==1)&&(sda_tem==1))eeprom_state<=0;
                                    if(phase3==1)begin Flag_RW<=0;bit_state<=29;end//准备读数据
                                end
                            //开始读数据
                            29:
                                begin
                                    if(phase1==1)RdData[7]<=SDA;
                                    if(phase3==1)bit_state<=30;
                                end
                            30:
                                begin
                                if(phase1==1)RdData[6]<=SDA;
                                if(phase3==1)bit_state<=31;
                                end
                            31:
                                begin
                                if(phase1==1)RdData[5]<=SDA;
                                if(phase3==1)bit_state<=32;
                                end
                            32:
                                begin
                                if(phase1==1)RdData[4]<=SDA;
                                if(phase3==1)bit_state<=33;
                                end
                            33:
                                begin
                                if(phase1==1)RdData[3]<=SDA;
                                if(phase3==1)bit_state<=34;
                                end
                            34:
                                begin
                                if(phase1==1)RdData[2]<=SDA;
                                if(phase3==1)bit_state<=35;
                                end
                            35:
                                begin
                                if(phase1==1)RdData[1]<=SDA;
                                if(phase3==1)bit_state<=36;
                                end
                            36:
                                begin
                                    if(phase1==1)RdData[0]<=SDA;
                                    if(phase3==1)bit_state<=37;
                                end
                            37://进行ACK应答
                                if(phase3==1 )begin sda_buf<=0;Flag_RW<=1;bit_state<=38;end
                            38:
                                begin
                                    if(phase1==1)sda_buf <= 1; //SDA 从0到1的跳变，发送停止位STOP
                                    if(phase3==1)
                                        begin bit_state<=0;eeprom_state<=0;DataLED<=RdData[3:0];end
                                end
                            default: begin bit_state<=0;eeprom_state<=0;end
                        endcase
                    end
                default: eeprom_state<=0;
            endcase
        end
end
endmodule