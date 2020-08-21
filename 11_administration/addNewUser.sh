#!/bin/bash
#--- script to create a new user to the system

#--- check, if you're the root
if [ $(id -u) -eq 0 ]; then
	read -p "add new user name: " userName
	read -p "user password: " passWd

	egrep "^$userName" /etc/passwd > /dev/null
	if [ $? -eq 0 ]; then
		echo "user name already exists"
		exit 2
	else
		encrPasswd=$(perl -e 'print crypt($ARGV[0], "password")' $passWd)
		useradd -mp $encrPasswd $userName

		if [ $? -eq 0 ]; then
			echo "Added new user to the system."
		else
			echo "Failed to add a new user to the system."
			exit 3
		fi
	fi

else
	echo "You're not user root."
	exit 1
fi
