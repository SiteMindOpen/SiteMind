
	source env.bash

	# fetching the data from ALEXA
	
	humanize(){
		USER_AGENT=$(shuf sitemind.ua | head -1) 
		PROXY=$(shuf sitemind.proxy | head -1)
		WAIT=$(seq 0.9 0.001 1.5 | shuf | head -1)
		sleep $WAIT
	}

	humanize

	wget -F -q --user-agent="$USER_AGENT" http://www.alexa.com/siteinfo/"$DOMAIN" --proxy-user "" --proxy-password "" use_proxy=yes -e http_proxy="$PROXY" -T 5 --tries=2 -O alexa_data.temp