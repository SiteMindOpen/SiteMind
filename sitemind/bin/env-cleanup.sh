cat env.bash | grep _ | sed 's/ENGAGEMENTS=("BOUNCERATE:/BOUNCERATE=("/' | tr -d '"()' | sed 's/REFERRALS=DESTINATION:SITE:/REFERRALSIN=/'| sed 's/SW_REFERRALS=SITE:/SW_REFERRALSOUT=/' | sed 's/SW_________SW.PRELOADEDDATA_=_OVERVIEW=DATE:/SW_DATE=/' | sed 's/=COUNT:/=/' | sed 's/SW_DATA=/SW_TOPADNETWORK=/' | sed 's/SW_TRAFFICSOURCES=SEARCH:/SW_SEARCH=/' | sed 's/STATE\/PROVINCE/STATE_PROVINCE/' | grep -v "="$  > env.temp
cp env.temp env.bash