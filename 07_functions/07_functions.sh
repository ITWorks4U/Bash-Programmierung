#!/bin/bash
# demonstration of functions in bash
#IMPORTANT: A function must be defined before you're calling this function.

#definition of a function
function myFunction() {
	echo " Hello from myFunction."
}

myAnotherFunction() {
	echo
}

function myFunctionWithArguments() {
	echo " number of arguments: $#"
	echo " arguments are: $@"
}

function doSomething() {
	tmp=0

	((tmp++))
	tmp=$(($tmp + 1))
	tmp=`expr $tmp + 1`

	return $tmp
}

#calling a function
myFunction
echo " `myFunction`"

myFunctionWithArguments 1 2 3 " Hello from this function"

doSomething
echo " $?"
