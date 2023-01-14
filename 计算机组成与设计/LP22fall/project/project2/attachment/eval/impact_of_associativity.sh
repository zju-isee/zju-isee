#!/bin/bash
rm /home/bao/cacheSim_project2/ext_traces/*.txt
cnt=0
k=0

for f in /home/bao/cacheSim_project2/ext_traces/*
	do
    (( cnt++ ))
	for ((i=1; i <= 64 ; i=2*i));
		do
		echo -e 'Executing ' $f 'with associativity ' $i
		../code/sim -is 8192 -ds 8192 -bs 128 -a $i -wb -wa $f >> "$f.txt"
	done
    grep -E "miss rate|cache size" "$f.txt" > "$cnt.txt"
done