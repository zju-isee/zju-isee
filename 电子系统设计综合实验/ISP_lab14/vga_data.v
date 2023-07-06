
//VGA信号电路，输出图像生成（水平或垂直的彩色条纹)
module vga_data(orient,nblank,hcnt,vcnt,vga_d);
input orient,nblank;
input [9:0] hcnt,vcnt;
output [2:0] vga_d;
reg [2:0] vga_d;
always @(*)
begin
//消隐信号低电平有效时，三基色输出信号为0，即黑色
if(nblank==0)
    vga_d=0;
//拨码开关CS1控制显示水平条幅、还是垂直条幅
else if(orient)
    //水平彩条信号只与帧像素有关，8种颜色平分600帧像素
    if(vcnt<75) vga_d=1;//红
    else if(vcnt<150) vga_d=2;//绿
    else if(vcnt<225) vga_d=3;//黄
    else if(vcnt<300) vga_d=4;//蓝
    else if(vcnt<375) vga_d=5;//品红
    else if(vcnt<450) vga_d=6;//青
    else if(vcnt<525) vga_d=7;//白
    else vga_d=0;//黑

else
//垂直彩条信号只与行像素有关，8种颜色平分800行像素
    if(hcnt<100) vga_d=1;//l红
    else if(hcnt<200) vga_d=2;//绿
    else if(hcnt<300) vga_d=3;//黄
    else if(hcnt<400) vga_d=4;//蓝
    else if(hcnt<500) vga_d=5;//品红
    else if(hcnt<600) vga_d=6;//青
    else if(hcnt<700) vga_d=7;//白
    else vga_d=0; //黑
end

endmodule