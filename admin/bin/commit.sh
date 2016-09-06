#!/bin/bash

DATE=`date +%d%m%y`
mkdir ~/backup/commit_"$DATE"/
BACKUP=~/backup/commit_"$DATE"/

	rsync -av /var/www/html/dev $BACKUP
	rsync -av /var/www/html/admin $BACKUP
	rsync -av /var/www/html/sitemind/bin $BACKUP/sitemind
	rsync -av /var/www/html/sitemind/s33r.sh $BACKUP/sitemind
	rsync -av /var/www/html/sitemind/hello.sh $BACKUP/sitemind
	rsync -av /var/www/html/README.md $BACKUP
