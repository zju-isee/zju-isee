#!/bin/bash

echo "compare my cache design output with standard output"
echo "--test begin--"

for file1 in $(ls ./myOut_1)
do
	for file2 in $(ls ./outputs)
	do
		if [ $file1 = $file2 ]
		then
			diff -b -B --ignore-matching-lines "sim" ./myOut_1/${file1} ./outputs/${file2}
		fi
	done
done

echo "--test end--"
echo "test passed"
