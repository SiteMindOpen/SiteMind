	source env.bash
	
# fetching the data from WOT
	
	python bin/wo_data.py $DOMAIN | tr 'u' '\n' | tr -d "{}[],'" | grep [0-9] | sed 's/^0:\ /WO_TRUST=("/' | sed 's/^4:\ /WO_CHILDSAFETY=("/'| sed 's/101:\ /WO_MALWARE=("/' | sed 's/103:\ /WO_PHISHING=("/' | sed 's/104:\ /WO_SCAM=("/' | sed 's/105:\ /WO_ILLEGAL=("/' | sed 's/201:\ /WO_MISLEADING=("/' | sed 's/202:\ /WO_PRIVACYRISK=("/' | sed 's/203:\ /WO_SUSPICIOUS=("/' | sed 's/204:\ /WO_HATE=("/' | sed 's/205:\ /WO_SPAM=("/' | sed 's/206:\ /WO_UNWANTEDINSTALLATION=("/' | sed 's/207:\ /WO_POPUPS=("/' | grep WO_ | sed 's/$/")/' | tr ' ' ',' | sed 's/,"/"/' >> env.bash;
