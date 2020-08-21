#!/bin/bash
#--- this script is in use to debug
#--- usage to run with a trace option: "bash -x 'script.sh'"
value="Hello World!"
echo $value

#--- set a debug flag by using "trap 'command(s)' DEBUG"
#--- in korn shell only: "trap 'command(s)' ERR"

#trap 'printf "debugging on line number $LINENO :-> "; read line; eval $line' DEBUG

step=10
while [ $step -lt 10 ]; do
	echo "step: $step"
done

#--- opening a new terminal, depending on the desktop theme, while this script runs
#--- in this case a new mate terminal will be created
#--- command: mate-terminal -- command(s) argument(s) 'optional: path or file name' to run with the new created sub terminal
#mate-terminal
#mate-terminal --full-screen -- man mate-terminal
mate-terminal --full-screen -- nano -c 'scriptToDebug.sh'
