#!/bin/bash
#demonstration of loopings: recursion

function recursion() {
	if [ $1 -lt 10 ]; then
		echo " $1"
		recursion $(($1 + 1))
	fi
}

recursion 0
