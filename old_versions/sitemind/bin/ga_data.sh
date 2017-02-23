#!/bin/bash
	source env.bash
	# gets the analytics ID and then finds out if there are more sites using the same 
	GA=$(curl -s https://w3bin.com/domain/"$DOMAIN" -s -m 3 --retry 2 | grep "#analytics" | cut -d '>' -f3 | cut -d '<' -f1); echo -e "GA=$GA" >> env.bash
	#if [ -n $GA ]
	#	then 
	#	curl -s https://w3bin.com/analytics/"$GA" -s -m 3 --retry 2 > ga_data.temp
	#fi 
