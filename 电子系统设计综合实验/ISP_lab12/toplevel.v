//显示16 进制数字0~F
//注意！引脚约束时，led_col[7:0]与表格上LED-COL1~8是反着来的！
module toplevel(clk_50m,reset_n,led_row,led_col);
    input clk_50m,reset_n;
    output [7:0] led_row,led_col;
    
    reg [3:0] scan_data; 
    reg [7:0] row_buf,col_buf,col1,col2,col3,col4,col5,col6,col7,col8;
    reg [15:0] cnt_scan;
    reg [25:0] cnt_next;

    always@(posedge clk_50m or negedge reset_n)//clk 50m 为 50MHz 时钟源
        begin
            if(!reset_n)//异步复位
                begin
                    cnt_scan<=0;//行扫描计数器清零
                    row_buf<=8'b10000000; //点阵的行选择线的初始状态(有效第八行，L8 最高位，L1最低位)
                end
            else if(cnt_scan!=16'hffff) //计数器时间约为 1.3ms (一行显示停留的时间)
                cnt_scan<=cnt_scan+1;//行扫描计数器加1计数
            else //当 cnt scan 计满 16hffff 时
                begin
                    row_buf[7:1]<=row_buf[6:0];
                    row_buf[0]<=row_buf[7];//点阵的行选择线信号一次循环左移1位(逐个导通每一行)
                    cnt_scan<=0;//行扫描计数器重新计数
                end
        end

    always@(posedge clk_50m or negedge reset_n)
        begin
        if(!reset_n)//异步复位
            begin
                cnt_next<=0;//显示下一的时间计数器(一8*8 点阵显示停留的时间)清零
                scan_data<=0;//表示当前显示字符编码(从“0”开始)
            end
        else if(cnt_next!=39999999)//一帧显示停留的时间为0.8s (在这一时间内 scan data 不变)
                cnt_next<=cnt_next+1;
        else //当 cnt next 计满39999999 时
            begin
                cnt_next<=0;
                scan_data<=scan_data+1'b1;//显示下一个字符 (从“0”一直显示到“F”)
            end
        end

    //为要显示的字符进行点阵数据编码
    always@(scan_data)
        begin
            case(scan_data)
                4'd0: //0
                    begin
                    col1<=8'h0e; //第一行有效时的8 位数据编码
                    col2<=8'h11; //第二行有效时的8位数据编码
                    col3<=8'h13;//第三行有效时的8位数据编码
                    //第四行有效时的8 位数据编码
                    col4<=8'h15;
                    //第五行有效时的8位数据编码
                    col5<=8'h19;
                    //第六行有效时的8位数据编码
                    col6<=8'h11;
                    //第七行有效时的8 位数据编码
                    col7<=8'h0e;
                    col8<=8'h00; //第八行有效时的8 位数据编码
                    end
                4'd1: //1
                    begin
                    col1<=8'h04;
                    col2<=8'h0c;
                    col3<=8'h04;
                    col4<=8'h04;
                    col5<=8'h04;
                    col6<=8'h04;
                    col7<=8'h0e;
                    col8<=8'h00;
                    end
                4'd2: //2
                    begin
                    col1<=8'h0e;
                    col2<=8'h11;
                    col3<=8'h01;
                    col4<=8'h02;
                    col5<=8'h04;
                    col6<=8'h08;
                    col7<=8'h1f;
                    col8<=8'h00;
                    end
                4'd3: //3
                    begin
                    col1<=8'h1e;
                    col2<=8'h01;
                    col3<=8'h01;
                    col4<=8'h1e;
                    col5<=8'h01;
                    col6<=8'h01;
                    col7<=8'h1e;
                    col8<=8'h00;
                    end
                4'd4: //4
                    begin
                    col1<=8'h02;
                    col2<=8'h06;
                    col3<=8'h0a;
                    col4<=8'h12;
                    col5<=8'h1f;
                    col6<=8'h02;
                    col7<=8'h02;
                    col8<=8'h00;
                    end
                4'd5: //5
                    begin
                    col1<=8'h1f;
                    col2<=8'h10;
                    col3<=8'h1e;
                    col4<=8'h01;
                    col5<=8'h01;
                    col6<=8'h11;
                    col7<=8'h0e;
                    col8<=8'h00;
                    end
                4'd6: //6
                    begin
                    col1<=8'h0e;
                    col2<=8'h11;
                    col3<=8'h10;
                    col4<=8'h1e;
                    col5<=8'h11;
                    col6<=8'h11;
                    col7<=8'h0e;
                    col8<=8'h00;
                    end
                4'd7: //7
                    begin
                    col1<=8'h1f;
                    col2<=8'h01;
                    col3<=8'h02;
                    col4<=8'h04;
                    col5<=8'h08;
                    col6<=8'h08;
                    col7<=8'h08;
                    col8<=8'h00;
                    end
                4'd8: //8
                    begin
                    col1<=8'h0e;
                    col2<=8'h11;
                    col3<=8'h11;
                    col4<=8'h0e;
                    col5<=8'h11;
                    col6<=8'h11;
                    col7<=8'h0e;
                    col8<=8'h00;
                    end
                4'd9: //8
                    begin
                    col1<=8'h0e;
                    col2<=8'h11;
                    col3<=8'h11;
                    col4<=8'h0f;
                    col5<=8'h01;
                    col6<=8'h01;
                    col7<=8'h0e;
                    col8<=8'h00;
                    end
                4'd10: //A
                    begin
                    col1<=8'h04;
                    col2<=8'h0a;
                    col3<=8'h11;
                    col4<=8'h1f;
                    col5<=8'h11;
                    col6<=8'h11;
                    col7<=8'h11;
                    col8<=8'h00;
                    end
                4'd11: //B
                    begin
                    col1<=8'h1e;
                    col2<=8'h09;
                    col3<=8'h09;
                    col4<=8'h0e;
                    col5<=8'h09;
                    col6<=8'h09;
                    col7<=8'h1e;
                    col8<=8'h00;
                    end
                4'd12: //C
                    begin
                    col1<=8'h0e;
                    col2<=8'h11;
                    col3<=8'h10;
                    col4<=8'h10;
                    col5<=8'h10;
                    col6<=8'h11;
                    col7<=8'h0e;
                    col8<=8'h00;
                    end
                4'd13: //D
                    begin
                    col1<=8'h1e;
                    col2<=8'h09;
                    col3<=8'h09;
                    col4<=8'h09;
                    col5<=8'h09;
                    col6<=8'h09;
                    col7<=8'h1e;
                    col8<=8'h00;
                    end
                4'd14: //E
                    begin
                    col1<=8'h1f;
                    col2<=8'h10;
                    col3<=8'h10;
                    col4<=8'h1e;
                    col5<=8'h10;
                    col6<=8'h10;
                    col7<=8'h1f;
                    col8<=8'h00;
                    end
                4'd15: //F
                    begin
                    col1<=8'h1f;
                    col2<=8'h10;
                    col3<=8'h10;
                    col4<=8'h1e;
                    col5<=8'h10;
                    col6<=8'h10;
                    col7<=8'h10;
                    col8<=8'h00;
                    end
                default: //全暗
                    begin
                    col1<=8'b00000000;
                    col2<=8'b00000000;
                    col3<=8'b00000000;
                    col4<=8'b00000000;
                    col5<=8'b00000000;
                    col6<=8'b00000000;
                    col7<=8'b00000000;
                    col8<=8'b00000000;
                    end
            endcase
        end

    always@(row_buf) //逐个导通每一行
        begin
            case(row_buf) //每导通新的一行，重新装载这行对应的8 列数据
                8'b0000_0001://此处下划线无意义不编译，只是为了便于阅读
                    col_buf=col1; //第 1行选通时,将现在要显示字符的第 1行数据输出到点阵数据线
                8'b0000_0010:
                    col_buf=col2; //第 2 行选通时，将现在要显示字符的第 2行数据输出到点阵数据线
                8'b0000_0100:
                    col_buf=col3; //第 3 行选通时，将现在要显示字符的第 3 行数据输出到点阵数据线
                8'b0000_1000:
                    col_buf=col4;//第 4 行选通时，将现在要显示字符的第 4 行数据输出到点阵数据线
                8'b0001_0000:
                    col_buf=col5; //第 5行选通时，将现在要显示字符的第 5 行数据输出到点阵数据线
                8'b0010_0000:
                    col_buf=col6; //第 6行选通时，将现在要显示字符的第6 行数据输出到点阵数据线
                8'b0100_0000:
                    col_buf=col7; //第 7 行选通时，将现在要显示字符的第 7行数据输出到点阵数据线
                8'b1000_0000:
                    col_buf=col8; //第 8 行选通时，将现在要显示字符的第 8 行数据输出到点阵数据线
                default:
                    col_buf=8'h00;
            endcase
        end
    assign led_row=row_buf;//输出到点阵的行选择线(高电平有效)
    assign led_col=~col_buf; //输出到点阵数据线 (低电平有效)
    //注意行、列变量的高低位顺序，顺序不对将会导致显示的左右或上下颠倒
endmodule