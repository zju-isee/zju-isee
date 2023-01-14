#!/bin/bash

trace_files=("spice" "tex" "cc")

mkdir myOut_2

rm myOut_2/*wsc.txt

echo -e '\n\n'

k=0

for f in "${trace_files[@]}"
	do
	:
	for ((i=1; i <= 268435456 ; i=2*i));
		do
		k=$(($i*4))
		echo -e 'Executing ' $f 'with cache size ' $k
		code/sim -is $k -ds $k -bs 4 -a $i -wb -wa ext_traces/$f.trace >> myOut_2/$f'_stats_1_wsc.txt'
		echo -e '\n\n\n\n\n\n\n\n\n\n\n' >> myOut_2/$f'_stats_1_wsc.txt'
	done
done









