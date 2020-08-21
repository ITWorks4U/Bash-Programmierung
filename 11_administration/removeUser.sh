#!/bin/bash
#--- script to remove a user from the system

#--- check, if you're the root
if [ $(id -u) -eq 0 ]; then
	read -p "enter user account to remove: " userName

	egrep "^$userName" /etc/passwd > /dev/null
	if [ $? -eq 0 ]; then
		#deluser --force --remove-all-files $userName
		userdel -rf $userName
	else
		echo "The given user account doesn't exist."
		exit 2
	fi


else
	echo "You're not the super user!"
	exit 1
fi
