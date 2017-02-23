#!/bin/bash

	source env.bash
	export DOMAIN=$DOMAIN

	# api 
	/var/www/html/sitemind/bin/api-fetch.sh 		# fetching data from sources
	/var/www/html/sitemind/bin/env-cleanup.sh 		# cleans up the environment file
	/var/www/html/sitemind/bin/api-build.sh		 	# build the API output
	/var/www/html/sitemind/bin/env-cleanup.sh 		# cleans up the environment file
	
	# scores
	/var/www/html/sitemind/bin/score-compute.sh 		# compute the scores for the dashboard
	
	# fronted build
	/var/www/html/sitemind/bin/cms-scorecard.sh > scorecard.html	# build the scorecard view on the dashboard
	/var/www/html/sitemind/bin/cms-inputs.sh > inputs.html		# build the inputs report view on the dashboard
	/var/www/html/sitemind/bin/cms-overview.sh > overview.html	# build the overview reporting view for the dashboard
	# tidy up
	/var/www/html/sitemind/bin/export-csv.sh		# export to csv format
	/var/www/html/sitemind/bin/finish-cleanup.sh		# remove all the temp files
