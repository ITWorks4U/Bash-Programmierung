#!/bin/bash
#demonstration of loopings in bash: while

ctr=0

while [ $ctr -lt 10 ]
do
	echo " ctr = $ctr" 
	((ctr++))
done
