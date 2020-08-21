#!/bin/bash
#demonstration of loopings: until

ctr=0
until [ $ctr -ge 10 ]
do
	echo " ctr = $ctr"
	ctr=`expr $ctr + 1`
done
