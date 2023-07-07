module CALCULATE(clk,reset,key_in,Data_Out,key_out);

    input clk,reset;
    input [3:0] key_in;
    output [3:0] Data_Out;
    output [3:0] key_out;



    reg [16:0] timecnt;
    reg time10ms;
    reg [3:0] scanvalue;
    reg [3:0] key_out;
    reg [3:0] Data_Out;


    //����10msʱ�ӵĽ���
    always @(posedge clk or negedge reset) //clk Ϊϵͳʱ���ź� 6MHz
    begin
        if(reset==1'b0)timecnt<=0; //timecnt Ϊ��Ƶ�������������õ�10ms ʱ��
        else if(timecnt==29999)
            begin
                time10ms<=~time10ms; //timel0ms Ϊ10ms ʱ��
                timecnt<=0;
            end
        else timecnt<=timecnt+1;
    end
    //����ɨ�����
    always @(posedge time10ms or negedge reset)
    begin
        if(reset==0)
            begin
                scanvalue<=1;//scanvalue ���ڼ�¼ɨ������
            end
        else
            begin
                key_out<=scanvalue;//���ɨ��ֵ
                case(scanvalue)//ɨ��ֵ��λ
                    4'b0001: scanvalue<=4'b0010;
                    4'b0010: scanvalue<=4'b0100;
                    4'b0100: scanvalue<=4'b1000;
                    4'b1000: scanvalue<=4'b0001;
                    default: scanvalue<=4'b0001;
                endcase
                case({key_in,key_out})//����ɨ����
                    8'b00010001://��Ӧ���̡�1��
                        begin
                            Data_Out<=1;
                        end
                    8'b00100001://��Ӧ���̡�2��
                        begin
                            Data_Out<=2;
                        end
                    //��Ӧ���̡�3������g������0����Դ������1��2���ƣ�ע������ɨ����Ĳ�ͬ���ɣ�����
                    8'b01000001://��Ӧ���̡�3��
                        begin
                            Data_Out<=3;
                        end
                    8'b00010010://��Ӧ���̡�4��
                        begin
                            Data_Out<=4;
                        end
                    8'b00100010://��Ӧ���̡�5��
                        begin
                            Data_Out<=5;
                        end
                    8'b01000010://��Ӧ���̡�6��
                        begin
                            Data_Out<=6;
                        end
                    8'b00010100://��Ӧ���̡�7��
                        begin
                            Data_Out<=7;
                        end
                    8'b00100100://��Ӧ���̡�8��
                        begin
                            Data_Out<=8;
                        end
                    8'b01000100://��Ӧ���̡�9��
                        begin
                            Data_Out<=9;
                        end
                    8'b00011000://��Ӧ���̡�0��
                        begin
                            Data_Out<=0;
                        end
                    default:;//�޼��̰���
                endcase
            end
    end

endmodule
