#!/bin/bash
while [ TRUE ]; do
	read -p "Enter Username 1:" USER1
	if [ -z $USER1 ]; then
    	echo "Please Enter A Valid Username."
	else
    	EXUSER=$(cat /etc/passwd | cut -d ":" -f 1 | grep -w "$USER1")
    	echo $EXUSER
    	if [[ "$EXUSER" == "$USER1" ]]; then
        	echo "User Exists, please enter a unique username"
    	else
        	useradd -m $USER1
        	ALPHA='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
        	ALPHACHAR=$(echo $ALPHA | fold -w 4 | shuf | head -1)
        	SPEC='!@#$%^&*()_'
        	SPECCHAR=$(echo $SPEC | fold -w1 | shuf | head -1)
        	PASSWORD=India${ALPHACHAR}${SPECCHAR}$RANDOM
        	chown $USER1:$USER1 /home/$USER1
        	echo "$USER1:$PASSWORD" | sudo chpasswd
        	echo "User $USER1 and password is $PASSWORD sucessfully created..!!"
        	passwd -e $USER1
    	fi
	fi
done
