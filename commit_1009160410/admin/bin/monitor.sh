#!/bin/bash

LOG1=/var/log/apache2/access.log
LOG2=/var/log/apache2/error.log
GRAB=form_process.php
TEMP=/var/www/html/admin/monitor.temp

# creating the key metrics for the table in the /admin dashboard

		USERS=$(grep $GRAB $LOG1 | cut -d '-' -f2 | cut -d ' ' -f2 | wc -l);
		UNIQUE=$(grep $GRAB $LOG1 | cut -d '-' -f2 | cut -d ' ' -f2 | sort -u | wc -l);
		MOSTACTIVE=$(grep $GRAB $LOG1 | cut -d '-' -f2 | cut -d ' ' -f2 | sort | uniq -c | sort -nr | rev | cut -d ' ' -f1 | rev);

		echo -e "$USERS	$UNIQUE	$MOSTACTIVE \n"
# creating the error log entries for the table in the /admin dashboard

grep /var/www/html/ $LOG2 | grep line | sort | uniq -c | sort -nr | sed 's/$\ //' | tr -s ' ' > $TEMP

while read ITEM; 
	do	
		# get the count
		COUNT=$(echo $ITEM | cut -d ' ' -f1);
		
		# get the url 
		FILE=$(echo $ITEM | cut -d ' ' -f2- | sed $'s/\/var/\\n\/var/' | grep /var/ | cut -d ':' -f1);
	
		# get the line number
		LINE=$(echo $ITEM | grep -o -P '(?<=line ).*(?=:)' | cut -d: -f1);
		
		# get the code snippet
		
		NUMBER=$(expr $LINE + 2)
		echo -e ""
		head -n $NUMBER $FILE | tail -4
			
		echo -e "$COUNT	$FILE	$LINE"		
done <$TEMP
rm $TEMP
