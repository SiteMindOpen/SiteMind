#!/bin/bash

TARGET=/var/www/html
USERNAME=$1
TEMP=/tmp/removeuser.temp

cut -d ':' -f1 /etc/apache2/.htpasswd > $TEMP
	
	if [ -z $USERNAME ]; then 
		echo -e "USAGE: sm-user-rm <username>"
	else
		MATCH=$(cat $TEMP | grep -wi $USERNAME)
		
		if [ -z $MATCH ]; then	
			echo -e "No such user found."
		else
		
			read -r -p "Are you sure you want to delete user "$USERNAME"? [y/N] " response
			case $response in
    				[yY][eE][sS]|[yY]) 
        				rm -R "$TARGET"/"$USERNAME";
                        		htpasswd -D /etc/apache2/.htpasswd $USERNAME;
    		    			;;
    				*)
        				echo -e "User terminated the process."
        				;;
			esac
		fi
	fi

rm /tmp/removeuser.temp
