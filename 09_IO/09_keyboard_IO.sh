#!/bin/bash
#demonstration about how to use variables, constants and read from keyboard

#---variables and a bit more
#var=12345
#echo $var

#unset var
#echo " --> $var"

#readonly PI_NBR=3.141
#echo $PI_NBR

#PI_NBR=951753
#echo $PI_NBR

#---reading from keyboard
value=""
#echo " enter a value: "
read -s -p " enter a value: " value

echo $value
