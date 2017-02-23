	source env.bash
	# fetching the data from whois
	whois $DOMAIN | grep : | grep -w '^Tech\|^Registrant\|^Creation\|^Admin' | tr [a-z] [A-Z] | sed 's/\ /_/' | sed 's/:/=("/' | tr -d ' ' | sed 's/$/")/' | tr '/' '_' >> env.bash;