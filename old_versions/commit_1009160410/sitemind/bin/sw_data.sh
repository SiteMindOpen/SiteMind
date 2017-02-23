	source env.bash
	# fetching raw data from SIMILARWEB
	curl https://www.similarweb.com/website/"$DOMAIN" -s -m 3 --retry 2 | grep "Sw.preloadedData" | tr ',' '\n' | grep ....... | grep -v ^{ | tr -d '[]{}"' | grep -v Value | tr [a-z] [A-Z] | grep : | sed 's/:/=("/' | sed 's/$/")/' | tr ' ' '_' | sed 's/^/SW_/' | tr '-' '_'  >> env.bash;
