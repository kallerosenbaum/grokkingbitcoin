#!/bin/bash

ratio=0.23
bfsize=26
hfcount=3
txcount=10000
testspertx=9
currtx=0

hits=0

while [ $currtx -lt $txcount ]; do
    currtx=$((currtx+1));
    for i in `seq 1 $testspertx`; do    
	for j in `seq 1 $hfcount`; do
	    if [ $(echo " $RANDOM % $bfsize >= $ratio * $bfsize" | bc) -eq 1 ] ; then
		#$((RANDOM % bfsize)) -ge $((ratio * bfsize)) ]; then
		continue 2;
	    fi
	done
	hits=$((hits+1));
	continue 2;
    done
done

echo $hits
