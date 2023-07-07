%MASTERCLOCKMULT = 1;
%SMALLESTUNIT    = 12;
%AUTOASSIGN      = 1;
%DECIMALS        = 0;
%ENDTIME         = 100000;
clk { A In Default None 0 1 50 } = 1 200(1 1800 0 2000)## ;
reset { A In Default None 0 1 50 } = 1 13000000;
key_in[3] { A In Default None 0 1 50 } = 1 200(1 7800 0 24000
  )#1000 ;
key_in[2] { A In Default None 0 1 50 } = 0 200(0 7800 1 8000 0 16200
  )#1000 ;
key_in[1] { A In Default None 0 1 50 } = 0 200(0 15800 1 8000
   0 8000)#1000 ;
key_in[0] { A In Default None 0 1 50 } = 0 200(0 23800 1 8000
  )#1000 ;
