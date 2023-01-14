#!/bin/bash
rm /home/bao/cacheSim_project2/ext_traces/*.txt
cnt=0
k=0
for f in /home/bao/cacheSim_project2/ext_traces/*
	do
    (( cnt++ ))
	for ((i=1; i <= 268435456 ; i=2*i));
		do
		k=$(($i*4))
		echo -e 'Executing ' $f 'with cache size ' $k
		../code/sim -is $k -ds $k -bs 4 -a $i -wb -wa $f >> "$f.txt"
	done
    grep -E "miss rate|cache size" "$f.txt" > "$cnt.txt"
done