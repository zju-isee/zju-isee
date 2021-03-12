module pipeline_adder (clk, a, b, ci, s, co);
    input clk;
    input[31:0] a, b;
    input ci;
    output reg [31:0] s;
    output reg co;

    reg[31:0] tempa0, tempb0;  //a和b缓存
    reg tempci;                //ci缓存

    reg[7:0] sum0;             //第一级加法输出结果缓存
    reg co0;
    reg[23:0] tempa1, tempb1;  //存放第一次加法后a,b剩余的24位

    reg[15:0] sum1;            //前二级加法输出结果缓存
    reg co1;
    reg[15:0] tempa2, tempb2;  //存放第二次加法后a,b剩余的16位
    
    reg[23:0] sum2;            //前三级加法输出结果缓存
    reg co2;
    reg[7:0] tempa3, tempb3;   //存放第三次加法后a,b剩余的8位

    //a,b,ci缓存
    always @(posedge clk)
    begin
        tempci <= ci;
        tempa0 <= a;
        tempb0 <= b;
    end

    //第一级8位加法，a,b剩余位缓存
    always @(posedge clk)
    begin
        {co0, sum0} <= 9'b0 + tempa0[7:0] + tempb0[7:0] + tempci;
        tempa1 <= tempa0[31:8];
        tempb1 <= tempb0[31:8];
    end

    //第二级8位加法，a,b剩余位缓存
    always @(posedge clk)
    begin
        {co1, sum1} <= {9'b0 + tempa1[7:0] + tempb1[7:0] + co0, sum0};
        tempa2 <= tempa1[23:8];
        tempb2 <= tempb1[23:8];
    end

    //第三级8位加法，a,b剩余位缓存
    always @(posedge clk)
    begin
        {co2, sum2} <= {9'b0 + tempa2[7:0] + tempb2[7:0] + co1, sum1};
        tempa3 <= tempa2[15:8];
        tempb3 <= tempb2[15:8];
    end

    //第四级8位加法
    always @(posedge clk)
    begin
        {co, s} <= {9'b0 + tempa3[7:0] + tempb3[7:0] + co2, sum2};
    end

endmodule