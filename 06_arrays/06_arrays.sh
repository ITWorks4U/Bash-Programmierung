#!/bin/bash
#This script shows you how to use arrays in shell programming.
varA=10
varB=11
#---------------

array[0]=10
array[1]=11
#---------------

echo "${array[0]}, ${array[1]}"

array2=()
array3=(10 11 12 13 14 15 3.141 "Hello World!")

echo "${array3[*]}"
