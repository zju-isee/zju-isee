#!/bin/bash

mkdir myOut_1
rm myOut_1/*.out

echo "----run small test----"
code/sim -bs 16 -us 8192 -a 1 -wb -wa traces/public-block.trace > myOut_1/public-block1.out
code/sim -bs 16 -us 8192 -a 1 -wb -wa traces/public-assoc.trace > myOut_1/public-assoc1.out
code/sim -bs 16 -us 8192 -a 1 -wb -wa traces/public-write.trace > myOut_1/public-write1.out
code/sim -bs 16 -us 8192 -a 1 -wb -wa traces/public-instr.trace > myOut_1/public-instr1.out

code/sim -bs 16 -us 8192 -a 1 -wb -wa traces/spice10.trace > myOut_1/spice10.out
code/sim -bs 16 -us 8192 -a 1 -wb -wa traces/spice100.trace > myOut_1/spice100.out
code/sim -bs 16 -us 8192 -a 1 -wb -wa traces/spice1000.trace > myOut_1/spice1000.out

echo "----run big test----"
code/sim -bs 16 -us 256 -a 1 -wb -wa traces/public-assoc.trace > myOut_1/public-assoc.out
code/sim -bs 16 -us 256 -a 2 -wb -wa traces/public-assoc.trace >> myOut_1/public-assoc.out
code/sim -bs 16 -us 256 -a 4 -wb -wa traces/public-assoc.trace >> myOut_1/public-assoc.out
code/sim -bs 16 -us 256 -a 8 -wb -wa traces/public-assoc.trace >> myOut_1/public-assoc.out

code/sim -bs 16 -us 256 -a 1 -wb -wa traces/public-block.trace > myOut_1/public-block.out
code/sim -bs 8 -us 256 -a 1 -wb -wa traces/public-block.trace >> myOut_1/public-block.out
code/sim -bs 4 -us 256 -a 1 -wb -wa traces/public-block.trace >> myOut_1/public-block.out
code/sim -bs 32 -us 256 -a 1 -wb -wa traces/public-block.trace >> myOut_1/public-block.out

code/sim -bs 16 -us 256 -a 1 -wb -wa traces/public-instr.trace > myOut_1/public-instr.out
code/sim -bs 16 -us 512 -a 1 -wb -wa traces/public-instr.trace >> myOut_1/public-instr.out
code/sim -bs 16 -is 128 -ds 128 -a 1 -wb -wa traces/public-instr.trace >> myOut_1/public-instr.out
code/sim -bs 16 -is 256 -ds 256 -a 1 -wb -wa traces/public-instr.trace >> myOut_1/public-instr.out

code/sim -bs 16 -us 256 -a 1 -wb -wa traces/public-write.trace > myOut_1/public-write.out
code/sim -bs 16 -us 256 -a 1 -wt -wa traces/public-write.trace >> myOut_1/public-write.out
code/sim -bs 16 -us 256 -a 1 -wb -nw traces/public-write.trace >> myOut_1/public-write.out

code/sim -bs 16 -us 256 -a 1 -wb -wa traces/spice10000.trace > myOut_1/spice10000-assoc.out
code/sim -bs 16 -us 256 -a 2 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-assoc.out
code/sim -bs 16 -us 256 -a 4 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-assoc.out
code/sim -bs 16 -us 256 -a 8 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-assoc.out
code/sim -bs 16 -us 8192 -a 2 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-assoc.out
code/sim -bs 16 -us 8192 -a 4 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-assoc.out
code/sim -bs 16 -us 8192 -a 8 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-assoc.out

code/sim -bs 16 -us 256 -a 1 -wb -wa traces/spice10000.trace > myOut_1/spice10000-block.out
code/sim -bs 8 -us 256 -a 1 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-block.out
code/sim -bs 4 -us 256 -a 1 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-block.out
code/sim -bs 32 -us 8192 -a 1 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-block.out
code/sim -bs 64 -us 8192 -a 1 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-block.out
code/sim -bs 128 -us 8192 -a 1 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-block.out

code/sim -bs 16 -us 256 -a 1 -wb -wa traces/spice10000.trace > myOut_1/spice10000-instr.out
code/sim -bs 16 -us 512 -a 1 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-instr.out
code/sim -bs 16 -is 128 -ds 128 -a 1 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-instr.out
code/sim -bs 16 -is 256 -ds 256 -a 1 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-instr.out
code/sim -bs 16 -is 1024 -ds 1024 -a 1 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-instr.out
code/sim -bs 16 -is 4096 -ds 4096 -a 1 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-instr.out
code/sim -bs 16 -is 8192 -ds 8192 -a 1 -wb -wa traces/spice10000.trace >> myOut_1/spice10000-instr.out

code/sim -bs 16 -us 256 -a 1 -wb -wa traces/spice10000.trace > myOut_1/spice10000-write.out
code/sim -bs 16 -us 256 -a 1 -wt -wa traces/spice10000.trace >> myOut_1/spice10000-write.out
code/sim -bs 16 -us 256 -a 1 -wb -nw traces/spice10000.trace >> myOut_1/spice10000-write.out

echo "all output done"

