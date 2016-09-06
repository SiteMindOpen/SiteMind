#!/bin/bash

GITDIR=~/git/
DATE=`date +%d%m%y`
mkdir ~/backup/commit_"$DATE"/
BACKUP=~/backup/commit_"$DATE"/
VERSION=$(sm-commit-version)

	rsync -av /var/www/html/dev $BACKUP
	rsync -av /var/www/html/admin $BACKUP
	rsync -av /var/www/html/sitemind/bin $BACKUP/sitemind
	rsync -av /var/www/html/sitemind/s33r.sh $BACKUP/sitemind
	rsync -av /var/www/html/sitemind/hello.sh $BACKUP/sitemind
	rsync -av /var/www/html/README.md $BACKUP
	
	rsync -av $BACKUP $GITDIR

	git tag -a "$VERSION" -m "version "$VERSION""
	git add *
	git commit -m "$VERSION commit on "$DATE""
	git push origin master
