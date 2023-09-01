module VGA(clk_50m,reset_n,orient,vga_hs,vga_vs,vga_d,blank);

    input clk_50m,reset_n;
    input orient;
    output vga_hs,vga_vs;
    output [2:0] vga_d;
    output blank;
    reg [2:0] vga_d;
    wire blank;
    reg [10:0] hcnt,vcnt;
    reg hsyncint;
    wire vga_hs;
    reg vga_vs;
    reg enable;


    //Horizontal timing constants
    //???9-23?????? 800????????? 16,//????????80????????? 160?
    parameter   H_PIXELS    ='d800,//???
                H_FRONTPORCH='d16,//???
                H_SYNCTIME  ='d80,//???
                H_BACKPORCH ='d160,//???
                H_SYNCSTART ='d816,//H_PIXELS +H_FRONTPORCH?????
                H_SYNCEND   ='d896,//H SYNCSTART+H SYNCTIME?????
                H_PERIOD    ='d1056,//H SYNCEND +H BACKPORCH????
                //Vertical timing constants
                //??? 9-23????? 600???????? 1?
                //???????? 3???????? 21?
                V_LINES      ='d600,//???
                V_FRONTPORCH ='d1,//???
                V_SYNCTIME   ='d3,//???
                V_BACKPORCH  ='d21,//???
                V_SYNCSTART  ='d601,//V LINES+V FRONTPORCH????
                V_SYNCEND    ='d604,
                V_PERIOD     ='d625;//V_SYNCSTART+V SYNCTIME????
    //??????? vga ctrl ????????????????????????????
    //????????(Hsynch)?????(Hfp)?????(Hbp)??????(Hactive)
    //?4??????????????? 1056(H PERIOD)
    //????????? 1056????????1056?
    //Horizontal counter of pixels ???????
    always @(posedge clk_50m or negedge reset_n) 
        if(!reset_n)
            hcnt<=0;
        else if(hcnt<H_PERIOD)
            hcnt<=hcnt+1;
        else
            hcnt<=0;


    //???????????????????
    //????????????????
    always @(posedge clk_50m or negedge reset_n) begin
        if(!reset_n)
            hsyncint<=1;
        else if (hcnt>H_SYNCSTART&&hcnt<H_SYNCEND)
            hsyncint<=0;
        else
            hsyncint<=1;
    end

    //??????
    //?????
    assign vga_hs = hsyncint;


    //?????????????????
    always @(posedge hsyncint or negedge reset_n) 
        if(!reset_n)
            vcnt<=0;
        else if(vcnt<V_PERIOD)
            vcnt<=vcnt+1;
        else
            vcnt<=0;


    //?????????
    always @(posedge hsyncint or negedge reset_n) 
        if(!reset_n)
            vga_vs<=1;
        else if(vcnt>=V_SYNCSTART&&vcnt<V_SYNCEND)
            vga_vs<=0;
        else
            vga_vs<=1;




    //???????
    always @(posedge clk_50m or negedge reset_n) 
        if(!reset_n)
            enable<=0;
        else if(hcnt>=H_PIXELS||vcnt>=V_LINES)
            enable<=0;
        else
            enable<=1;

    assign blank = enable;

    //??????
    always @(enable or orient or hcnt or vcnt)
        if(enable==0)
            vga_d=0;
        else if(orient)
            begin
                if(vcnt<75)
                    vga_d='h1;
                else if(vcnt<150)
                    vga_d='h2;
                else if(vcnt<225)
                    vga_d='h3;
                else if(vcnt<300)
                    vga_d='h4;
                else if(vcnt<375)
                    vga_d='h5;
                else if(vcnt<450)
                    vga_d='h6;
                else if(vcnt<525)
                    vga_d='h7;
                else
                    vga_d='h0;
            end
        else
            begin
                if(hcnt<100)
                    vga_d='h1;
                else if(hcnt<200)
                    vga_d='h2;
                else if(hcnt<300)
                    vga_d='h3;
                else if(hcnt<400)
                    vga_d='h4;
                else if(hcnt<500)
                    vga_d='h5;
                else if(hcnt<600)
                    vga_d='h6;
                else if(hcnt<700)
                    vga_d='h7;
                else
                    vga_d='h0;
            end

endmodule