-makelib ies_lib/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../Risc5CPU.srcs/sources_1/ip/DCM_PLL/DCM_PLL_clk_wiz.v" \
  "../../../../Risc5CPU.srcs/sources_1/ip/DCM_PLL/DCM_PLL.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

