#!/bin/bash
#This script is in use to demonstrate a switch-case expression in shell

var="Hello"

# if the number of arguments is not one
if [ $# -ne 1 ]; then
	echo " usage: $0 argument"
	exit 1
fi

#switch-case
case $1 in
a)
	echo " argument was an 'a'";;
b)
	echo " argument was a 'b'";;
c)
	echo " argument was a 'c'";;
$var)
	echo " argument: $var";;
*)
	echo " argument was: $1";;
esac
