#!/bin/bash
#This file handles with given arguments and it's types

echo "first argument is: $0"
echo "given arguments are: $2, $1, $3"
echo "total number of arguments: $#"

echo $*
echo $@

echo "exit value: $?"
echo "process number = $$"
