#!/bin/bash

source env.bash

	TLD=$(echo $DOMAIN | cut -d. -f2-)
	WHOIS=$(grep -w ^$TLD whois_server.txt | cut -d ' ' -f2)
	timeout 2 whois -h $WHOIS "domain "$DOMAIN"" | grep "   " | grep -v "Status:" | tr ':' '=' | tr -d ' ' | tr '[a-z]' '[A-Z]' > whois.bash
	REGIST=$(cat whois.bash | grep WHOISSERVER | cut -d= -f2)
	timeout 2 whois -h $REGIST $DOMAIN | grep : | grep -w '^Admin City\|^Admin Country\|^Registrant Organization\|^Registrant Name' | tr [a-z] [A-Z] | sed 's/\ /_/' | sed 's/:/=("/' | tr -d ' ' | sed 's/$/")/' | tr '/' '_' >> whois.bash;
