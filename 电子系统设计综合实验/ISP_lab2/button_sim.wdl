%MASTERCLOCKMULT = 1;
%SMALLESTUNIT    = 12;
%AUTOASSIGN      = 1;
%DECIMALS        = 0;
%ENDTIME         = 100000;
ButtonIn { A In Default None 0 1 50 } = 0 7500 1 20000 0 11500
   1 20000 0 23000 1 21000 0 31000 1 22500 0 6000;
clk { A In Default None 0 1 50 } = (1 1000 0 1000)## ;
reset { A In Default None 0 1 50 } = 0 98500 1 16000 0 44500;
pulse1kHz { A In Default None 0 1 50 } = (1 10000 0 10000)## 
  ;
