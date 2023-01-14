#!/bin/bash

trace_files=("spice" "tex" "cc")

mkdir myOut_2

rm myOut_2/*block.txt

echo -e '\n\n'

for f in "${trace_files[@]}"
	do
	:
	for ((i=4; i <= 4096 ; i=2*i));
		do
		echo -e 'Executing ' $f 'with block size ' $i
		code/sim -is 8192 -ds 8192 -bs $i -a 2 -wb -wa ext_traces/$f.trace >> myOut_2/$f'_stats_2_block.txt'
		echo -e '\n\n\n\n\n\n\n\n\n\n\n' >> myOut_2/$f'_stats_2_block.txt'
	done
done









