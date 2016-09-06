#!/bin/bash

	source env.bash
	
score_years(){

	if [ -n "$WHOIS_YEARS" ] 
		then
			TRESHOLD=2; if [ $WHOIS_YEARS -gt $TRESHOLD ]; then SCORE_YEARS="false" && CHECK_FALSE=$(($CHECK_FALSE+1)); else SCORE_YEARS="true" && CHECK_TRUE=$(($CHECK_TRUE+1)); fi	
		fi
}
score_privacy(){
	if [ -n "$WHOIS_PRIVACY" ] 
		then		
			TRESHOLD=false; if [ $WHOIS_PRIVACY = $TRESHOLD ]; then SCORE_PRIVACY="false" && CHECK_FALSE=$(($CHECK_FALSE+1)); else SCORE_PRIVACY="true" && CHECK_TRUE=$(($CHECK_TRUE+1)); fi
		fi
}
score_bouncerate(){
	if [ -n "$ALEXA_BOUNCERATE" ] 
		then
			TEMP_BOUNCERATE=$(echo $ALEXA_BOUNCERATE| cut -d '.' -f1)		
			TRESHOLD=10; if [ $TEMP_BOUNCERATE -gt $TRESHOLD ]; then SCORE_BOUNCERATE="false" && CHECK_FALSE=$(($CHECK_FALSE+1)); else SCORE_BOUNCERATE="true" && CHECK_TRUE=$(($CHECK_TRUE+1)); fi
		fi
}
score_pageviews(){
	if [ -n "$ALEXA_PAGEVIEWS" ] 
		then
			TEMP_PAGEVIEWS=$(echo $ALEXA_PAGEVIEWS | cut -d '.' -f1)	
			TRESHOLD=8;	if [ $TRESHOLD -gt $TEMP_PAGEVIEWS ]; then SCORE_PAGEVIEWS="false" && CHECK_FALSE=$(($CHECK_FALSE+1)); else SCORE_PAGEVIEWS="true" && CHECK_TRUE=$(($CHECK_TRUE+1)); fi
		fi
}
score_search(){
	if [ -n "$ALEXA_SEARCHVISITS" ] 
		then
			TEMP_SEARCH=$(echo $ALEXA_SEARCHVISITS | cut -d '.' -f1 | tr -s '.')	
			TRESHOLD=1;	if [ $TEMP_SEARCH -gt $TRESHOLD ]; then SCORE_SEARCH="false" && CHECK_FALSE=$(($CHECK_FALSE+1)); else SCORE_SEARCH="true" && CHECK_TRUE=$(($CHECK_TRUE+1)); fi
		fi
}

score_topkeywords(){
	if [ -n "$ALEXA_TOPKEYWORDS" ] 
		then
			TEMP_TOPKEYWORDS=$(echo $ALEXA_TOPKEYWORDS | cut -d '.' -f1)
			TRESHOLD=90; if [ $TEMP_TOPKEYWORDS -ge $TRESHOLD ]; then SCORE_TOPKEYWORDS="true" && CHECK_TRUE=$(($CHECK_TRUE+1)); else SCORE_TOPKEYWORDS="false" && CHECK_FALSE=$(($CHECK_FALSE+1)); fi
			CHECKS=$(($CHECKS+1));
		fi
}

score_trust(){

	if [ -n "$WO_TRUST" ] 
		then
			TEMP_TRUST=$(echo $WO_TRUST | cut -d ',' -f1)	
			TRESHOLD=50; if [ $TEMP_TRUST -gt $TRESHOLD ]; then SCORE_TRUST="false" && CHECK_FALSE=$(($CHECK_FALSE+1)); else SCORE_TRUST="true" && CHECK_TRUE=$(($CHECK_TRUE+1)); fi
		fi
}

score_upstreamcheck(){

	if [ -n "$ALEXA_UPSTREAM1N" ] 
		then	
			UPSTREAMCHECK=$(echo -e "$ALEXA_UPSTREAM1N,$$ALEXA_UPSTREAM2N,$ALEXA_UPSTREAM3N,$ALEXA_UPSTREAM4N,$ALEXA_UPSTREAM5N" | egrep -w 'google|facebook|yahoo|twitter|instagram|linkedin|youtube|baidu')
			if [ -z "$UPSTREAMCHECK" ]; then SCORE_UPSTREAMCHECK="true" && CHECK_TRUE=$(($CHECK_TRUE+1)); else SCORE_UPSTREAMCHECK="false" && CHECK_FALSE=$(($CHECK_FALSE+1)); fi
		fi
}

score_upstrean(){

	if [ -n "$TOP5_UPSTREAM" ] 
		then	
			TEMP_TOPUPSTREAM=$(echo $TOP5_UPSTREAM | cut -d '.' -f1)	
			TRESHOLD=90; if [ $TEMP_TOPUPSTREAM -gt $TRESHOLD ]; then SCORE_UPSTREAM="true" && CHECK_TRUE=$(($CHECK_TRUE+1)); else SCORE_UPSTREAM="false" && CHECK_FALSE=$(($CHECK_FALSE+1)); fi
		fi
}

score_checks(){
	if [ -z $CHECK_TRUE ]
		then
		CHECK_TRUE=0
	fi
	CHECKS_TOTAL=$(expr $CHECK_FALSE + $CHECK_TRUE + 1)
	TRESHOLD=4; if [ $CHECKS_TOTAL -lt $TRESHOLD ]; then SCORE_CHECKS="true" && CHECK_TRUE=$(($CHECK_TRUE+1)); else SCORE_CHECKS="false" && CHECK_FALSE=$(($CHECK_FALSE+1)); fi
}
	
	TOP5_UPSTREAM=$(echo -e "scale=2; ($ALEXA_UPSTREAM1 + $ALEXA_UPSTREAM2 + $ALEXA_UPSTREAM3 + $ALEXA_UPSTREAM4)" | sed 's/%//g' | bc -l); echo -e "TOP5_UPSTREAM=$TOP5_UPSTREAM" >> env.bash
	
	score_bouncerate
	score_privacy
	score_years
	score_pageviews
	score_search
	score_topkeywords
	score_trust
	score_upstreamcheck
	score_upstrean
	
	score_checks

	echo -e "SCORE_BOUNCERATE=$SCORE_BOUNCERATE" >> env.bash
	echo -e "SCORE_PRIVACY=$SCORE_PRIVACY" >> env.bash
	echo -e "SCORE_YEARS=$SCORE_YEARS" >> env.bash
	echo -e "SCORE_PAGEVIEWS=$SCORE_PAGEVIEWS" >> env.bash
	echo -e "SCORE_SEARCH=$SCORE_SEARCH" >> env.bash
	echo -e "SCORE_TOPKEYWORDS=$SCORE_TOPKEYWORDS" >> env.bash
 	echo -e "SCORE_TRUST=$SCORE_TRUST" >> env.bash
	echo -e "SCORE_UPSTREAMCHECK=$SCORE_UPSTREAMCHECK" >> env.bash
	echo -e "SCORE_UPSTREAM=$SCORE_UPSTREAM" >> env.bash
	echo -e "SCORE_CHECKS=$SCORE_CHECKS" >> env.bash
	echo -e "CHECKS_TOTAL=$CHECKS_TOTAL" >> env.bash
	echo -e "CHECK_TRUE=$CHECK_TRUE" >> env.bash
	echo -e "CHECK_FALSE=$CHECK_FALSE" >> env.bash
	echo -e "DOMAIN=$DOMAIN" >> env.bash	
