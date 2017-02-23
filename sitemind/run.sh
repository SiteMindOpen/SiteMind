#!/bin/bash

echo -e "DOMAIN="$1"" > env.bash
cp env.bash domain.bash

sitemind_single(){
	DOMAIN=$1
	./sitemind.sh $DOMAIN
}


sites_to_scan(){
	echo $1 | tr -d ' ' | tr ',' '\n' > sites_to_scan.txt
}

sitemind_scan(){
	while read DOMAIN
	do
		./sitemind.sh $DOMAIN
		echo $DOMAIN		
	done <sites_to_scan.txt
}

## check 1) there is input 2) if there is single or scan input

if [ -z $1 ] ; 
then
	echo "you have to input a valid domain name"
else
	CHECK=$(echo $1 | grep ",")

	if [ -z sites_to_scan.txt ] ; 
	then 
		sitemind_single
	else
		sites_to_scan
		sitemind_scan
	fi
fi	