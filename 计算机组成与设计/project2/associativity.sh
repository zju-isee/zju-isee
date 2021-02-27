#!/bin/bash

trace_files=("spice" "tex" "cc")

mkdir myOut_2

rm myOut_2/*assoc.txt

echo -e '\n\n'

for f in "${trace_files[@]}"
	do
	:
	for ((i=1; i <= 64 ; i=2*i));
		do
		echo -e 'Executing ' $f 'with associativity ' $i
		code/sim -is 8192 -ds 8192 -bs 128 -a $i -wb -wa ext_traces/$f.trace >> myOut_2/$f'_stats_3_assoc.txt'
		echo -e '\n\n\n\n\n\n\n\n\n\n\n' >> myOut_2/$f'_stats_3_assoc.txt'
	done
done


