%MASTERCLOCKMULT = 1;
%SMALLESTUNIT    = 12;
%AUTOASSIGN      = 1;
%DECIMALS        = 0;
%ENDTIME         = 100000;
clk1 { A In Default None 0 1 50 } = (1 200 0 200)## ;
key_in0 { A In Default None 0 1 50 } = 1 500(1 49500 0 150000
  )#10 ;
key_in1 { A In Default None 0 1 50 } = 0 500(0 49500 1 50000 0 100000
  )#10 ;
key_in2 { A In Default None 0 1 50 } = (0 100000 1 50000 0 50000
  )#10 ;
key_in3 { A In Default None 0 1 50 } = 0 500(0 149500 1 50000
  )#10 ;
reset { A In Default None 0 1 50 } = 0 1500 1 1074000;
clk { A In Default None 0 1 50 } = 1 200(1 9800 0 10000)## ;
