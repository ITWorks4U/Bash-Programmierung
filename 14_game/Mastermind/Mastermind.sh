#!/bin/bash
#	A simple mastermind written in bash. Enter four colors and try to figure out which color on which position was correct.

color_holder=()											#	we don't have any color at the beginning
already_done=(0 0 0 0)										#	a binary indicator
points=0											#	number of points

#########################################
#	Create an array with four colors,
#	where each color has an ID.
#
#	0:	red	1:	yellow
#	2:	green	3:	orange
#	4:	cyan	5:	white
#	6:	black	7:	brown
#########################################
function createRandomColors() {
	for ((i=0;i<4;i++)); do
		number=`expr $RANDOM % 8`
		case $number in
			0)
				color_holder[i]="red";;
			1)
				color_holder[i]="yellow";;
			2)
				color_holder[i]="green";;
			3)
				color_holder[i]="orange";;
			4)
				color_holder[i]="cyan";;
			5)
				color_holder[i]="white";;
			6)
				color_holder[i]="black";;
			7)
				color_holder[i]="brown";;
		esac
	done
}

##########################
#	start the program,
#	unless the number
#	of arguments is
#	smaller than 5
##########################
if [ $# -ne 4 ]; then										#	if we don't run the program with four arguments
	echo "usage: $0 color_1 color_2 color_3 color_4"
	exit 1
fi

createRandomColors										#	shuffle colors
firstColor=$1											#	copy all colors from the argument list
secondColor=$2
thirdColor=$3
fourthColor=$4

for ((rounds=0; rounds<5; rounds++)); do							#	the user gets five tries to figure out the combination
	rounds_output=$rounds
	echo "round `expr $rounds_output + 1`:"

	if [ ${already_done[0]} -ne 1 ]; then							#	check, if the first color is still unknown
		if [ $firstColor == ${color_holder[0]} ]; then					#	if true, then check, if the first color is equal to the randomly created color
			echo " $firstColor: correct"						#	if also true, then notify the user and set the binary value to 1
			already_done[0]=1
			((points++))
		else
			echo " $firstColor: wrong"
		fi
	fi

	if [ ${already_done[1]} -ne 1 ]; then							#	same process for the other colors left
		if [ $secondColor == ${color_holder[1]} ]; then
			echo " $secondColor: correct"
			already_done[1]=1
			((points++))
		else
			echo " $secondColor: wrong"
		fi
	fi

	if [ ${already_done[2]} -ne 1 ]; then
		if [ $thirdColor == ${color_holder[2]} ]; then
			echo " $thirdColor: correct"
			already_done[2]=1
			((points++))
		else
			echo " $thirdColor: wrong"
		fi
	fi

	if [ ${already_done[3]} -ne 1 ]; then
		if [ $fourthColor == ${color_holder[3]} ]; then
			echo " $fourthColor: correct"
			already_done[3]=1
			((points++))
		else
			echo " $fourthColor: wrong"
		fi
	fi

	##################################################
	#	enter new colors, if color i was incorrect
	##################################################

	if [ ${already_done[0]} -ne 1 ]; then							#	offer the user to enter a new color on position 1 and so on
		read -p " new first color: " firstColor
	fi

	if [ ${already_done[1]} -ne 1 ]; then
		read -p " new second color: " secondColor
	fi

	if [ ${already_done[2]} -ne 1 ]; then
		read -p " new third color: " thirdColor
	fi

	if [ ${already_done[3]} -ne 1 ]; then
		read -p " new fourth color: " fourthColor
	fi

	##########################################
	#	check, if we've scored four points
	##########################################
	if [ $points -eq 4 ]; then
		echo "Very good."
		break
	fi
done

if [ $points -ne 4 ]; then
	echo "solution: ${color_holder[*]}"
fi
