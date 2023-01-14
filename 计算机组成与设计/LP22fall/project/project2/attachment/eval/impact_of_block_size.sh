#!/bin/bash

rm /home/bao/cacheSim_project2/ext_traces/*.txt

cnt=0
k=0
for f in /home/bao/cacheSim_project2/ext_traces/*
	do
    (( cnt++ ))
	for ((i=4; i <= 4096 ; i=2*i));
		do
		echo -e 'Executing ' $f 'with block size ' $i
		../code/sim -is 8192 -ds 8192 -bs $i -a 2 -wb -wa $f >> "$f.txt"
	done
    grep -E "miss rate|cache size" "$f.txt" > "$cnt.txt"
done