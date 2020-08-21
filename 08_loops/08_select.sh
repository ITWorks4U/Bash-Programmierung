#!/bin/bash
#demonstration of loopings: select

array=(0 1 2 3 4 5 6 7 8 9)
select numbers in ${array[*]}
do
	case $numbers in
	1|3|5|7|9)
		echo " The number is odd.";;
	2|4|6|8|0)
		echo " The number is even.";;
	esac
done
