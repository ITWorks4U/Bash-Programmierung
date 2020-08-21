#!/bin/bash
#this script contains the if statements for a shell script

varA=20
varB=21

if [ $varA -eq $varB ]
	then
		echo "Both variables are equal."
elif [ $varA -gt $varB ]
	then
		echo "varA is greater than varB."
elif [ $varA -lt $varB ]
	then
		echo "varA is lower than varB."
else
		echo "Both variables are not equal."
fi

#date formatting from part 2:
current_time=$(date +"%H")

echo "current hour is: $current_time"

if [ $current_time -gt 18 ]; then
	echo "Good evening!"
elif [ $current_time -gt 12 ]; then
	echo "Good day!"
elif [ $current_time -gt 6 ]; then
	echo "Good morning!"
else
	echo "Good night!"
fi
