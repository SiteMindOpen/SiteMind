OUT=/tmp/sm-analytics.temp


header_row(){
	echo -e " "
        echo -e "+------------------------------+"
        echo -e "| Sitemind Usage Stats         |"
        echo -e "+------------------------------+"
        echo -e " "
}

total_searches(){

	TOTAL_SEARCHES=$(cat /var/log/apache2/access.log | grep sitemind | grep POST | grep -v testing | wc -l)
	echo -e " "
	echo -e "  Total Searches : $TOTAL_SEARCHES"
	echo -e " "
}

total_users(){

        TOTAL_USERS=$(cat /var/log/apache2/access.log | grep sitemind | grep -v testing | grep POST | cut -d '"' -f2 | cut -d/ -f3 | sort | uniq -c | sort -nr | wc -l)
        echo -e "  Total Users : $TOTAL_USERS"
        echo -e " "
}

total_pageviews(){

        TOTAL_PAGEVIEWS=$(cat /var/log/apache2/access.log | grep sitemind | grep -v testing | grep GET | cut -d '"' -f2 | cut -d/ -f4 | grep .html | wc -l)
        echo -e "  Total Pageviews : $TOTAL_PAGEVIEWS"
        echo -e " "
}


top_user(){

	echo -e " "
	echo -e "+------------------------------+"
	echo -e "| Number of Searchers per User |"
	echo -e "+------------------------------+"
	echo -e " "

	cat /var/log/apache2/access.log | grep sitemind | grep -v testing | grep POST | cut -d '"' -f2 | cut -d/ -f3 | sort | uniq -c | sort -nr

}

top_view(){

	echo -e " "
	echo -e "+------------------------------+"
	echo -e "| Most common dashboard views  |"
	echo -e "+------------------------------+"
	echo -e " "

	cat /var/log/apache2/access.log | grep sitemind | grep -v testing | grep GET | cut -d '"' -f2 | cut -d/ -f4 | grep .html | cut -d ' ' -f1 | sort | uniq -c | sort -nr
	echo -e " "
}

header_row
total_searches
total_users
total_pageviews
top_user
top_view

#rm /var/log/apache2/access.log


