#!/bin/bash
# The game "Yahtzee" (German: "Kniffel") written in bash

#--- constants
readonly ALIVE=1														                                                # a state for each sub tuple
readonly CLOSED=0													                                                    # same as above
readonly THREE_OF_A_KIND="ThreeOfAKind"
readonly FOUR_OF_A_KIND="FourOfAKind"
readonly SMALL_STRAIGHT="SmallStraight"
readonly LARGE_STRAIGHT="LargeStraight"
readonly fixedDiceArray=(1 2 3 4 5 6)																					# holds the values of dices in order

readonly AUTHOR="ITWorks4U"
readonly VERSION="1.6"

#--- variables to use
dices=(-1 -1 -1 -1 -1 -1)													                                            # our dices
locked=(0 0 0 0 0 0)												                                                    # a mark which dice has already been checked
points=0														                                                        # count all gotten points

markForSubWins=($ALIVE $ALIVE $ALIVE $ALIVE $ALIVE $ALIVE $ALIVE $ALIVE $ALIVE $ALIVE $ALIVE $ALIVE $ALIVE)              # for each tuple section
tuplesNames=("Aces" "Twos" "Threes" "Fours" "Fives" "Sixes" "Three_Of_a_Kind"
            "Four_Of_a_Kind" "Full_House" "Small_Straight" "Large_Straight" "Yahtzee" "Chance")
nbrOfRounds=0                                                                                                           # there're 13 taks to do (0, 1, ..., 12)
ctrOfShuffles=0                                                                                                         # the player may shuffle the dices up to three times in a row

#--- functions
function onSingleEyes() {
	currentPoints=0

	case $1 in
		1)
			if [ ${markForSubWins[0]} == $ALIVE ]; then
				markForSubWins[0]=$CLOSED

				for i in ${dices[*]}; do
					if [ $i -eq 1 ]; then
						currentPoints=`expr $currentPoints + 1`
					fi
				done
			fi
		;;
		2)
			if [ ${markForSubWins[1]} == $ALIVE ]; then
				markForSubWins[1]=$CLOSED

				for i in ${dices[*]}; do
					if [ $i == 2 ]; then
						currentPoints=`expr $currentPoints + 2`
					fi
				done
			fi
		;;
		3)
			if [ ${markForSubWins[2]} == $ALIVE ]; then
				markForSubWins[2]=$CLOSED

				for i in ${dices[*]}; do
					if [ $i == 3 ]; then
						currentPoints=`expr $currentPoints + 3`
					fi
				done
			fi
		;;
		4)
			if [ ${markForSubWins[3]} == $ALIVE ]; then
				markForSubWins[3]=$CLOSED

				for i in ${dices[*]}; do
					if [ $i == 4 ]; then
						currentPoints=`expr $currentPoints + 4`
					fi
				done
			fi
		;;
		5)
			if [ ${markForSubWins[4]} == $ALIVE ]; then
				markForSubWins[4]=$CLOSED

				for i in ${dices[*]}; do
					if [ $i == 5 ]; then
						currentPoints=`expr $currentPoints + 5`
					fi
				done
			fi
		;;
		6)
			if [ ${markForSubWins[5]} == $ALIVE ]; then
				markForSubWins[5]=$CLOSED

				for i in ${dices[*]}; do
					if [ $i == 6 ]; then
						currentPoints=`expr $currentPoints + 6`
					fi
				done
			fi
		;;
	esac

	return $currentPoints
}

function onOfAKind_N() {
	currentPoints=0
	ctr=0
	tmpVal=0
	diceNumberToUse=0                                                                                                   # the dominant value for our six dices                                                                                                                                                
    howOften=(0 0 0 0 0 0)                                                                                              # determine how often a dice exists

	if [ "$1" == $THREE_OF_A_KIND ]; then
	    if [ ${markForSubWins[6]} == $ALIVE ]; then
	        markForSubWins[6]=$CLOSED
	
	        doubles=(0 0)                                                                                               # may hold up to two three dices with the same 
	    
	        for i in ${dices[*]}; do
	            case $i in
	                1)
	                    howOften[0]=$((howOften[0] + 1));;                                                             # for each 1
	                2)
                        howOften[1]=$((howOften[1] + 1));;                                                             # for each 2
	                3)
        	            howOften[2]=$((howOften[2] + 1));;
	                4)
	                    howOften[3]=$((howOften[3] + 1));;
	                5)
	                    howOften[4]=$((howOften[4] + 1));;
	                6)
	                    howOften[5]=$((howOften[5] + 1));;
                esac
            done
	        
            for ((j=0; j < 6; j++)); do                                                                                # now determine how often a dice exists
                tmpVal=${howOften[j]}                                                                                   # hold the current number
            
                if [ $tmpVal -eq 3 ]; then                                                                             # number of dice j exists three times
                    if [ ${doubles[0]} -eq 0 ]; then                                                                   # check, if doubles[0] has not been set before
                        doubles[0]=${fixedDiceArray[$j]}                                                                # then copy dice number j to doubles[0]
                    elif [ ${doubles[1]} -eq 0 ]; then                                                                 # otherwise check, if doubles[1] has not been set before
                        doubles[1]=${fixedDiceArray[$j]}                                                                # then copy dice number j to doubles[1]
                    fi
                fi
            done
            
            #echo " howOften: ${howOften[*]}"
            #echo " doubles: ${doubles[*]}"
	        
	        if [[ ${doubles[0]} -eq 0 && ${doubles[1]} -eq 0 ]]; then                                                  # there are no three dices with the same value
	            return 0                                                                                               # so leave the function early
            elif [[ ${doubles[0]} -ne 0 && ${doubles[1]} -eq 0 ]]; then                                               # otherwise a single tri-tuple of dices exists
                diceNumberToUse=${doubles[0]}                                                                           # the dominant dice number to use
            else                                                                                                       # or two tri-tuples exists
                if [ ${doubles[0]} -lt ${doubles[1]} ]; then                                                           # check, which one has a higher value
                    diceNumberToUse=${doubles[1]}
                else
                    diceNumberToUse=${doubles[0]}
                fi
            fi
            
            for i in ${dices[*]}; do                                                                                   # take dice i
                if [ $i -eq $diceNumberToUse ]; then                                                                   # and compare with the dominant value
                    currentPoints=$(($currentPoints + $i))
                    ctr=$(($ctr + 1))
                fi
            done

            if [ $ctr -eq 3 ]; then
                return $currentPoints
            fi
        fi
        
	elif [ "$1" == $FOUR_OF_A_KIND ]; then
	    if [ ${markForSubWins[7]} == $ALIVE ]; then
	        markForSubWins[7]=$CLOSED
	
            for i in ${dices[*]}; do
	            case $i in
	                1)
	                    howOften[0]=$((howOften[0] + 1));;
	                2)
                        howOften[1]=$((howOften[1] + 1));;
	                3)
        	            howOften[2]=$((howOften[2] + 1));;
	                4)
	                    howOften[3]=$((howOften[3] + 1));;
	                5)
	                    howOften[4]=$((howOften[4] + 1));;
	                6)
	                    howOften[5]=$((howOften[5] + 1));;
                esac
            done

            #echo " howOften: ${howOften[*]}"

            nbrOfTries=0                                                                                                # count the number of tries
            
	        for ((i=0; i < 6; i++)); do
	            tmpVal=${howOften[i]}
	        
	            if [ $tmpVal -eq 4 ]; then
	                diceNumberToUse=${fixedDiceArray[$i]}
	                break
                else
                    nbrOfTries=$(($nbrOfTries + 1))
	            fi
	        done
	        
	        if [ $nbrOfTries -eq 6 ]; then                                                                             # if the number of tries is 6, then there is no number
	            return 0                                                                                               # which exists exactly four times, thus FOUR_OF_A_KIND returns 0
	        fi
	    
	        for i in ${dices[*]}; do                                                                                   # finally, use every dice
	            if [ $diceNumberToUse -eq $i ]; then                                                                   # and check, if its value is equal to the dominant number
                    currentPoints=$(($currentPoints + $i))
                    ctr=$(($ctr + 1))
	            fi
	        done

		    if [ $ctr -eq 4 ]; then
			    return $currentPoints
		    fi
        fi
	fi

	return 0
}

function onFullHouse() {
    diceHolder=(0 0 0 0 0 0)                                                                                            # holds the amount of all dices 
    fullHouseHolder=(0 0)                                                                                               # holds a full house in binary form, where:
                                                                                                                        # {0,0} or {1,0} or {0,1} := no full house
                                                                                                                        # {1,1} := full house
                                                                                                                        
    if [ ${markForSubWins[8]} == $ALIVE ]; then
        markForSubWins[8]=$CLOSED
                                                                                                                        
        for i in ${dices[*]}; do
            case $i in
                1)
                    diceHolder[0]=$((diceHolder[0] + 1));;
                2)
                    diceHolder[1]=$((diceHolder[1] + 1));;
                3)
                    diceHolder[2]=$((diceHolder[2] + 1));;
                4)
                    diceHolder[3]=$((diceHolder[3] + 1));;
                5)
                    diceHolder[4]=$((diceHolder[4] + 1));;
                6)
                    diceHolder[5]=$((diceHolder[5] + 1));;
            esac
        done
        
        for i in ${diceHolder[*]}; do
            if [ $i -eq 3 ]; then
                fullHouseHolder[0]=1
            elif [ $i -eq 2 ]; then
                fullHouseHolder[1]=1
            fi
        done
        
        if [[ ${fullHouseHolder[0]} -eq 1 && ${fullHouseHolder[1]} -eq 1 ]]; then
            return 25
        fi
    fi

	return 0
}

function onStraight() {
    diceHolder=(0 0 0 0 0 0)
    
    for i in ${dices[*]}; do
        case $i in
            1)
                diceHolder[0]=$((diceHolder[0] + 1));;
            2)
                diceHolder[1]=$((diceHolder[1] + 1));;
            3)
                diceHolder[2]=$((diceHolder[2] + 1));;
            4)
                diceHolder[3]=$((diceHolder[3] + 1));;
            5)
                diceHolder[4]=$((diceHolder[4] + 1));;
            6)
                diceHolder[5]=$((diceHolder[5] + 1));;
        esac
    done

    if [[ ${diceHolder[2]} -eq 0 || ${diceHolder[3]} -eq 0 ]]; then                                                    # {3,4} are required for a small/large straight, means:
        return 0                                                                                                       # if one of these both numbers doesn't exist, then there
    fi                                                                                                                  # is no chance to get a small/large straight anyway
    
    choosenOption=$1                                                                                                    # will hold "SMALL_STRAIGHT" or "LARGE_STRAIGHT"
    counter=0                                                                                                           # start with 0 to count up to four
    
    lowerLimit=0                                                                                                        # will hold the lower bound
    upperLimit=0                                                                                                        # will hold the upper bound for a small straight
    
    if [ "$choosenOption" == $SMALL_STRAIGHT ]; then
        if [ ${markForSubWins[9]} == $ALIVE ]; then
            markForSubWins[9]=$CLOSED
            
            startNumber=${diceHolder[0]}                                                                                # start with the first number (1)
            
            if [ $startNumber -eq 0 ]; then                                                                            # just check, if there's no number 1
                startNumber=${diceHolder[1]}                                                                            # then start with number 2
                
                if [ $startNumber -eq 0 ]; then                                                                        # if there's also no number 2, then use number 3 
                    startNumber=${diceHolder[2]}                                                                        # as last count
                    
                    lowerLimit=2
                    upperLimit=6    
                else
                    lowerLimit=1
                    upperLimit=5
                fi
            elif [[ $startNumber -ne 0 && ${diceHolder[1]} -eq 0 ]] ; then                                             # only if, a small straight {X,Y,3,4,5,6} appears, where
                lowerLimit=2                                                                                            # X,Y are 1 or 3 or 4 or 5 or 6, but there's no 2
                upperLimit=6                                                                                                
            else
                lowerLimit=0
                upperLimit=4
            fi
            
            for ((i=$lowerLimit; i < $upperLimit; i++)); do                                                            # for combination {1,2,3,4} or {2,3,4,5} or {3,4,5,6}
                if [ ${diceHolder[$i]} -ne 0 ]; then
                    counter=$(($counter + 1))
                fi
            done
            
            if [ $counter -eq 4 ]; then
                return 30
            fi
        fi
	elif [ "$choosenOption" == $LARGE_STRAIGHT ]; then
	    if [ ${markForSubWins[10]} == $ALIVE ]; then
	        markForSubWins[10]=$CLOSED
	
            startNumber=${diceHolder[0]}                                                                                # start with the first number (1)
            if [ $startNumber -eq 0 ]; then                                                                            # just check, if there's no number 1
                startNumber=${diceHolder[1]}                                                                            # then start with number 2
                
                lowerLimit=1
                upperLimit=6
            else
                lowerLimit=0
                upperLimit=5
            fi
            
            for ((i=$lowerLimit; i < $upperLimit; i++)); do                                                            # for combination {1,2,3,4,5} or {2,3,4,5,6}
                if [ ${diceHolder[$i]} -ne 0 ]; then
                    counter=$(($counter + 1))
                fi
            done
            
            if [ $counter -eq 5 ]; then
                return 40
            fi
        fi
	fi
	
	return 0
}

function onYahtzee() {
    diceHolder=(0 0 0 0 0 0)
    
    if [ ${markForSubWins[11]} == $ALIVE ]; then
        markForSubWins[11]=$CLOSED
        
        for i in ${dices[*]}; do
            case $i in
                1)
                    diceHolder[0]=$((diceHolder[0] + 1));;
                2)
                    diceHolder[1]=$((diceHolder[1] + 1));;
                3)
                    diceHolder[2]=$((diceHolder[2] + 1));;
                4)
                    diceHolder[3]=$((diceHolder[3] + 1));;
                5)
                    diceHolder[4]=$((diceHolder[4] + 1));;
                6)
                    diceHolder[5]=$((diceHolder[5] + 1));;
            esac
        done

        for i in ${diceHolder[*]}; do
            if [ $i -eq 6 ]; then
                return 50
            fi
        done
    fi
    
	return 0
}

function onChance() {
    currentPoints=0
    
    if [ ${markForSubWins[12]} == $ALIVE ]; then
        markForSubWins[12]=$CLOSED
        
        for i in ${dices[*]}; do
            currentPoints=`expr $currentPoints + $i`
        done
    fi
	
	return $currentPoints
}

function shuffleDices() {
    for ((i=0; i < 6; i++)); do
        dices[i]=`expr $RANDOM % 6 + 1`																					#	get a random number between [1,6]
    done
}

function printCurrentDices() {
	echo -e "\n round `expr $nbrOfRounds + 1`: current shuffled dices: {${dices[*]}}"
}

function convertInput() {
	#echo " #1: ${dices[*]}"																							#	original dices
	
	read -p " Select which dice shall be shuffled again: " word
	
	for ((i = 1; i < 7; i++)); do
		sign=`expr substr $word $i 1`																					#	get the character from position 1 to 6
		
		if [ "$sign" == "0" ]; then																					#	if there's a "0", then
			dices[$i-1]=`expr $RANDOM % 6 + 1`																			#	shuffle this dice[i-1]
		fi
	done

	#echo " #2: ${dices[*]}"																							#	modified dices
}

#--- bonus 1: implementing parameters, like a helping method or print the author or else
function analyzingParameters() {
	case $1 in
		"-h")
				cat helping.txt
			;;
		"-a")
			echo -e " author: ITWorks4U\n It's designed for the programming tutorial \"bash programming\""
			echo " available on YouTube."
			;;
	esac
	
	echo " The program will now terminate."
	exit 0
}

#----- test outputs
#shuffleDices
#echo "points = $points"
#onSingleEyes 1                     (works; same for 2, 3, ..., 6)
#onOfAKind_N $FOUR_OF_A_KIND        (works; same for THREE_OF_A_KIND)
#onFullHouse                        (works)
#onStraight $LARGE_STRAIGHT         (works)
#onYahtzee                          (works)
#onChance                           (works)
#shuffleDices                       (works)

#points=$((points + $?))
#echo "points = $points"

#------	for helping usage
if [ "$1" == "-h" ] || [ "$1" == "-a" ]; then
	analyzingParameters $1
else
	echo " if you need some help, then run the program with -h"
fi

echo
#------	end help

subPoints=0

#--- bonus 2
retries=0																												# the user may reshuffle the dices up to two times

while [ $nbrOfRounds -ne 13 ]; do                                                                                      # repeat 13 times
    shuffleDices                                                                                                        # shuffle the dices
    
    printCurrentDices
    
    #--- bonus 2: offer the user to shuffle the dices again, if the combination is worse
    while [ $retries -lt 2 ]; do
    	read -p " Would you like to shuffle again? <y/n> " answer
    	
    	if [ $answer == 'y' ]; then
    	
    		#--- bonus 3: offer the user to select which dices shall be shuffled again
    		convertInput
    	
    		#--- bonus 2
    		retries=$(($retries + 1))
    		printCurrentDices
    	else
    		retries=0
    		break
    	fi
    done
    
    #--- reset the number of retries, if needed
    if [ $retries -gt 0 ]; then
    	retries=0
    fi
    
	#for option in ${tuplesNames[*]}; do
	#	echo " $option"
	#done
    
    for ((i=0; i < 13; i++)) do
        if [ ${markForSubWins[$i]} == $ALIVE ]; then
            option=${tuplesNames[$i]}
            echo " `expr $i + 1`) $option "
        fi
    done
    
    read -p " select your option: " choosenInput
    #echo " -------> $choosenInput"
   
    case $choosenInput in
        1)
            onSingleEyes 1
        ;;
        2)
            onSingleEyes 2
        ;;
        3)
            onSingleEyes 3
        ;;
        4)
            onSingleEyes 4
        ;;
        5)
            onSingleEyes 5
        ;;
        6)
            onSingleEyes 6
        ;;
        7)
            onOfAKind_N $THREE_OF_A_KIND
        ;;
        8)
            onOfAKind_N $FOUR_OF_A_KIND
        ;;
        9)
            onFullHouse
        ;;
        10)
            onStraight $SMALL_STRAIGHT
        ;;
        11)
            onStraight $LARGE_STRAIGHT
        ;;
        12)
            onYahtzee
        ;;
        13)
            onChance
        ;;
    esac
    
    subPoints=$?
    echo " gotten points: $subPoints"
    
    points=`expr $points + $subPoints`
    echo " sum of all points: $points"
    
    nbrOfRounds=$(($nbrOfRounds + 1))
done
