#!/bin/bash
# file operations

#touch listOfAllFiles.txt

#--- writing in files
#ls -al $HOME > listOfAllFiles.txt

#array=(1 2 3 4 5 6 7 8 9 0)
#for i in ${array[*]}; do
#	echo $i >> counter.txt
#done

#--- reading in files
#less listOfAllFiles.txt

#exec 0<listOfAllFiles.txt

#lineNbr=1

#while read line; do
#	echo " $lineNbr: $line"
#	((lineNbr++))
#done

#truncate --size 0 counter.txt

ls -al counter.txt listOfAllFiles.txt noExistingFile 1>content.txt 2>errFile.txt
