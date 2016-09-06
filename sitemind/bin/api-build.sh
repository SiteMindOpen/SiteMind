#!/bin/bash
	
	source env.bash

	AL=(alexa_data.temp);					# handler for alexa data
	UP=(upstream_data.temp);				# handler for alexa upstream data

	# creating end points for ALEXA stats
	ALEXA_TOPCOUNTRIES=$(grep -e "{title:" $AL | cut -d ':' -f3- | cut -d '"' -f1 | numsum); echo -e "ALEXA_TOPCOUNTRIES=$ALEXA_TOPCOUNTRIES" >> env.bash
	ALEXA_BOUNCERATE=$(grep -e "%  " $AL | colrm 10 | tr -d ":[[:blank:]]:" | head -1); echo -e "ALEXA_BOUNCERATE=$ALEXA_BOUNCERATE" >> env.bash
	ALEXA_SEARCHVISITS=$(grep -e "%  " $AL | colrm 10 | tr -d ":[[:blank:]]:" | tail -1); echo -e "ALEXA_SEARCHVISITS=$ALEXA_SEARCHVISITS" >> env.bash
	ALEXA_RANK=$(grep -e "  </strong>" $AL | colrm 15 | tr -d ":[[:blank:]]:" | sed 's/,//g' | head -1); echo -e "ALEXA_RANK=$ALEXA_RANK" >> env.bash
	ALEXA_PAGEVIEWS=$(grep -e "  </strong>" $AL | colrm 15 | tr -d ":[[:blank:]]:" | grep -e "[0-9]\.[0-9]" | grep -v %); echo -e "ALEXA_PAGEVIEWS=$ALEXA_PAGEVIEWS" >> env.bash
	ALEXA_TIMEONSITE=$(grep -e "  </strong>" $AL | colrm 15 | tr -d ":[[:blank:]]:" | grep -v [.,]); echo -e "ALEXA_TIMEONSITE=$ALEXA_TIMEONSITE" >> env.bash
	ALEXA_TOPKEYWORDS=$(grep -e "topkeywordellipsis" $AL | cut -d '>' -f9 | cut -d '<' -f1 | numsum); echo -e "ALEXA_TOPKEYWORDS=$ALEXA_TOPKEYWORDS" >> env.bash
	ALEXA_INLINKS=$(grep "font-4 box1-r" $AL | cut -d '>' -f2 | cut -d '<' -f1 | sed 's/,//g'); echo -e "ALEXA_INLINKS=$ALEXA_INLINKS" >> env.bash
	ALEXA_LOADSPEED=$(grep "loadspeed-panel-content" $AL | cut -d '(' -f2 | cut -d ')' -f1 | sed 's/[a-z]//g' | sed 's/\ S//' | tr ' ' '\n' | sort -u); echo -e "ALEXA_LOADSPEED=$ALEXA_LOADSPEED" >> env.bash

	ALEXA_MALES=$(grep "Males are" $AL | cut -d '>' -f3 | cut -d '<' -f1 | sed 's/-represented//'); echo -e "ALEXA_MALES=$ALEXA_MALES" >> env.bash
	ALEXA_FEMALES=$(grep "Females are" $AL | cut -d '>' -f3 | cut -d '<' -f1 | sed 's/-represented//'); echo -e "ALEXA_FEMALES=$ALEXA_FEMALES" >> env.bash

	ALEXA_UPSTREAM1N=$(cut -d ' ' -f1 $UP | sed '1!d'); echo -e "ALEXA_UPSTREAM1N=$ALEXA_UPSTREAM1N" >> env.bash
	ALEXA_UPSTREAM2N=$(cut -d ' ' -f1 $UP | sed '2!d'); echo -e "ALEXA_UPSTREAM2N=$ALEXA_UPSTREAM2N" >> env.bash
	ALEXA_UPSTREAM3N=$(cut -d ' ' -f1 $UP | sed '3!d'); echo -e "ALEXA_UPSTREAM3N=$ALEXA_UPSTREAM3N" >> env.bash
	ALEXA_UPSTREAM4N=$(cut -d ' ' -f1 $UP | sed '4!d'); echo -e "ALEXA_UPSTREAM4N=$ALEXA_UPSTREAM4N" >> env.bash
	ALEXA_UPSTREAM5N=$(cut -d ' ' -f1 $UP | sed '5!d'); echo -e "ALEXA_UPSTREAM5N=$ALEXA_UPSTREAM5N" >> env.bash

	ALEXA_UPSTREAM1=$(cut -d ' ' -f2 $UP | sed '1!d'); echo -e "ALEXA_UPSTREAM1=$ALEXA_UPSTREAM1" >> env.bash
	ALEXA_UPSTREAM2=$(cut -d ' ' -f2 $UP | sed '2!d'); echo -e "ALEXA_UPSTREAM2=$ALEXA_UPSTREAM2" >> env.bash
	ALEXA_UPSTREAM3=$(cut -d ' ' -f2 $UP | sed '3!d'); echo -e "ALEXA_UPSTREAM3=$ALEXA_UPSTREAM3" >> env.bash
	ALEXA_UPSTREAM4=$(cut -d ' ' -f2 $UP | sed '4!d'); echo -e "ALEXA_UPSTREAM4=$ALEXA_UPSTREAM4" >> env.bash
	ALEXA_UPSTREAM5=$(cut -d ' ' -f2 $UP | sed '5!d'); echo -e "ALEXA_UPSTREAM5=$ALEXA_UPSTREAM5" >> env.bash

	SITES_UPSTREAM=$(echo -e "$ALEXA_UPSTREAM1N"); echo -e "SITES_UPSTREAM=$SITES_UPSTREAM" >> env.bash
	ALEXA_LOADSPEED=$(grep "loadspeed-panel-content" $AL | cut -d '(' -f2 | cut -d ')' -f1 | sed 's/[a-z]//g' | sed 's/\ S//'); echo -e "ALEXA_LOADSPEED=$ALEXA_LOADSPEED" >> env.bash


whois_privacy(){
	
	WHOIS_NAME_PRIVACY=$(echo $REGISTRANT_NAME | grep -i -E '(protected|private|whois|guard|proxy)' | sed -E 's/[[:blank:]]//g')

	if [[ -z "$WHOIS_NAME_PRIVACY" ]]; then		
		echo -e "WHOIS_PRIVACY=false" >> env.bash
	else	
		echo -e "WHOIS_PRIVACY=true" >> env.bash
	fi

	if [[ -z "$REGISTRANT_NAME" ]]; then
		echo -e "WHOIS_PRIVACY=na" >> env.bash
	fi
}

	WHOIS_PRIVACY=$(whois_privacy); echo -e "WHOIS_PRIVACY=$WHOIS_PRIVACY" >> env.bash;
	WHOIS_YEARS=$(CREATED=$(echo $CREATION_DATE | cut -d '-' -f1); YEAR=$(date +%Y); expr $YEAR - $CREATED 2>/dev/null); echo -e "WHOIS_YEARS=$WHOIS_YEARS" >> env.bash

	if [ -n "$SW_2016_04_01" ]; then
		TRAFFIC_TREND=$(echo -e "scale=2; ($SW_2016_07_01 - $SW_2016_03_01) / $SW_2016_03_01" | bc -l | tr -d '.' | sed 's/$/%/'); echo -e "TRAFFIC_TREND=$TRAFFIC_TREND" >> env.bash
	fi

	if [ -n "$SW_PAGEVIEWS" ]; then
		DAILY_EARNINGS=$(echo -e "scale=2; ($SW_2016_04_01 * $SW_PAGEVIEWS) / 7 / 1000 * 1.5 / 5" | bc -l); echo -e "DAILY_EARNINGS=$DAILY_EARNINGS" >> env.bash
	fi

	if [ -n "$SW_PAID_REFERRALS" ]; then
		SW_PAID_REFERRALS=$(printf "%0.2f\n" $SW_PAID_REFERRALS); echo -e "SW_PAID_SEARCH=$SW_PAID_REFERRALS" >> env.bash
	fi

        if [ -n "$WO_TRUST" ]; then
                WOT_TRUST=$(echo $WO_TRUST | cut -d, -f1); echo -e "WOT_TRUST=$WOT_TRUST" >> env.bash
        fi

        if [ -n "$WO_CHILDSAFETY" ]; then
                WOT_CHILDSAFETY=$(echo $WO_CHILDSAFETY | cut -d, -f1); echo -e "WOT_CHILDSAFETY=$WOT_CHILDSAFETY" >> env.bash
        fi
	
	WOT_TRUSTC=$(echo $WO_TRUST | cut -d, -f2); WOT_CHILDSAFETYC=$(echo $WO_CHILDSAFETY | cut -d, -f2)
	if [ -n "$WOT_TRUSTC" ]; then
		if [ -n "$WOT_CHILDSAFETYC" ]; then
			WOT_CONFIDENCE=$(expr ($WOT_TRUSTC + $WO_CHILDSAFETYC) / 2); echo -e "WOT_CONFIDENCE=$WOT_CONFIDENCE" >> env.bash
		fi
	fi

