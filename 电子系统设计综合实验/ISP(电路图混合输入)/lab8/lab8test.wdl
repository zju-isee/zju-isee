%MASTERCLOCKMULT = 1;
%SMALLESTUNIT    = 9;
%AUTOASSIGN      = 1;
%DECIMALS        = 0;
%ENDTIME         = 100000;
clk1 { A In Default None 0 1 50 } = 1 20(1 3480 0 3500)## ;
key_in1 { A In Default None 0 1 50 } = 0 500(0 9500 1 10000 0 30000
   1 10000 0 30000 1 10000 0 20000)## ;
key_in2 { A In Default None 0 1 50 } = 0 500(0 19500 1 10000 0 30000
   1 10000 0 30000 1 10000 0 10000)## ;
key_in3 { A In Default None 0 1 50 } = 0 500(0 29500 1 10000 0 30000
   1 10000 0 30000 1 10000)## ;
reset { A In Default None 0 1 50 } = 0 600 1 10253400;
clk { A In Default None 0 1 50 } = 1 20(1 147 0 167)## ;
key_out1 { A Out Default None 0 1 50 } = ;
key_out2 { A Out Default None 0 1 50 } = ;
key_out3 { A Out Default None 0 1 50 } = ;
key_out4 { A Out Default None 0 1 50 } = ;
LED0 { A Out Default None 0 1 50 } = ;
LED1 { A Out Default None 0 1 50 } = ;
LED2 { A Out Default None 0 1 50 } = ;
LED3 { A Out Default None 0 1 50 } = ;
LED4 { A Out Default None 0 1 50 } = ;
PointTime { A Out Default None 0 1 50 } = ;
a { A Out Default None 0 1 50 } = ;
b { A Out Default None 0 1 50 } = ;
c { A Out Default None 0 1 50 } = ;
d { A Out Default None 0 1 50 } = ;
e { A Out Default None 0 1 50 } = ;
f { A Out Default None 0 1 50 } = ;
g { A Out Default None 0 1 50 } = ;
LEDVCC1 { A Out Default None 0 1 50 } = ;
LEDVCC2 { A Out Default None 0 1 50 } = ;
LEDVCC3 { A Out Default None 0 1 50 } = ;
LEDVCC4 { A Out Default None 0 1 50 } = ;
