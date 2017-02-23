	source env.bash
	# fetching the daat from ALEXA
	curl -s http://www.alexa.com/siteinfo/"$DOMAIN" -s -m 3 --retry 2 > alexa_data.temp

