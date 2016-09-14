#!/bin/bash

	source env.bash

taxonomy(){		
		echo -e "1~did not go through at least 4 tests~"$SCORE_CHECKS""
		echo -e "2~top5 upstream sites contribute more than 90% of traffic~"$SCORE_UPSTREAM""
		echo -e "3~top upstream sites not include top sites~"$SCORE_UPSTREAMCHECK""
		echo -e "4~WOT trust is below 50~"$SCORE_TRUST""
		echo -e "5~top5 keywords contribute more than 90% of traffic~"$SCORE_TOPKEYWORDS""
		echo -e "6~search contribute less than 1% of all traffic~"$SCORE_SEARCH""
		echo -e "7~more than 8 pageviews on average~"$SCORE_PAGEVIEWS""
		echo -e "8~less than 2 years old~"$SCORE_YEARS""
		echo -e "9~is using a privacy guard~"$SCORE_PRIVACY""
		echo -e "10~has an average bounce rate lower than 10%~"$SCORE_BOUNCERATE""
}

menu_item(){
	echo -e "          <ul class='"nav nav-sidebar"'>"
	echo -e "            <li class=active><a href=scorecard.html>scorecard<span class=sr-only>(current)</span></a></li>"
	echo -e "            <li><a href=inputs.html>inputs</a></li>"
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
	