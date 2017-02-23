#!/bin/bash

	# DATA preparation

	bin/api-fetch.sh 		# fetching data from sources
	bin/env-cleanup.sh 		# cleans up the environment file
	bin/api-build.sh		# build the API output
	bin/env-cleanup.sh 		# cleans up the environment file
	bin/score-compute.sh 		# compute the scores for the dashboard
	./data-export.sh		# export to csv format
	./data-cms.sh			# prepare the data for the UI 


	# UI build

	cms/cms-scorecard.sh > scorecard.html	# build the scorecard view on the dashboard
	cms/cms-overview.sh > overview.html	# build the overview reporting view for the dashboard
	cms/cms-traffic.sh > traffic.html      	# build the traffic reporting view for the dashboard
	cms/cms-upstream.sh > upstream.html     # build the upstream reporting view for the dashboard
	cms/cms-report.sh > report.html		# build the export view (NOTE: it's hidden from the menu)
	
	# F I N I S H   C L E A N U P 
	
	rm *.temp *.bash *.csv
