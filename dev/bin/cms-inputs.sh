#!/bin/bash

	source env.bash

taxonomy(){
	echo -e "1~Domain~$DOMAIN"
	echo -e "2~Years from the first registration~"$WHOIS_YEARS"~Whois"
	echo -e "3~Daily programmatic ad revenue potential~"$DAILY_EARNINGS"~Similarweb (computed)"
	echo -e "4~Traffic growth trend~"$TRAFFIC_TREND"~Similarweb (computed)"
	echo -e "5~Domain is using whois privacy guard~"$WHOIS_PRIVACY"~Whois"
	echo -e "6~Links to the domain~"$ALEXA_INLINKS"~Alexa"
	echo -e "7~Global rank~"$ALEXA_RANK"~Alexa"
	echo -e "8~Average time on site~"$ALEXA_TIMEONSITE"~Alexa"
	echo -e "9~Average pageviews~"$ALEXA_PAGEVIEWS"~Alexa"
	echo -e "10~Bouncerate~"$ALEXA_BOUNCERATE"~Alexa"
	echo -e "11~Bouncerate~"$SW_BOUNCERATE"~Similarweb"
	echo -e "12~% share of search visits~"$ALEXA_SEARCHVISITS"~Alexa"
	echo -e "13~top5 keywords' share of all search traffic~"$ALEXA_TOPKEYWORDS"~Alexa (computed)"
	echo -e "14~paid search traffic's share of all search~"$SW_PAID_REFERRALS"~Similarweb"
	echo -e "15~Trust~"$WO_TRUST"~Web of Trust"
	echo -e "16~Childsafety~"$WO_CHILDSAFETY"~Web of Trust"
	echo -e "17~top5 inbound traffic share of all referrals~"$TOP5_UPSTREAM"~Alexa"
	echo -e "18~the top inbound traffic source~"$SITES_UPSTREAM"~Alexa"
	echo -e "19~Loadspeed~"$ALEXA_LOADSPEED"~Alexa"
	echo -e "20~Registrant email~"$REGISTRANT_EMAIL"~Whois"
}

menu_item(){
	echo -e "          <ul class='"nav nav-sidebar"'>"
	echo -e "            <li><a href=scorecard.html>scorecard</a></li>"
	echo -e "            <li class=active><a href=inputs.html>inputs<span class=sr-only>(current)</span></a></li>"
	echo -e "          </ul>"
	echo -e "        </div>"
}

create_row(){
	echo -e "        <div class='"col-md-offset-2 main"'>"
	echo -e "          <div class='"row placeholders"'>"
}

domain(){
	echo -e "            <div class='"col-xs-4 col-sm-3 placeholder"'>"
	echo -e "          <h2>"$DOMAIN"</h2>"
	echo -e "              <span class="text-muted"><a href=http://"$DOMAIN" target="_blank">visit site</a></span>"
	echo -e "            </div>"
}

scoring(){
	echo -e "            <div class='"col-sm-5 placeholder"'>"
	SCORING=$(echo -e "scale=2; 1 - ($CHECK_TRUE / $CHECKS_TOTAL)" | bc -l | sed 's/.//' | sed 's/.00/100/')
	echo -e "				<h1>"$SCORING"</h1>"
}

summary(){
	SUMMARY=$(echo -e "failed $CHECK_TRUE out of $CHECKS_TOTAL checks")
	echo -e "              <span class="text-muted">"$SUMMARY"</span>"
	echo -e "            </div>"
	echo -e "            <div>"
}

scoring_reference(){

	## creating the scoring reference

	ZEROZEROFOUR=50
	ZEROZEROTHREE=50
	ZEROZEROTWO=70
	ZEROZEROONE=90

	if [ $SCORING -le $ZEROZEROFOUR ]
		then
			echo -e "   		<div class="holder-image"><img class="meter-image" src="./graphics/004.jpeg"></div>"
			echo -e "              <span class="text-muted">not safe to buy</span></div>"
		elif [ $SCORING -ge $ZEROZEROONE ]
			then
			echo -e "   		<div class="holder-image"><img class="meter-image" src="./graphics/001.jpeg"></div>"
			echo -e "              <span class="text-muted">may be safe to buy</span>"
		elif [ $SCORING -ge $ZEROZEROTWO ]
			then
			echo -e "   		<div class="holder-image"><img class="meter-image" src="./graphics/002.jpeg"></div>"
			echo -e "             <span class="text-muted">likely to have issues</span>"
		elif [ $SCORING -ge $ZEROZEROTHREE ]
			then
			echo -e "   		<div class="holder-image"><img class="meter-image" src="./graphics/003.jpeg"></div>"
			echo -e "              <span class="text-muted">high risk</span>"
		fi 

	echo -e "            </div>"	
	echo -e "          </div>"
	echo -e "         </div>"

}

main_content(){
	echo -e "				<div class='col-md-offset-2 main'>"
	echo -e "				<div class="row">"
	echo -e "				<div class="col-sm-12">"
	echo -e "				<table class='table table-striped'>"
	echo -e "              <thead>"
	echo -e "                <tr>"
	echo -e "                  <th widht="3%">ID</th>"
	echo -e "                  <th widht="20%">Item</th>"
	echo -e "                  <th>Value</th>"
	echo -e "                  <th>Source</th>"
	echo -e "                </tr>"
	echo -e "              </thead>"
	echo -e "              <tbody>"

while read ITEM
	do
		ID=$(echo "$ITEM" | cut -d '~' -f1)
		NAME=$(echo "$ITEM" | cut -d '~' -f2)
		RESULT=$(echo "$ITEM" | cut -d '~' -f3)
		SOURCE=$(echo "$ITEM" | cut -d '~' -f4)

		echo -e "                <tr>"
		echo -e "                  <td>"$ID"</td>"
		echo -e "                  <td>"$NAME"</td>"
		echo -e "                  <td><b>"$RESULT"</b></td>"
		echo -e "                  <td><i>"$SOURCE"</i></td>"
		echo -e "                </tr>"

done <taxonomy_data.temp

	echo -e "\n"
}

	## P R O G R A M   S T A R T S

	cat ./templates/header.html			# builds the header of the page
	taxonomy > taxonomy_data.temp
	menu_item
	create_row
	domain
	scoring
	summary
	scoring_reference
	main_content
	cat ./templates/footer.html 			# builds the footer of the page
