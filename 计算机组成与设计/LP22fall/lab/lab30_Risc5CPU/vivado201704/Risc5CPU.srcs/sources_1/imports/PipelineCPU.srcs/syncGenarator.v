////////////////////////////////////////////////////////////////////////
//640*480@60Hz格式行场同步信号产生器，若修改为800*600@60Hz，注意
//若修改为800*600@60Hz，注意PosX、PosY、PosX_reg、PosY_reg数据宽度
////////////////////////////////////////////////////////////////////////
module syncGenarator(  
    input   wire pixel_clk, // 
    input   wire reset, 
    output  wire [9:0]PosX, 
    output  wire [8:0]PosY, 
    output  reg hSync ,
    output  reg vSync , 
    output  reg ActiveArea);
//640*480@60Hz
 parameter    H_ACTIVE=640;    
 parameter    H_FRONT=16 ;    
 parameter    H_SYNC=96   ;    
 parameter    H_BACK=48    ;    
 parameter    V_ACTIVE=480 ;         
 parameter    V_FRONT=11   ;    
 parameter    V_SYNC=2 ;    
 parameter    V_BACK=31;            
 parameter  H_TOTAL  = H_SYNC + H_BACK + H_ACTIVE + H_FRONT;    
 parameter  V_TOTAL  = V_SYNC + V_BACK + V_ACTIVE + V_FRONT;        
  ////////////////////////////////////////////////////////////////////////  

 reg[9:0]   PosX_reg=0,PosY_reg=0;
 assign     PosX=PosX_reg-H_SYNC-H_BACK;
 assign     PosY=PosY_reg-V_SYNC-V_BACK ;
 //行计数
  wire EndLine;
  assign    EndLine=PosX_reg==(H_TOTAL-1);
  always @(posedge pixel_clk) 
   if(EndLine||reset)  PosX_reg=0; else  PosX_reg=PosX_reg+1;  
  //帧计数   
  wire FrameLine;
  assign   EndFrame=EndLine && (PosY_reg==(V_TOTAL-1));
  always @(posedge pixel_clk) 
    if(reset) PosY_reg=0;
     else
     begin
      if(EndLine) 
          begin  if(EndFrame) PosY_reg=0; else  PosY_reg=PosY_reg+1; end 
     end     
   //显示区    
  always @(*) ActiveArea <= (PosX_reg>=H_SYNC+H_BACK) &&
                            (PosX_reg<H_ACTIVE+H_SYNC+H_BACK) && //
                            (PosY_reg>=V_SYNC+V_BACK) &&
                            (PosY_reg<V_ACTIVE+V_SYNC+V_BACK);  
  


  //行同步
  always @(*)
    if(  PosX_reg<H_SYNC )  hSync =0;
    else   hSync =1;
    //帧同步    
  always @(*) 
     if (  PosY_reg<V_SYNC)   vSync =0;
     else vSync =1;  
	 
  
endmodule  
