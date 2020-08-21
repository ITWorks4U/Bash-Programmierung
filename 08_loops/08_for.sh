#!/bin/bash
#demonstration of loopings: for

array=(0 1 2 3 4 5 6 7 8 9 "Hello")
for i in ${array[*]}
do
	echo " i = $i"
done

for j in 0 1 2 3 4 5 6 7 8 9
do
	echo " j = $j"
done

for ((k=0; k < 10; k++))
do
	echo " k = $k"
done

for files in $HOME/.*
do
	echo " $files"
done
