#!/bin/bash

	source env.bash

taxonomy(){		
		echo -e "did not go through at least 4 tests~"$SCORE_CHECKS""
		echo -e "top5 upstream sites contribute more than 90% of traffic~"$SCORE_UPSTREAM""
		echo -e "top upstream sites not include top sites~"$SCORE_UPSTREAMCHECK""
		echo -e "WOT trust is below 50~"$SCORE_TRUST""
		echo -e "top5 keywords contribute more than 90% of traffic~"$SCORE_TOPKEYWORDS""
		echo -e "search contribute less than 1% of all traffic~"$SCORE_SEARCH""
		echo -e "more than 8 pageviews on average~"$SCORE_PAGEVIEWS""
		echo -e "less than 2 years old~"$SCORE_YEARS""
		echo -e "is using a privacy guard~"$SCORE_PRIVACY""
		echo -e "has an average bounce rate lower than 10%~"$SCORE_BOUNCERATE""
		echo -e ""
		echo -e "Whois privacy is on~$WHOIS_PRIVACY~whois"
		echo -e "Age of domain in years~$WHOIS_YEARS~whois"
		echo -e "Domain Admin Country~$ADMIN_COUNTRY~whois"
		echo -e "Domain Admin City~$ADMIN_CITY~whois"
		echo -e "Trust~$WOT_TRUST~WoT"
		echo -e "Childsafety~$WOT_CHILDSAFETY~WoT"
		echo -e "Number of links to the site~$ALEXA_INLINKS~Alexa"
		echo -e "Average loadspeed of the site~$ALEXA_LOADSPEED~Alexa"
		echo -e ""
		echo -e "Global rank~$ALEXA_RANK~Alexa"
		echo -e "Pageviews per visit~$ALEXA_PAGEVIEWS~Alexa"
		echo -e "Bouncerate (%)~$ALEXA_BOUNCERATE~Alexa"
		echo -e "Average visit length~$ALEXA_TIMEONSITE~Alexa,"
		echo -e "Traffic from top keywords (%)~$ALEXA_TOPKEYWORDS~Alexa"
		echo -e "Traffic from search (%)~$ALEXA_SEARCHVISITS~Alexa"
		echo -e "Traffic from top countries (%)~$ALEXA_TOPCOUNTRIES~Alexa"
		echo -e ""
		echo -e "Traffic from top5 inbound (%)~$TOP5_UPSTREAM~Alexa"
		echo -e "Traffic from <b>$ALEXA_UPSTREAM1N</b> (1.)~$ALEXA_UPSTREAM1~Alexa"
		echo -e "Traffic from <b>$ALEXA_UPSTREAM2N</b> (2.)~$ALEXA_UPSTREAM2~Alexa"
		echo -e "Traffic from <b>$ALEXA_UPSTREAM3N</b> (3.)~$ALEXA_UPSTREAM3~Alexa"
		echo -e "Traffic from <b>$ALEXA_UPSTREAM4N</b> (4.)~$ALEXA_UPSTREAM4~Alexa"
		echo -e "Traffic from <b>$ALEXA_UPSTREAM5N</b> (5.)~$ALEXA_UPSTREAM5~Alexa"	
}

menu_item(){
	echo -e "          <ul class='"nav nav-sidebar"'>"
	echo -e "            <li class="active"><a href=scorecard.html>scorecard</a></li>"
	echo -e "            <li><a href=overview.html>overview<span class=sr-only>(current)</span></a></li>"
	echo -e "            <li><a href=traffic.html>traffic</a></li>"
	echo -e "            <li><a href=upstream.html>upstream</a></li>"
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
			echo -e "   		<div class="holder-image"><img class="meter-image" src="cms/graphics/004.jpeg"></div>"
			echo -e "              <span class="text-muted">not safe to buy</span></div>"
		elif [ $SCORING -ge $ZEROZEROONE ]
			then
			echo -e "   		<div class="holder-image"><img class="meter-image" src="cms/graphics/001.jpeg"></div>"
			echo -e "              <span class="text-muted">may be safe to buy</span>"
		elif [ $SCORING -ge $ZEROZEROTWO ]
			then
			echo -e "   		<div class="holder-image"><img class="meter-image" src="cms/graphics/002.jpeg"></div>"
			echo -e "             <span class="text-muted">likely to have issues</span>"
		elif [ $SCORING -ge $ZEROZEROTHREE ]
			then
			echo -e "   		<div class="holder-image"><img class="meter-image" src="cms/graphics/003.jpeg"></div>"
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
	echo -e "              <tbody>"

while read FLAG
	do
		ID=$(echo "$FLAG" | cut -d '~' -f1)
		NAME=$(echo "$FLAG" | cut -d '~' -f2)
		RESULT=$(echo "$FLAG" | cut -d '~' -f3)

		echo -e "                <tr>"
		echo -e "                  <td>"$ID"</td>"
		echo -e "                  <td>"$NAME"</td>"
		echo -e "                  <td>"$RESULT"</td>"
		echo -e "                </tr>"

	done <taxonomy_data.temp

	echo -e "\n"
}

	## P R O G R A M   S T A R T S

	cat cms/templates/header.html			# builds the header of the page
	taxonomy > taxonomy_data.temp
	menu_item
	create_row
	domain
	scoring
	summary
	scoring_reference
	main_content
	cat cms/templates/footer.html 			# builds the footer of the page
	
