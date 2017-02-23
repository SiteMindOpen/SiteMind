#!/bin/bash

## creating the environment variables for the script
	
BACKUP=~/backup/
PUBLIC=/var/www/html
DEV=/var/www/html/dev/
LOG=/var/log/sitemind
AUTHFILE=/etc/apache2/.htpasswd
DATE=$(date +%s)

	## take the backup of the whole system 

	rsync -a $PUBLIC $BACKUP/"$DATE" >> $LOG/backup.log
	
	## syncing user folders with dev

	cut -d ':' -f1 $AUTHFILE | grep -v dev | grep -v sitemind | grep -v admin > backup.temp

	while read $USER
		do
			rsync -av $DEV $PUBLIC/$USER
			DATE=$(date +%s)
			echo -e "$USER succesfully updated on $DATE." >> $LOG/sync.log
		done <backup.temp

	rm backup.temp
